import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/personal_record.dart';
import '../../providers/personal_record_provider.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/connection_log_provider.dart' show appDatabaseProvider;
import '../../../data/repositories/exercise_repository.dart';
import '../../theme/spacing.dart';
import 'exercise_progression_card.dart';
import '../common/empty_state.dart';

/// Provider for ExerciseRepository instance
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepositoryImpl(db.exerciseDao);
});

/// Trends Tab widget - displays PR progression over time.
/// 
/// This is tab 3 of 3 in the Analytics screen.
/// Shows overall stats and PR progression charts for each exercise.
class TrendsTab extends ConsumerWidget {
  const TrendsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final personalRecordsAsync = ref.watch(personalRecordsProvider);
    final weightUnit = ref.watch(weightUnitProvider);
    final formatWeight = ref.watch(preferencesActionsProvider).formatWeight;
    final exerciseRepository = ref.watch(exerciseRepositoryProvider);

    return personalRecordsAsync.when(
      data: (allPRs) {
        // Group PRs by exercise and sort by timestamp (newest first)
        final prsByExercise = <String, List<PersonalRecord>>{};
        for (final pr in allPRs) {
          prsByExercise.putIfAbsent(pr.exerciseId, () => []).add(pr);
        }

        // Sort each exercise's PRs by timestamp descending (newest first)
        for (final entry in prsByExercise.entries) {
          entry.value.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        }

        // Filter out exercises with no PRs
        final filteredPRsByExercise = Map.fromEntries(
          prsByExercise.entries.where((entry) => entry.value.isNotEmpty),
        );

        if (filteredPRsByExercise.isEmpty) {
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
            child: const EmptyState(
              icon: Icons.info_outline,
              title: 'No PR history yet',
              message: 'Complete workouts to track your progress over time',
            ),
          );
        }

        // Calculate overall stats
        final totalPRs = allPRs.length;
        final totalExercises = filteredPRsByExercise.length;
        final maxWeight = allPRs.isEmpty
            ? 0.0
            : allPRs
                .map((pr) => pr.weightPerCableKg)
                .reduce((a, b) => a > b ? a : b);

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
                'PR Progression',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSpacing.large), // 24dp

              // Overall Stats Card
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(
                    color: Color(0xFFF5F3FF), // Soft lavender border
                    width: 1.0,
                  ),
                ),
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Stats',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: AppSpacing.medium), // 16dp
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            label: 'Total PRs',
                            value: totalPRs.toString(),
                            icon: Icons.star,
                            theme: theme,
                          ),
                          _StatItem(
                            label: 'Exercises',
                            value: totalExercises.toString(),
                            icon: Icons.check,
                            theme: theme,
                          ),
                          _StatItem(
                            label: 'Max Per Cable',
                            value: formatWeight(maxWeight, weightUnit),
                            icon: Icons.star,
                            theme: theme,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.medium), // 16dp

              // Exercise Progression Cards
              ...filteredPRsByExercise.entries.map((entry) {
                final exerciseId = entry.key;
                final prs = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSpacing.medium, // 16dp between cards
                  ),
                  child: FutureBuilder<String>(
                    future: _getExerciseName(exerciseRepository, exerciseId),
                    builder: (context, snapshot) {
                      final exerciseName = snapshot.data ?? 'Loading...';
                      return ExerciseProgressionCard(
                        exerciseName: exerciseName,
                        prs: prs,
                        weightUnit: weightUnit,
                        formatWeight: formatWeight,
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

/// Stat item widget for trends tab stats
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ThemeData theme;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(height: AppSpacing.extraSmall), // 4dp
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
