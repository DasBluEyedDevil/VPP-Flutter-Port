import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/weekly_program_provider.dart' show weeklyProgramActionsProvider, WeeklyProgramActions, programProvider;
import '../providers/routine_provider.dart' show routinesProvider;
import '../theme/spacing.dart';
import '../../data/database/daos/workout_dao.dart';
import '../../data/database/app_database.dart' as database;

/// Program Builder Screen - form to create or edit weekly programs
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
  final _formKey = GlobalKey<FormState>();
  final Map<int, String?> _dayAssignments = {}; // dayOfWeek -> routineId (null = rest day)

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // Initialize all days as unassigned
    for (int i = 0; i < 7; i++) {
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
      for (int i = 0; i < 7; i++) {
        _dayAssignments[i] = null;
      }
      // Load day assignments
      for (final day in program.days) {
        _dayAssignments[day.dayOfWeek] = day.routineId;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.programId == 'new';
    final programAsync = isNew
        ? const AsyncValue<WeeklyProgramWithDays?>.data(null)
        : ref.watch(programProvider(widget.programId));
    final routinesAsync = ref.watch(routinesProvider);
    final programActions = ref.watch(weeklyProgramActionsProvider);

    // Load existing program data when available
    programAsync.whenData(_loadProgramData);

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Create Program' : 'Edit Program'),
        actions: [
          if (!isNew)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context, ref, programActions),
              tooltip: 'Delete Program',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          children: [
            // Program name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Program Name',
                hintText: 'Enter program name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a program name';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.large),

            // Day assignments section
            Text(
              'Assign Routines to Days',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Select a routine for each day, or leave as rest day',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),

            // Day selection dropdowns
            ...List.generate(7, (index) {
              return _DaySelector(
                dayOfWeek: index,
                selectedRoutineId: _dayAssignments[index],
                routinesAsync: routinesAsync,
                onChanged: (routineId) {
                  setState(() {
                    _dayAssignments[index] = routineId;
                  });
                },
              );
            }),

            const SizedBox(height: AppSpacing.large),

            // Save button
            FilledButton.icon(
              onPressed: () => _saveProgram(context, ref, programActions, isNew),
              icon: const Icon(Icons.save),
              label: const Text('Save Program'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: AppSpacing.small),

            // Cancel button
            OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProgram(
    BuildContext context,
    WidgetRef ref,
    WeeklyProgramActions actions,
    bool isNew,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final routinesAsync = ref.read(routinesProvider);
    final routines = routinesAsync.value;

    if (routines == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading routines')),
      );
      return;
    }

    // Validate that selected routines exist
    for (final routineId in _dayAssignments.values) {
      if (routineId != null && !routines.any((r) => r.id == routineId)) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid routine selected: $routineId')),
        );
        return;
      }
    }

    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final programId = isNew ? now.toString() : widget.programId;
      
      // Get existing program to preserve createdAt if editing
      final existingProgram = isNew
          ? null
          : await ref.read(programProvider(widget.programId).future);

      final program = database.WeeklyProgram(
        id: programId,
        name: _nameController.text.trim(),
        createdAt: existingProgram?.program.createdAt ?? BigInt.from(now),
        lastUsed: BigInt.from(now),
      );

      // Build day assignments (only non-null assignments)
      final days = <database.ProgramDay>[];
      for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
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

      // If editing, delete old days first
      if (!isNew) {
        // The saveProgram method should handle this, but we'll let the repository handle it
        // For now, we'll just save and let CASCADE delete handle old days
      }

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

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    WeeklyProgramActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Program?'),
        content: const Text(
          'Are you sure you want to delete this program? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await actions.deleteWeeklyProgram(widget.programId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Program deleted')),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting program: $e')),
          );
        }
      }
    }
  }
}

class _DaySelector extends StatelessWidget {
  final int dayOfWeek;
  final String? selectedRoutineId;
  final AsyncValue<List<database.Routine>> routinesAsync;
  final ValueChanged<String?> onChanged;

  const _DaySelector({
    required this.dayOfWeek,
    required this.selectedRoutineId,
    required this.routinesAsync,
    required this.onChanged,
  });

  static const List<String> _dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _dayNames[dayOfWeek],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            routinesAsync.when(
              data: (routines) => DropdownButtonFormField<String?>(
                initialValue: selectedRoutineId,
                decoration: const InputDecoration(
                  labelText: 'Routine',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Rest Day'),
                  ),
                  ...routines.map((routine) => DropdownMenuItem<String?>(
                    value: routine.id,
                    child: Text(routine.name),
                  )),
                ],
                onChanged: onChanged,
              ),
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text(
                'Error loading routines: $error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
