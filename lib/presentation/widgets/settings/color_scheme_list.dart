import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Color scheme list widget
///
/// Displays a list of color scheme buttons (Blue, Green, Teal, Yellow, Pink, Red, Purple).
/// Ported from Kotlin SettingsScreen.kt color scheme button list.
class ColorSchemeList extends StatelessWidget {
  /// Callback when a color scheme is selected (index 0-6)
  final ValueChanged<int> onColorSelected;

  const ColorSchemeList({
    super.key,
    required this.onColorSelected,
  });

  static const List<String> _colorNames = [
    'Blue',
    'Green',
    'Teal',
    'Yellow',
    'Pink',
    'Red',
    'Purple',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_colorNames.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < _colorNames.length - 1 ? AppSpacing.small : 0,
          ),
          child: SizedBox(
            height: 48.0,
            width: double.infinity,
            child: TextButton(
              onPressed: () => onColorSelected(index),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _colorNames[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
