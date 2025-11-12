import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/workout_state.dart';
import '../../../domain/models/auto_stop_ui_state.dart';

/// Auto-start/Auto-stop unified card widget for Just Lift mode
///
/// Displays countdown and status information for auto-start (grab-to-start)
/// and auto-stop (danger zone countdown) functionality in Just Lift mode.
///
/// Ported from Kotlin JustLiftScreen.kt AutoStartStopCard (lines 537-597)
class AutoStartStopCard extends StatelessWidget {
  /// Current workout state
  final WorkoutState workoutState;

  /// Auto-start countdown seconds (null if not counting down)
  final int? autoStartCountdown;

  /// Auto-stop UI state
  final AutoStopUiState autoStopState;

  const AutoStartStopCard({
    super.key,
    required this.workoutState,
    this.autoStartCountdown,
    required this.autoStopState,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Determine state flags
    final isIdle = workoutState is Idle;
    final isActive = workoutState is Active;

    // Only show card when idle or active
    if (!isIdle && !isActive) {
      return const SizedBox.shrink();
    }

    // Determine container color based on state
    final containerColor = switch ((autoStartCountdown, autoStopState.isActive, isActive, isIdle)) {
      (int _, _, _, _) => colorScheme.primaryContainer,
      (_, true, _, _) => colorScheme.errorContainer,
      (_, _, true, _) => colorScheme.surfaceVariant,
      _ => colorScheme.tertiaryContainer,
    };

    // Determine text color based on state
    final textColor = switch ((autoStartCountdown, autoStopState.isActive, isActive)) {
      (int _, _, _) => colorScheme.onPrimaryContainer,
      (_, true, _) => colorScheme.onErrorContainer,
      (_, _, true) => colorScheme.onSurfaceVariant,
      _ => colorScheme.onTertiaryContainer,
    };

    // Determine icon
    final icon = isIdle ? Icons.play_circle : Icons.pan_tool;

    // Determine title text
    final titleText = switch ((autoStartCountdown, autoStopState.isActive, isActive, isIdle)) {
      (int countdown, _, _, _) => 'Starting in $countdown...',
      (_, true, _, _) => 'Stopping in ${autoStopState.secondsRemaining}s...',
      (_, _, true, _) => 'Auto-Stop Ready',
      _ => 'Auto-Start Ready',
    };

    return Card(
      color: containerColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isIdle ? colorScheme.tertiary : colorScheme.outline,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: textColor,
            ),
            const SizedBox(width: AppSpacing.small),
            Text(
              titleText,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
