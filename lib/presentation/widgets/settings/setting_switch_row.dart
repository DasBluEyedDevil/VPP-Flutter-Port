import 'package:flutter/material.dart';

/// Switch row widget for settings
///
/// Displays a label, optional description, and a switch toggle.
/// Ported from Kotlin SettingsScreen.kt switch row implementation.
class SettingSwitchRow extends StatelessWidget {
  /// The primary label text
  final String label;

  /// Optional description text shown below the label
  final String? description;

  /// Current switch value
  final bool value;

  /// Callback when switch is toggled
  final ValueChanged<bool> onChanged;

  const SettingSwitchRow({
    super.key,
    required this.label,
    this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
