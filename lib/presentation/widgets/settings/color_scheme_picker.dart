import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';

/// Widget for selecting color scheme from 7 available options.
///
/// Displays a grid of color circles (7 options) with a selected indicator.
/// Users can tap a color circle to change the app's color scheme.
class ColorSchemePicker extends ConsumerWidget {
  const ColorSchemePicker({super.key});

  /// Color scheme names for display (future enhancement).
  static const List<String> _schemeNames = [
    'Purple',
    'Blue',
    'Green',
    'Orange',
    'Red',
    'Teal',
    'Pink',
  ];

  /// Color preview colors for each scheme.
  /// For now, all use purple since schemes are not yet differentiated.
  static const List<Color> _schemeColors = [
    AppColors.primaryPurple,  // 0: Purple
    AppColors.infoBlue,       // 1: Blue
    AppColors.successGreen,   // 2: Green
    AppColors.warningOrange,  // 3: Orange
    AppColors.errorRed,       // 4: Red
    Color(0xFF00BCD4),        // 5: Teal
    Color(0xFFE91E63),        // 6: Pink
  ];

  /// Gets a contrasting color (white or black) based on the brightness of the background color.
  static Color _getContrastColor(Color color) {
    // Calculate relative luminance
    final luminance = color.computeLuminance();
    // Use white for dark colors, black for light colors
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final selectedIndex = themeState.colorSchemeIndex;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Scheme',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: AppSpacing.medium),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: AppSpacing.small,
            mainAxisSpacing: AppSpacing.small,
            childAspectRatio: 1.0,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            final isSelected = index == selectedIndex;
            final schemeColor = _schemeColors[index];

            return GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).setColorScheme(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: schemeColor,
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 3.0 : 1.5,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        // Use white or black based on color brightness for better contrast
                        color: _getContrastColor(schemeColor),
                        size: 20,
                      )
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          _schemeNames[selectedIndex],
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
