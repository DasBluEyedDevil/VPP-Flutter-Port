import 'package:flutter/material.dart';

/// Gradient icon box widget for settings section headers
///
/// Displays an icon with a gradient background in a rounded container.
/// Ported from Kotlin SettingsScreen.kt gradient icon implementation.
class GradientIconBox extends StatelessWidget {
  /// The icon to display
  final IconData icon;

  /// List of colors for the linear gradient (typically 2 colors)
  final List<Color> gradientColors;

  /// Size of the icon box (default: 40dp as per analysis)
  final double size;

  const GradientIconBox({
    super.key,
    required this.icon,
    required this.gradientColors,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
        size: size * 0.5, // Icon is roughly half the container size
      ),
    );
  }
}
