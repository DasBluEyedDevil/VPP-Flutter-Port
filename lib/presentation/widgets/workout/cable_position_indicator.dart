import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Vertical cable position indicator bar widget
///
/// Displays a vertical bar showing the current cable position (0-1000)
/// with optional min/max range markers. Used during active workouts to
/// visualize cable positions for both left (L) and right (R) cables.
///
/// Ported from Kotlin WorkoutTab.kt VerticalCablePositionBar (lines 1687-1793)
class CablePositionIndicator extends StatelessWidget {
  /// Label text ("L" or "R")
  final String label;

  /// Current cable position (0-1000)
  final int currentPosition;

  /// Optional minimum position for range display
  final int? minPosition;

  /// Optional maximum position for range display
  final int? maxPosition;

  /// Whether the workout is currently active
  final bool isActive;

  const CablePositionIndicator({
    super.key,
    required this.label,
    required this.currentPosition,
    this.minPosition,
    this.maxPosition,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Calculate progress values (0.0 to 1.0)
    const maxPos = 1000;
    final currentProgress = (currentPosition / maxPos).clamp(0.0, 1.0);
    final minProgress = minPosition != null
        ? (minPosition! / maxPos).clamp(0.0, 1.0)
        : null;
    final maxProgress = maxPosition != null
        ? (maxPosition! / maxPos).clamp(0.0, 1.0)
        : null;

    // Determine colors based on active state
    final labelColor = isActive
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final fillColor = isActive
        ? colorScheme.primary
        : colorScheme.outline.withValues(alpha: 0.5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label text
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
        const SizedBox(height: AppSpacing.extraSmall),
        // Bar container with flexible height
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barHeight = constraints.maxHeight;
              final hasRange = minProgress != null &&
                  maxProgress != null &&
                  maxProgress > minProgress;

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Background bar
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Range zone (if min/max provided)
                  if (hasRange)
                    Positioned(
                      bottom: barHeight * minProgress,
                      child: Container(
                        width: 40,
                        height: barHeight * (maxProgress - minProgress),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.3),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  // Current position fill
                  Container(
                    width: 40,
                    height: barHeight * currentProgress,
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                  ),
                  // Range markers (if min/max provided)
                  if (hasRange) ...[
                    // Min marker
                    Positioned(
                      bottom: barHeight * minProgress,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        color: colorScheme.primary.withValues(alpha: 0.6),
                      ),
                    ),
                    // Max marker
                    Positioned(
                      bottom: barHeight * maxProgress,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        color: colorScheme.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.extraSmall),
        // Position value text
        Text(
          '${(currentPosition / 10).toStringAsFixed(0)}%',
          style: theme.textTheme.labelSmall?.copyWith(
            color: labelColor,
          ),
        ),
      ],
    );
  }
}
