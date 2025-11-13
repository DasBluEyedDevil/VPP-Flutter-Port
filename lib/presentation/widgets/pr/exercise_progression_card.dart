import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/personal_record.dart';
import '../../../domain/models/weight_unit.dart';
import '../../theme/spacing.dart';
import 'weight_progression_chart.dart';

/// Exercise Progression Card widget.
/// 
/// Shows PR progression for a specific exercise with toggle between chart and list views.
/// Displays timeline of PRs with improvement indicators.
class ExerciseProgressionCard extends StatefulWidget {
  final String exerciseName;
  final List<PersonalRecord> prs;
  final WeightUnit weightUnit;
  final String Function(double, WeightUnit) formatWeight;

  const ExerciseProgressionCard({
    super.key,
    required this.exerciseName,
    required this.prs,
    required this.weightUnit,
    required this.formatWeight,
  });

  @override
  State<ExerciseProgressionCard> createState() =>
      _ExerciseProgressionCardState();
}

class _ExerciseProgressionCardState extends State<ExerciseProgressionCard> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Sort PRs by timestamp descending (newest first)
    final sortedPRs = List<PersonalRecord>.from(widget.prs)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Color(0xFFF5F3FF), // Soft lavender border
          width: 1.0,
        ),
      ),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium), // 16dp
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Exercise Name + Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.exerciseName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                // Toggle button for chart view (only show if 2+ PRs)
                if (sortedPRs.length >= 2)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showChart = !_showChart;
                      });
                    },
                    icon: Icon(
                      _showChart ? Icons.list : Icons.show_chart,
                      color: colorScheme.primary,
                    ),
                    tooltip: _showChart ? 'Show list' : 'Show chart',
                  ),
              ],
            ),
            SizedBox(height: AppSpacing.small), // 8dp

            // Chart View (if toggled and 2+ PRs)
            if (_showChart && sortedPRs.length >= 2) ...[
              WeightProgressionChart(
                prs: sortedPRs.reversed.toList(), // Reverse for chart (oldest to newest)
                weightUnit: widget.weightUnit == WeightUnit.kg ? 'kg' : 'lb',
              ),
              SizedBox(height: AppSpacing.medium), // 16dp
            ],

            // Timeline View (always shown)
            ...sortedPRs.asMap().entries.map((entry) {
              final index = entry.key;
              final pr = entry.value;
              final isLatest = index == 0;

              return Column(
                children: [
                  // PR Timeline Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline indicator dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isLatest
                              ? colorScheme.primary
                              : colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: AppSpacing.small), // 8dp

                      // PR Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.formatWeight(pr.weightPerCableKg, widget.weightUnit)}/cable',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight:
                                    isLatest ? FontWeight.bold : FontWeight.normal,
                                color: isLatest
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: AppSpacing.extraSmall), // 4dp
                            Text(
                              '${pr.reps} reps • ${pr.workoutMode}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Date
                      Text(
                        DateFormat('MMM d').format(
                          DateTime.fromMillisecondsSinceEpoch(pr.timestamp),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  // Improvement indicator (if not the oldest PR)
                  if (index < sortedPRs.length - 1) ...[
                    SizedBox(height: AppSpacing.extraSmall), // 4dp
                    _buildImprovementIndicator(
                      context,
                      theme,
                      sortedPRs[index].weightPerCableKg,
                      sortedPRs[index + 1].weightPerCableKg,
                    ),
                  ],

                  // Spacing between PRs (except last)
                  if (index < sortedPRs.length - 1)
                    SizedBox(height: AppSpacing.small), // 8dp
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Build improvement indicator showing percentage increase
  Widget _buildImprovementIndicator(
    BuildContext context,
    ThemeData theme,
    double currentWeight,
    double previousWeight,
  ) {
    if (previousWeight <= 0) return const SizedBox.shrink();

    final improvement = ((currentWeight - previousWeight) / previousWeight * 100)
        .round();

    if (improvement <= 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 18.0), // Align with PR details
      child: Row(
        children: [
          Icon(
            Icons.keyboard_arrow_up,
            color: const Color(0xFF10B981), // Green
            size: 16,
          ),
          SizedBox(width: AppSpacing.extraSmall), // 4dp
          Text(
            '+$improvement%',
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF10B981), // Green
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
