import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_history_provider.dart';
import '../providers/preferences_provider.dart';
import '../providers/connection_log_provider.dart' show appDatabaseProvider;
import '../widgets/common/empty_state.dart';
import '../widgets/common/refresh_button.dart';
import '../widgets/workout/workout_history_card.dart';
import '../theme/spacing.dart';
import '../../data/repositories/exercise_repository.dart';

/// Provider for exercise repository (reused pattern from daily_routines_screen)
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepositoryImpl(db.exerciseDao);
});

/// Provider that batches exercise name lookups for all workout sessions
///
/// CRITICAL OPTIMIZATION: Fetches all exercise names in one batch instead of
/// per-card queries (avoids 20 duplicate DB queries for same exercise)
final exerciseNameMapProvider = FutureProvider.family<Map<String, String>, List<String>>((ref, exerciseIds) async {
  if (exerciseIds.isEmpty) return {};
  
  final repo = ref.watch(exerciseRepositoryProvider);
  final uniqueIds = exerciseIds.toSet().toList();
  
  // Batch fetch all unique exercise IDs
  final Map<String, String> nameMap = {};
  for (final id in uniqueIds) {
    try {
      final exercise = await repo.getExerciseById(id);
      if (exercise != null) {
        nameMap[id] = exercise.name;
      }
    } catch (e) {
      // Silently fail - will default to "Just Lift" in card
    }
  }
  
  return nameMap;
});

/// History tab screen displaying workout history list.
///
/// Ported from Kotlin HistoryTab composable (lines 38-113).
/// Displays scrollable list of completed workout sessions with metrics.
class HistoryTab extends ConsumerWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final workoutsAsync = ref.watch(workoutHistoryProvider);
    final weightUnit = ref.watch(weightUnitProvider);
    final formatWeight = ref.watch(preferencesActionsProvider).formatWeight;
    final historyActions = ref.watch(workoutHistoryActionsProvider);

    return workoutsAsync.when(
      data: (workouts) {
        // Extract unique exercise IDs for batch fetching
        final exerciseIds = workouts
            .where((w) => w.exerciseId != null)
            .map((w) => w.exerciseId!)
            .toList();
        
        // Batch fetch exercise names
        final exerciseNamesAsync = ref.watch(exerciseNameMapProvider(exerciseIds));

        if (workouts.isEmpty) {
          return const EmptyState(
            icon: Icons.history,
            title: 'No Workout History Yet',
            message: 'Complete your first workout to see it here',
          );
        }

        return Column(
          children: [
            // Header Row: Title + Refresh Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.medium), // 16dp
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title (headlineMedium Bold)
                  Text(
                    'Workout History',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  // Refresh Button
                  RefreshButton(
                    onRefresh: () {
                      // Refresh is cosmetic - StreamProvider auto-updates when DB changes
                      // Could trigger a manual refresh here if needed
                    },
                  ),
                ],
              ),
            ),
            // Workout List
            Expanded(
              child: exerciseNamesAsync.when(
                data: (exerciseNameMap) => ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.medium, // 16dp
                  ),
                  itemCount: workouts.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSpacing.small, // 8dp spacing between cards
                  ),
                  itemBuilder: (context, index) {
                    final workout = workouts[index];
                    final exerciseName = workout.exerciseId != null
                        ? exerciseNameMap[workout.exerciseId]
                        : null;

                    return WorkoutHistoryCard(
                      session: workout,
                      weightUnit: weightUnit,
                      formatWeight: formatWeight,
                      exerciseName: exerciseName,
                      onDelete: () {
                        historyActions.deleteWorkoutSession(workout.id);
                      },
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.medium,
                  ),
                  itemCount: workouts.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSpacing.small,
                  ),
                  itemBuilder: (context, index) {
                    final workout = workouts[index];
                    return WorkoutHistoryCard(
                      session: workout,
                      weightUnit: weightUnit,
                      formatWeight: formatWeight,
                      exerciseName: null, // Fallback to "Just Lift" on error
                      onDelete: () {
                        historyActions.deleteWorkoutSession(workout.id);
                      },
                    );
                  },
                ),
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
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              'Error loading workout history: $error',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
