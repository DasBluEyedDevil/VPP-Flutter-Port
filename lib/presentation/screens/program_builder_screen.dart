import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../providers/weekly_program_provider.dart';
import '../widgets/program/day_assignment_card.dart';
import '../../data/database/daos/workout_dao.dart';
import '../../data/database/app_database.dart' as database;

/// Program Builder Screen - form to create or edit weekly programs
/// 
/// Matches Kotlin ProgramBuilderScreen exactly with:
/// - Gradient background (conditional on theme: dark vs light)
/// - AppBar with title, Save button (enabled only when name not empty)
/// - Program name TextField with validation
/// - 7-day assignment list (Monday-Sunday)
/// - Save logic (create or update)
/// - Navigation back after save
class ProgramBuilderScreen extends ConsumerStatefulWidget {
  final String programId;

  const ProgramBuilderScreen({
    super.key,
    required this.programId,
  });

  @override
  ConsumerState<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends ConsumerState<ProgramBuilderScreen> {
  late TextEditingController _nameController;
  final Map<int, String?> _dayAssignments = {}; // dayOfWeek (1-7) -> routineId

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // Initialize all days as unassigned (1=Monday, 7=Sunday)
    for (int i = 1; i <= 7; i++) {
      _dayAssignments[i] = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _loadProgramData(WeeklyProgramWithDays? program) {
    if (program != null && _nameController.text.isEmpty) {
      _nameController.text = program.program.name;
      // Clear existing assignments
      for (int i = 1; i <= 7; i++) {
        _dayAssignments[i] = null;
      }
      // Load day assignments
      for (final day in program.days) {
        _dayAssignments[day.dayOfWeek] = day.routineId;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.programId == 'new';
    final programAsync = isNew
        ? const AsyncValue<WeeklyProgramWithDays?>.data(null)
        : ref.watch(programProvider(widget.programId));
    final programActions = ref.watch(weeklyProgramActionsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Load existing program data when available
    programAsync.whenData(_loadProgramData);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF0F172A), // slate-900
                  const Color(0xFF1E1B4B), // indigo-950
                  const Color(0xFF172554), // blue-950
                ]
              : [
                  const Color(0xFFE0E7FF), // indigo-200
                  const Color(0xFFFCE7F3), // pink-100
                  const Color(0xFFDDD6FE), // violet-200
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(isNew ? 'Create Program' : 'Edit Program'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: _canSave ? () => _saveProgram(context, ref, programActions, isNew) : null,
              child: Text(
                'Save',
                style: TextStyle(
                  color: _canSave ? theme.colorScheme.primary : theme.disabledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Program Name Input
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Program Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),

            // 7-Day Assignment List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 7,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final dayOfWeek = index + 1; // 1=Monday, 7=Sunday
                  return DayAssignmentCard(
                    dayOfWeek: dayOfWeek,
                    selectedRoutineId: _dayAssignments[dayOfWeek],
                    onRoutineSelected: (routineId) {
                      setState(() {
                        _dayAssignments[dayOfWeek] = routineId;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _canSave => _nameController.text.trim().isNotEmpty;

  Future<void> _saveProgram(
    BuildContext context,
    WidgetRef ref,
    WeeklyProgramActions actions,
    bool isNew,
  ) async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final programId = isNew ? const Uuid().v4() : widget.programId;

    // Get existing program to preserve createdAt if editing
    WeeklyProgramWithDays? existingProgram;
    if (!isNew) {
      try {
        existingProgram = await ref.read(programProvider(widget.programId).future);
      } catch (e) {
        // Program not found, treat as new
      }
    }

    final program = database.WeeklyProgram(
      id: programId,
      name: name,
      createdAt: existingProgram?.program.createdAt ?? BigInt.from(now),
      lastUsed: BigInt.from(now),
      isActive: existingProgram?.program.isActive ?? false,
    );

    // Build day assignments (only non-null assignments)
    final days = <database.ProgramDay>[];
    for (int dayOfWeek = 1; dayOfWeek <= 7; dayOfWeek++) {
      final routineId = _dayAssignments[dayOfWeek];
      if (routineId != null) {
        days.add(database.ProgramDay(
          id: 0, // Will be auto-generated
          programId: programId,
          routineId: routineId,
          dayOfWeek: dayOfWeek,
        ));
      }
    }

    final programWithDays = WeeklyProgramWithDays(
      program: program,
      days: days,
    );

    try {
      await actions.saveWeeklyProgram(programWithDays);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isNew ? 'Program created' : 'Program updated'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving program: $e')),
        );
      }
    }
  }
}
