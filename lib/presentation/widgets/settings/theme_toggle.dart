import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../theme/spacing.dart';

/// Widget for toggling between light and dark theme modes.
///
/// Displays a switch with light/dark mode icons that allows users
/// to toggle the app's brightness theme.
class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final isDark = themeState.brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: colorScheme.onSurface,
            ),
            const SizedBox(width: AppSpacing.small),
            Text(
              isDark ? 'Dark Mode' : 'Light Mode',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
            ),
          ],
        ),
        Switch(
          value: isDark,
          onChanged: (_) {
            ref.read(themeProvider.notifier).toggleBrightness();
          },
        ),
      ],
    );
  }
}
