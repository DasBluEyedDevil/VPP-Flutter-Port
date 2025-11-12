import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/weekly_program_provider.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/program/program_card.dart';
import '../widgets/program/active_program_card.dart';
import '../theme/spacing.dart';
import '../../data/database/daos/workout_dao.dart';

/// Weekly Programs Screen - displays list of weekly programs with CRUD operations
/// 
/// Matches Kotlin WeeklyProgramsScreen exactly with:
/// - Gradient background (conditional on theme: dark vs light)
/// - Empty state vs program list (conditional rendering)
/// - Screen header "Weekly Programs" (headlineMedium, Bold, 20dp padding)
/// - Active program card at top (if active program exists)
/// - ListView with 8dp spacing between cards
/// - FAB "Create Program" with add icon
class WeeklyProgramsScreen extends ConsumerWidget {
  const WeeklyProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsAsync = ref.watch(weeklyProgramsProvider);
    final programActions = ref.watch(weeklyProgramActionsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
          title: const Text('Weekly Programs'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: programsAsync.when(
          data: (programs) {
            WeeklyProgramWithDays? activeProgram;
            try {
              activeProgram = programs.firstWhere((p) => p.program.isActive);
            } catch (e) {
              activeProgram = null;
            }

            if (programs.isEmpty) {
              return EmptyState(
                icon: Icons.calendar_month,
                title: 'No programs yet',
                message: 'Create your first weekly workout program',
                actionLabel: 'Create Program',
                onAction: () => _navigateToBuilder(context, ref),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Weekly Programs',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Active Program Card (if exists)
                if (activeProgram != null && activeProgram.program.isActive) ...[
                  Builder(
                    builder: (_) {
                      final ap = activeProgram!; // Assert non-null (checked above)
                      return ActiveProgramCard(
                        program: ap,
                        onStartWorkout: () => _startTodaysWorkout(context, ref, ap),
                      );
                    },
                  ),
                ],

                // Program List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88), // FAB clearance
                    itemCount: programs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return ProgramCard(
                        program: programs[index],
                        onTap: () => _navigateToBuilder(context, ref, program: programs[index]),
                        onActivate: () => _activateProgram(ref, programs[index], programActions),
                        onDelete: () => _deleteProgram(context, ref, programs[index], programActions),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: AppSpacing.medium),
                Text('Error loading programs: $error'),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToBuilder(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('Create Program'),
        ),
      ),
    );
  }

  void _navigateToBuilder(BuildContext context, WidgetRef ref, {WeeklyProgramWithDays? program}) {
    if (program != null) {
      context.go(Routes.programBuilderWithId.replaceAll(':programId', program.program.id));
    } else {
      context.go(Routes.programBuilderWithId.replaceAll(':programId', 'new'));
    }
  }

  Future<void> _activateProgram(
    WidgetRef ref,
    WeeklyProgramWithDays program,
    WeeklyProgramActions actions,
  ) async {
    // Deactivate all, then activate selected
    await actions.deactivateAll();
    await actions.activateProgram(program.program.id);
  }

  Future<void> _deleteProgram(
    BuildContext context,
    WidgetRef ref,
    WeeklyProgramWithDays program,
    WeeklyProgramActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Program'),
        content: Text(
          'Are you sure you want to delete "${program.program.name}"? This action cannot be undone.',
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
        await actions.deleteWeeklyProgram(program.program.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Program deleted')),
          );
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

  void _startTodaysWorkout(BuildContext context, WidgetRef ref, WeeklyProgramWithDays program) {
    final today = DateTime.now().weekday; // 1=Monday, 7=Sunday
    final todayRoutine = program.days.where((d) => d.dayOfWeek == today).firstOrNull;

    if (todayRoutine != null && todayRoutine.routineId.isNotEmpty) {
      // TODO: Navigate to ActiveWorkoutScreen with routine
      // For now, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Starting workout with routine: ${todayRoutine.routineId}')),
      );
    }
  }
}
