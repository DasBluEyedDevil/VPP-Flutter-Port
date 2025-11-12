import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/workout_state.dart';
import '../../../domain/models/weight_unit.dart';

/// Active status card widget displayed during active workout
///
/// Shows dynamic title based on workout state, reps, load, and stop button.
/// Only displayed when workout is active.
///
/// Ported from Kotlin JustLiftScreen.kt ActiveStatusCard (lines 752-820)
class ActiveStatusCard extends StatelessWidget {
  /// Current workout state
  final WorkoutState workoutState;

  /// Total reps completed
  final int totalReps;

  /// Current total load (both cables combined)
  final double currentLoad;

  /// Weight unit for display
  final WeightUnit weightUnit;

  /// Callback when stop button is pressed
  final VoidCallback onStop;

  const ActiveStatusCard({
    super.key,
    required this.workoutState,
    required this.totalReps,
    required this.currentLoad,
    required this.weightUnit,
    required this.onStop,
  });

  String _formatWeight(double weightKg, WeightUnit unit) {
    final value = unit == WeightUnit.kg ? weightKg : weightKg * 2.20462;
    final unitStr = unit == WeightUnit.kg ? 'kg' : 'lbs';
    return '${value.toStringAsFixed(1)} $unitStr';
  }

  String _getTitle(WorkoutState state) {
    return switch (state) {
      Countdown(:final secondsRemaining) => 'Get Ready: ${secondsRemaining}s',
      Active() => 'Workout Active',
      Resting(:final restSecondsRemaining) => 'Resting: ${restSecondsRemaining}s',
      Completed() => 'Workout Complete',
      _ => 'Workout Active',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getTitle(workoutState),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              'Reps: $totalReps',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Load: ${_formatWeight(currentLoad, weightUnit)}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            OutlinedButton.icon(
              onPressed: onStop,
              icon: const Icon(Icons.close),
              label: const Text('Stop Workout'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.error,
                side: BorderSide(color: colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
