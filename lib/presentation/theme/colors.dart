import 'package:flutter/material.dart';

/// Color constants for the Vitruvian Project Phoenix app.
/// 
/// Ported from Kotlin Color.kt with exact hex values preserved.
/// Supports both dark and light themes using Material 3 ColorScheme.
class AppColors {
  AppColors._();

  // Background Colors (Dark Theme)
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color backgroundDarkGrey = Color(0xFF121212);
  static const Color surfaceDarkGrey = Color(0xFF1E1E1E);
  static const Color cardBackground = Color(0xFF252525);

  // Background Colors (Light Theme)
  static const Color colorLightBackground = Color(0xFFF8F9FB);
  static const Color colorLightSurface = Color(0xFFFFFFFF);
  static const Color colorLightSurfaceVariant = Color(0xFFF3F4F6);

  // Text Colors (Light Theme)
  static const Color colorOnLightBackground = Color(0xFF0F172A);
  static const Color colorOnLightSurface = Color(0xFF111827);
  static const Color colorOnLightSurfaceVariant = Color(0xFF6B7280);

  // Purple Colors
  static const Color primaryPurple = Color(0xFFBB86FC);
  static const Color secondaryPurple = Color(0xFF9965F4);
  static const Color tertiaryPurple = Color(0xFFE0BBF7);
  static const Color purpleAccent = Color(0xFF7E57C2);

  // AppBar Colors
  static const Color topAppBarDark = Color(0xFF1A0E26);
  static const Color topAppBarLight = Color(0xFF4A2F8A);

  // Text Colors (Dark Theme)
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE0E0E0);
  static const Color textTertiary = Color(0xFFB0B0B0);
  static const Color textDisabled = Color(0xFF707070);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFF44336);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color infoBlue = Color(0xFF2196F3);
}

/// Dark theme ColorScheme using Material 3 design system.
/// 
/// Based on the dark theme colors from Color.kt.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primaryPurple,
  onPrimary: AppColors.backgroundBlack,
  primaryContainer: AppColors.secondaryPurple,
  onPrimaryContainer: AppColors.textPrimary,
  secondary: AppColors.secondaryPurple,
  onSecondary: AppColors.textPrimary,
  secondaryContainer: AppColors.tertiaryPurple,
  onSecondaryContainer: AppColors.backgroundBlack,
  tertiary: AppColors.tertiaryPurple,
  onTertiary: AppColors.backgroundBlack,
  tertiaryContainer: AppColors.purpleAccent,
  onTertiaryContainer: AppColors.textPrimary,
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: AppColors.primaryPurple,
  surfaceTint: AppColors.primaryPurple,
);

/// Light theme ColorScheme using Material 3 design system.
/// 
/// Based on the light theme colors from Color.kt.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryPurple,
  onPrimary: AppColors.colorLightSurface,
  primaryContainer: AppColors.tertiaryPurple,
  onPrimaryContainer: AppColors.topAppBarLight,
  secondary: AppColors.secondaryPurple,
  onSecondary: AppColors.colorLightSurface,
  secondaryContainer: AppColors.tertiaryPurple,
  onSecondaryContainer: AppColors.topAppBarLight,
  tertiary: AppColors.tertiaryPurple,
  onTertiary: AppColors.colorOnLightSurface,
  tertiaryContainer: AppColors.purpleAccent,
  onTertiaryContainer: AppColors.colorLightSurface,
  error: AppColors.errorRed,
  onError: AppColors.colorLightSurface,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  surface: AppColors.colorLightSurface,
  onSurface: AppColors.colorOnLightSurface,
  onSurfaceVariant: AppColors.colorOnLightSurfaceVariant,
  outline: AppColors.colorOnLightSurfaceVariant,
  outlineVariant: AppColors.colorLightSurfaceVariant,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.surfaceDarkGrey,
  onInverseSurface: AppColors.textPrimary,
  inversePrimary: AppColors.primaryPurple,
  surfaceTint: AppColors.primaryPurple,
);

/// Green theme ColorScheme using Material 3 design system.
const ColorScheme greenColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4CAF50),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFF388E3C),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFF66BB6A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF81C784),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFFA5D6A7),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF2E7D32),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFF4CAF50),
  surfaceTint: Color(0xFF4CAF50),
);

/// Orange theme ColorScheme using Material 3 design system.
const ColorScheme orangeColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFF9800),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFFF57C00),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFFFFB74D),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFFFFCC80),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFFFFE0B2),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFFE65100),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFFFF9800),
  surfaceTint: Color(0xFFFF9800),
);

/// Red theme ColorScheme using Material 3 design system.
const ColorScheme redColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF44336),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD32F2F),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFFEF5350),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE57373),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFFEF9A9A),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFFC62828),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: Color(0xFFFF6B6B),
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFFB71C1C),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFFF44336),
  surfaceTint: Color(0xFFF44336),
);

/// Teal theme ColorScheme using Material 3 design system.
const ColorScheme tealColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF009688),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF00796B),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFF26A69A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF4DB6AC),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFF80CBC4),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF00695C),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFF009688),
  surfaceTint: Color(0xFF009688),
);

/// Pink theme ColorScheme using Material 3 design system.
const ColorScheme pinkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFE91E63),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC2185B),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFFEC407A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFF06292),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFFF8BBD0),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFFAD1457),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFFE91E63),
  surfaceTint: Color(0xFFE91E63),
);

/// Indigo theme ColorScheme using Material 3 design system.
const ColorScheme indigoColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF3F51B5),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF303F9F),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xFF5C6BC0),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF7986CB),
  onSecondaryContainer: Color(0xFF000000),
  tertiary: Color(0xFF9FA8DA),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF283593),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: AppColors.errorRed,
  onError: AppColors.textPrimary,
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColors.surfaceDarkGrey,
  onSurface: AppColors.textPrimary,
  onSurfaceVariant: AppColors.textSecondary,
  outline: AppColors.textTertiary,
  outlineVariant: AppColors.cardBackground,
  shadow: AppColors.backgroundBlack,
  scrim: AppColors.backgroundBlack,
  inverseSurface: AppColors.colorLightSurface,
  onInverseSurface: AppColors.colorOnLightSurface,
  inversePrimary: Color(0xFF3F51B5),
  surfaceTint: Color(0xFF3F51B5),
);

/// List of available color schemes (7 options).
const List<ColorScheme> colorSchemes = [
  darkColorScheme,    // 0: Purple (default)
  greenColorScheme,   // 1: Green
  orangeColorScheme,  // 2: Orange
  redColorScheme,     // 3: Red
  tealColorScheme,    // 4: Teal
  pinkColorScheme,    // 5: Pink
  indigoColorScheme,  // 6: Indigo
];
