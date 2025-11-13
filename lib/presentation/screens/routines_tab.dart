import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import '../providers/routine_provider.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/dialogs/routine_builder_dialog.dart';
import '../widgets/workout/routine_card.dart';
import '../theme/spacing.dart';
import '../../domain/models/routine.dart' as domain;

/// Routines tab screen displaying list of workout routines.
/// 
/// Matches Kotlin RoutinesTab exactly with:
/// - Gradient background (conditional on theme: dark vs light)
/// - Empty state vs routine list (conditional rendering)
/// - Screen header 'My Routines' (headlineMedium, Bold, 20dp padding)
/// - ListView with 8dp spacing between cards
/// - FAB 'Create Routine' with add icon
class RoutinesTab extends ConsumerWidget {
  const RoutinesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routinesProvider);
    final routineActions = ref.watch(routineActionsProvider);
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
        body: routinesAsync.when(
          data: (routines) {
            if (routines.isEmpty) {
              return EmptyState(
                icon: Icons.fitness_center,
                title: 'No Routines Yet',
                message: 'Create your first workout routine to get started',
                actionLabel: 'Create Routine',
                onAction: () => _showRoutineBuilder(context, ref, null),
              );
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
                    ),
                  ),
                ),
                // Routine List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88), // FAB clearance
                    itemCount: routines.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return RoutineCard(
                        routine: routines[index],
                        onTap: () => _startWorkout(context, ref, routines[index]),
                        onEdit: () => _showRoutineBuilder(context, ref, routines[index]),
                        onDuplicate: () => _duplicateRoutine(context, ref, routines[index], routines, routineActions),
                        onDelete: () => _confirmDeleteRoutine(context, ref, routines[index], routineActions),
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
                Text('Error loading routines: $error'),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showRoutineBuilder(context, ref, null),
          icon: const Icon(Icons.add),
          label: const Text('Create Routine'),
        ),
      ),
    );
  }

  Future<void> _showRoutineBuilder(BuildContext context, WidgetRef ref, domain.Routine? routine) async {
    // TODO: Get exercises from exercise provider/repository (Phase 2)
    // For now, pass empty list - builder dialog will handle it
    return; // Temporarily disabled until Phase 2

    // ignore: dead_code
    await RoutineBuilderDialog.show(
      context,
      routine: routine,
      exercises: const [],
      onSave: (savedRoutine) {
        // TODO: Save routine via routineActionsProvider
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(routine == null ? 'Routine created' : 'Routine updated'),
            ),
          );
        }
      },
    );
  }

  void _startWorkout(BuildContext context, WidgetRef ref, domain.Routine routine) {
    // TODO: Implement navigation to ActiveWorkoutScreen (separate task)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting workout: ${routine.name}')),
    );
  }

  void _duplicateRoutine(
    BuildContext context,
    WidgetRef ref,
    domain.Routine routine,
    List<domain.Routine> allRoutines,
    RoutineActions actions,
  ) {
    // Smart duplicate with "(Copy N)" naming
    final duplicate = _createSmartDuplicate(routine, allRoutines);
    // TODO: Implement saveRoutine when ready
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Duplicated: ${duplicate.name}')),
    );
  }

  domain.Routine _createSmartDuplicate(domain.Routine original, List<domain.Routine> existingRoutines) {
    // Extract base name and find highest (Copy N)
    final baseName = _extractBaseName(original.name);
    final nextCopyNumber = _findNextCopyNumber(baseName, existingRoutines);

    final newName = nextCopyNumber == 1
        ? '$baseName (Copy)'
        : '$baseName (Copy $nextCopyNumber)';

    // Generate new UUID for routine
    const uuid = Uuid();
    return domain.Routine(
      id: uuid.v4(),
      name: newName,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      lastUsed: 0,
      exerciseCount: original.exerciseCount,
    );
  }

  String _extractBaseName(String name) {
    // Regex: remove " (Copy)" or " (Copy N)" suffix
    final copyPattern = RegExp(r'\s*\(Copy\s*\d*\)\s*$');
    return name.replaceAll(copyPattern, '').trim();
  }

  int _findNextCopyNumber(String baseName, List<domain.Routine> routines) {
    final copyPattern = RegExp(r'\(Copy\s*(\d*)\)$');
    final copyNumbers = <int>[0]; // Start with 0 (base case: first copy)

    for (final routine in routines) {
      if (routine.name.startsWith(baseName)) {
        final match = copyPattern.firstMatch(routine.name);
        if (match != null) {
          final numberStr = match.group(1);
          final number = numberStr?.isEmpty == true ? 1 : int.tryParse(numberStr!) ?? 1;
          copyNumbers.add(number);
        }
      }
    }

    return copyNumbers.reduce(math.max) + 1;
  }

  Future<void> _confirmDeleteRoutine(
    BuildContext context,
    WidgetRef ref,
    domain.Routine routine,
    RoutineActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Routine?'),
        content: Text('Are you sure you want to delete "${routine.name}"? This action cannot be undone.'),
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
