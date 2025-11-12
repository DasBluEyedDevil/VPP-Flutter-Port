import 'package:flutter/material.dart';

/// Rep counter card displaying warmup and working rep counts
///
/// Shows large total reps display with warmup/working breakdown
class RepCounterCard extends StatelessWidget {
  final int warmupReps;
  final int workingReps;
  final int totalReps;
  final bool isWarmup;

  const RepCounterCard({
    super.key,
    required this.warmupReps,
    required this.workingReps,
    required this.totalReps,
    required this.isWarmup,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Large total reps display
            Text(
              '$totalReps',
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 96,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            // Warmup/Working breakdown
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isWarmup) ...[
                  Text(
                    'Warmup: $warmupReps',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Text(
                  'Working: $workingReps',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
