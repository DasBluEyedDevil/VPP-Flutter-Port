import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/models/personal_record.dart';
import '../../../data/repositories/exercise_repository.dart';

/// Muscle Group Distribution Chart widget.
/// 
/// Shows percentage of PRs per muscle group using fl_chart PieChart.
class MuscleGroupDistributionChart extends StatelessWidget {
  final List<PersonalRecord> prs;
  final ExerciseRepository? exerciseRepository;

  const MuscleGroupDistributionChart({
    super.key,
    required this.prs,
    this.exerciseRepository,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<Map<String, int>>(
      future: _calculateMuscleGroupCounts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final counts = snapshot.data!;
        final total = counts.values.reduce((a, b) => a + b);

        // Chart colors: Purple, Blue, Green, Orange, Red, Violet, Pink, Teal
        final colors = [
          const Color(0xFF9333EA), // Purple
          const Color(0xFF3B82F6), // Blue
          const Color(0xFF10B981), // Green
          const Color(0xFFF59E0B), // Orange
          const Color(0xFFEF4444), // Red
          const Color(0xFF8B5CF6), // Violet
          const Color(0xFFEC4899), // Pink
          const Color(0xFF14B8A6), // Teal
        ];

        final entries = counts.entries.toList();
        final pieChartSections = entries.asMap().entries.map((entry) {
          final index = entry.key;
          final count = entry.value.value;
          final percentage = (count / total) * 100;

          return PieChartSectionData(
            value: count.toDouble(),
            title: '${percentage.toStringAsFixed(0)}%',
            color: colors[index % colors.length],
            radius: 60,
            titleStyle: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Muscle Group Distribution',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: pieChartSections,
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Legend
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: entries.asMap().entries.map((entry) {
                    final index = entry.key;
                    final muscleGroup = entry.value.key;
                    final count = entry.value.value;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$muscleGroup ($count)',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, int>> _calculateMuscleGroupCounts() async {
    final counts = <String, int>{};

    if (exerciseRepository == null) {
      return counts;
    }

    for (final pr in prs) {
      try {
        final exercise = await exerciseRepository!.getExerciseById(pr.exerciseId);
        if (exercise != null && exercise.muscleGroups != null && exercise.muscleGroups!.isNotEmpty) {
          // Parse comma-separated muscle groups
          final groups = exercise.muscleGroups!
              .split(',')
              .map((g) => g.trim())
              .where((g) => g.isNotEmpty);

          for (final group in groups) {
            counts[group] = (counts[group] ?? 0) + 1;
          }
        }
      } catch (e) {
        // Skip exercises that can't be loaded
        continue;
      }
    }

    return counts;
  }
}
