import 'package:flutter/material.dart';
import '../../../domain/models/workout_metric.dart';
import '../../../domain/models/weight_unit.dart';

/// Live metrics card displaying real-time workout data
///
/// Shows current force, peak force, average force, and cable positions
/// Hidden during warmup phase
class LiveMetricsCard extends StatelessWidget {
  final WorkoutMetric? currentMetric;
  final WeightUnit weightUnit;
  final bool showDuringWarmup; // false = hide during warmup

  const LiveMetricsCard({
    super.key,
    required this.currentMetric,
    required this.weightUnit,
    this.showDuringWarmup = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (currentMetric == null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Waiting for data...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    final unitLabel = weightUnit == WeightUnit.kg ? 'kg' : 'lbs';
    final metric = currentMetric!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Live Metrics',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Grid layout (2 columns)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: [
                _MetricTile(
                  label: 'Force A',
                  value: '${metric.loadA.toStringAsFixed(1)} $unitLabel',
                ),
                _MetricTile(
                  label: 'Force B',
                  value: '${metric.loadB.toStringAsFixed(1)} $unitLabel',
                ),
                _MetricTile(
                  label: 'Total Force',
                  value: '${metric.totalLoad.toStringAsFixed(1)} $unitLabel',
                ),
                _MetricTile(
                  label: 'Power',
                  value: '${metric.power.toStringAsFixed(0)} W',
                ),
                _MetricTile(
                  label: 'Position A',
                  value: '${(metric.positionA / 10).toStringAsFixed(0)}%',
                ),
                _MetricTile(
                  label: 'Position B',
                  value: '${(metric.positionB / 10).toStringAsFixed(0)}%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
