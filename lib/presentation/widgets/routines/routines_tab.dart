import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/routine.dart';
import '../../providers/routine_provider.dart';
import '../../theme/spacing.dart';
import 'routine_card.dart';
import 'empty_routines_state.dart';

/// Routines tab widget - displays list of workout routines
/// 
/// Phase 1: Core display only - no builder functionality
/// - Shows routine list with cards
/// - Empty state when no routines
/// - FAB disabled (Phase 2)
class RoutinesTab extends ConsumerWidget {
  const RoutinesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routinesProvider);
    final routineActions = ref.watch(routineActionsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: routinesAsync.when(
        data: (routines) {
          if (routines.isEmpty) {
            return const EmptyRoutinesState();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'My Routines',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              // Routine List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 88), // FAB clearance
                  itemCount: routines.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.small),
                  itemBuilder: (context, index) {
                    final routine = routines[index];
                    return RoutineCard(
                      routine: routine,
                      onTap: () => _startWorkout(context, ref, routine),
                      onDelete: () => _confirmDeleteRoutine(context, ref, routine, routineActions),
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
              Text(
                'Error loading routines: $error',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
      // FAB disabled for Phase 1
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null, // Disabled for Phase 1
        icon: const Icon(Icons.add),
        label: const Text('Create Routine'),
        tooltip: 'Routine builder coming in Phase 2',
      ),
    );
  }

  void _startWorkout(BuildContext context, WidgetRef ref, Routine routine) {
    // TODO: Implement navigation to ActiveWorkoutScreen (separate task)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting workout: ${routine.name}')),
    );
  }

  Future<void> _confirmDeleteRoutine(
    BuildContext context,
    WidgetRef ref,
    Routine routine,
    RoutineActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Routine?'),
        content: Text(
          'Are you sure you want to delete "${routine.name}"? This action cannot be undone.',
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
        await actions.deleteRoutine(routine.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Routine deleted')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting routine: $e')),
          );
        }
      }
    }
  }
}
