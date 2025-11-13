import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import 'gradient_icon_box.dart';

/// Settings section header widget
///
/// Displays a gradient icon box and title text in a row.
/// Ported from Kotlin SettingsScreen.kt section header implementation.
class SettingsSectionHeader extends StatelessWidget {
  /// The icon to display in the gradient box
  final IconData icon;

  /// List of colors for the gradient (typically 2 colors)
  final List<Color> gradientColors;

  /// The section title text
  final String title;

  const SettingsSectionHeader({
    super.key,
    required this.icon,
    required this.gradientColors,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientIconBox(
          icon: icon,
          gradientColors: gradientColors,
        ),
        const SizedBox(width: AppSpacing.medium),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
