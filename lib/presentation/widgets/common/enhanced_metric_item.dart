import 'package:flutter/material.dart';

/// Enhanced metric item widget for displaying metrics with icon, label, and value.
///
/// Ported from Kotlin EnhancedMetricItem composable (lines 884-916).
/// Used in workout history cards to display metrics in a 2×2 grid.
class EnhancedMetricItem extends StatelessWidget {
  /// Icon to display (16dp size)
  final IconData icon;

  /// Label text (bodySmall style)
  final String label;

  /// Value text (titleMedium Bold style)
  final String value;

  const EnhancedMetricItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon (16dp, primary color)
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 4), // 4dp spacing
        // Column with value and label
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Value (titleMedium Bold)
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            // Label (bodySmall)
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
