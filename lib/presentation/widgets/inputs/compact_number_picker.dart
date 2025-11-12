import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Compact number picker widget with increment/decrement buttons
///
/// Displays a label, value with suffix, and increment/decrement buttons.
/// Used for weight and progression/regression selection in Just Lift mode.
///
/// Ported from Kotlin JustLiftScreen.kt CompactNumberPicker (custom component)
class CompactNumberPicker extends StatelessWidget {
  /// Label text displayed above the picker
  final String label;

  /// Current value
  final int value;

  /// Minimum allowed value
  final int min;

  /// Maximum allowed value
  final int max;

  /// Suffix text (e.g., "kg", "lbs")
  final String suffix;

  /// Callback when value changes
  final ValueChanged<int> onChanged;

  const CompactNumberPicker({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.suffix,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final canDecrement = value > min;
    final canIncrement = value < max;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: canDecrement
                      ? () => onChanged(value - 1)
                      : null,
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: canDecrement
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value.toString(),
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Text(
                      suffix,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: canIncrement
                      ? () => onChanged(value + 1)
                      : null,
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: canIncrement
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
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
