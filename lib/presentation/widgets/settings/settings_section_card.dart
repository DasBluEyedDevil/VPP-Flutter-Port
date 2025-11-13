import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Reusable card container for settings sections
///
/// Provides consistent styling with rounded corners, elevation, and border.
/// Ported from Kotlin SettingsScreen.kt card styling.
class SettingsSectionCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;

  const SettingsSectionCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Color(0xFFF5F3FF), // Light purple tint border
          width: 1.0,
        ),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: child,
      ),
    );
  }
}
