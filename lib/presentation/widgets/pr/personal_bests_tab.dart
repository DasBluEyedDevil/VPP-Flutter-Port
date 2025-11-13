import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/personal_record.dart';
import '../../../domain/models/weight_unit.dart';
import '../../providers/personal_record_provider.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/connection_log_provider.dart' show appDatabaseProvider;
import '../../../data/repositories/exercise_repository.dart';
import '../../theme/spacing.dart';
import 'personal_record_card.dart';
import 'muscle_group_distribution_chart.dart';
import 'workout_mode_distribution_chart.dart';
import 'empty_state_pr_card.dart';

/// Provider for ExerciseRepository instance
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepositoryImpl(db.exerciseDao);
});

/// Personal Bests Tab widget - displays user's Personal Records.
/// 
/// This is tab 1 of 3 in the Analytics screen.
/// Shows PRs grouped by exercise, sorted by weight descending.
class PersonalBestsTab extends ConsumerWidget {
  const PersonalBestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final personalRecordsAsync = ref.watch(personalRecordsProvider);
    final weightUnit = ref.watch(weightUnitProvider);
    final exerciseRepository = ref.watch(exerciseRepositoryProvider);

    return personalRecordsAsync.when(
      data: (allPRs) {
        if (allPRs.isEmpty) {
          return const EmptyStatePRCard();
        }

        // Group PRs by exercise and get best PR per exercise
        final grouped = <String, PersonalRecord>{};
        for (final pr in allPRs) {
          final existing = grouped[pr.exerciseId];
          if (existing == null || _isBetter(pr, existing)) {
            grouped[pr.exerciseId] = pr;
          }
        }

        // Convert to list and sort by weight descending (heaviest first)
        final sortedPRs = grouped.entries
            .map((e) => (e.key, e.value))
            .toList()
          ..sort((a, b) => b.$2.weightPerCableKg.compareTo(a.$2.weightPerCableKg));

        // Get all PRs for charts (not grouped)
        final allPRsForCharts = allPRs;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.brightness == Brightness.dark
                  ? [
                      const Color(0xFF0F172A), // slate-900
                      const Color(0xFF1E1B4B), // indigo-950
                      const Color(0xFF172554), // blue-950
                    ]
                  : [
                      const Color(0xFFE0E7FF), // indigo-200
                      const Color(0xFFFCE7F3), // pink-100
                      const Color(0xFFEDE9FE), // violet-200
                    ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.medium), // 16dp
            children: [
              // Title
              Text(
                'Your Personal Records',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSpacing.large), // 24dp

              // Muscle Group Distribution Chart
              MuscleGroupDistributionChart(
                prs: allPRsForCharts,
                exerciseRepository: exerciseRepository,
              ),
              SizedBox(height: AppSpacing.medium), // 16dp

              // Workout Mode Distribution Chart
              WorkoutModeDistributionChart(prs: allPRsForCharts),
              SizedBox(height: AppSpacing.medium), // 16dp

              // PR Cards List
              ...sortedPRs.asMap().entries.map((entry) {
                final index = entry.key;
                final exerciseId = entry.value.$1;
                final pr = entry.value.$2;
                final rank = index + 1;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < sortedPRs.length - 1
                        ? AppSpacing.medium
                        : 0, // 16dp between cards
                  ),
                  child: FutureBuilder<String>(
                    future: _getExerciseName(exerciseRepository, exerciseId),
                    builder: (context, snapshot) {
                      final exerciseName = snapshot.data ?? 'Loading...';
                      return PersonalRecordCard(
                        pr: pr,
                        rank: rank,
                        exerciseName: exerciseName,
                        weightUnit: weightUnit == WeightUnit.kg ? 'kg' : 'lb',
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading PRs: $error'),
      ),
    );
  }

  /// Check if new PR is better than existing PR
  /// Priority: Weight is king (higher weight always wins)
  /// If weight equal, higher reps wins
  bool _isBetter(PersonalRecord newPR, PersonalRecord existingPR) {
    return newPR.weightPerCableKg > existingPR.weightPerCableKg ||
        (newPR.weightPerCableKg == existingPR.weightPerCableKg &&
            newPR.reps > existingPR.reps);
  }

  /// Get exercise name asynchronously
  Future<String> _getExerciseName(
    ExerciseRepository repository,
    String exerciseId,
  ) async {
    try {
      final exercise = await repository.getExerciseById(exerciseId);
      return exercise?.name ?? 'Unknown Exercise';
    } catch (e) {
      return 'Unknown Exercise';
    }
  }
}
