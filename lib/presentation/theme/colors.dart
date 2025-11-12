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
