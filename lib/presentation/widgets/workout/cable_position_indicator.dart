import 'package:flutter/material.dart';

/// Vertical cable position indicator bar widget
///
/// Displays a vertical bar showing the current cable position (0-1000)
/// with optional min/max range markers. Used during active workouts to
/// visualize cable positions for both left (L) and right (R) cables.
///
/// Ported from Kotlin WorkoutTab.kt VerticalCablePositionBar (lines 1687-1793)
/// Updated for Phase 1: 40dp width, gradient fill, percentage display on indicator
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

    return Container(
      width: 40,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final hasRange = minProgress != null &&
              maxProgress != null &&
              maxProgress > minProgress;
          final positionHeight = height * currentProgress;
          final indicatorPosition = height - positionHeight - 12; // Center indicator on position

          return Stack(
            children: [
              // Background container
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Range zone (if min/max provided)
              if (hasRange)
                Positioned(
                  bottom: height * minProgress,
                  left: 0,
                  right: 0,
                  height: height * (maxProgress - minProgress),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              // Gradient fill (from bottom to current position)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: positionHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        colorScheme.primary.withValues(alpha: 0.5),
                        colorScheme.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Position indicator (rounded rectangle with percentage)
              Positioned(
                bottom: indicatorPosition.clamp(0.0, height - 24),
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${(currentPosition / 10).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: isActive
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Range markers (if min/max provided)
              if (hasRange) ...[
                // Min marker
                Positioned(
                  bottom: height * minProgress,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                ),
                // Max marker
                Positioned(
                  bottom: height * maxProgress,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                ),
              ],
              // Label at top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: labelColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
