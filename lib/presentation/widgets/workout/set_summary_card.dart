import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/workout_metric.dart';
import '../../../domain/models/weight_unit.dart';

/// Set summary card showing detailed metrics after completing a set.
///
/// Displays peak power, average power, rep count, and a force graph.
class SetSummaryCard extends StatelessWidget {
  /// List of workout metrics for the set
  final List<WorkoutMetric> metrics;

  /// Peak power achieved during the set
  final double peakPower;

  /// Average power during the set
  final double averagePower;

  /// Number of reps completed
  final int repCount;

  /// Weight unit for display
  final WeightUnit weightUnit;

  /// Weight formatting function
  final String Function(double, WeightUnit) formatWeight;

  /// Callback when continue is pressed
  final VoidCallback onContinue;

  /// Optional PR badge indicator
  final bool isPR;

  const SetSummaryCard({
    super.key,
    required this.metrics,
    required this.peakPower,
    required this.averagePower,
    required this.repCount,
    required this.weightUnit,
    required this.formatWeight,
    required this.onContinue,
    this.isPR = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with checkmark and optional PR badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: AppSpacing.small),
                Text(
                  'Set Complete!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isPR) ...[
                  const SizedBox(width: AppSpacing.small),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.small,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'PR!',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.medium),
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Peak Power
                Expanded(
                  child: _StatCard(
                    label: 'Peak',
                    value: formatWeight(peakPower, weightUnit),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                // Average Power
                Expanded(
                  child: _StatCard(
                    label: 'Average',
                    value: formatWeight(averagePower, weightUnit),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                // Rep Count
                Expanded(
                  child: _StatCard(
                    label: 'Reps',
                    value: '$repCount',
                  ),
                ),
              ],
            ),
            // Force Graph
            if (metrics.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.medium),
              Text(
                'Force Over Time',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: _ForceGraph(metrics: metrics),
              ),
            ],
            const SizedBox(height: AppSpacing.medium),
            // Continue Button
            FilledButton.icon(
              onPressed: onContinue,
              icon: const Icon(Icons.arrow_forward, size: 20),
              label: const Text('Continue'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual stat card for displaying a metric
class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.small),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Force graph showing load over time during the set
class _ForceGraph extends StatelessWidget {
  final List<WorkoutMetric> metrics;

  const _ForceGraph({
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    if (metrics.isEmpty) {
      return const SizedBox.shrink();
    }

    // Prepare data points (time in seconds vs total load)
    final startTime = metrics.first.timestamp;
    final spots = metrics.map((metric) {
      final elapsedSeconds = (metric.timestamp - startTime) / 1000.0;
      return FlSpot(elapsedSeconds, metric.totalLoad);
    }).toList();

    // Find min/max for axis bounds
    final maxLoad = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final minLoad = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxTime = spots.map((s) => s.x).reduce((a, b) => a > b ? a : b);

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: (maxLoad - minLoad) / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colorScheme.surfaceContainerHighest,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: colorScheme.surfaceContainerHighest,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}s',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(0),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        minX: 0,
        maxX: maxTime > 0 ? maxTime : 1,
        minY: minLoad > 0 ? minLoad * 0.9 : 0,
        maxY: maxLoad * 1.1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.4,
            color: const Color(0xFF9333EA), // Purple per briefing spec
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF9333EA).withValues(alpha: 0.2),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => colorScheme.surfaceContainerHigh,
            tooltipRoundedRadius: 8,
          ),
        ),
      ),
    );
  }
}
