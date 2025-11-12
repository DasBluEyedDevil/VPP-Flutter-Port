import 'package:flutter/material.dart';

/// Typography scale for the Vitruvian Project Phoenix app.
/// 
/// Ported from Kotlin Type.kt with exact font sizes, weights, and letter spacing.
/// Uses Material 3 TextTheme with Roboto font family (FontFamily.Default).
class AppTypography {
  AppTypography._();

  /// Display Large - 57sp, Bold, 0.0 letter spacing
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Display Medium - 45sp, Bold, 0.0 letter spacing
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Headline Large - 32sp, SemiBold (600), 0.0 letter spacing
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Headline Medium - 28sp, SemiBold (600), 0.0 letter spacing
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Headline Small - 24sp, SemiBold (600), 0.0 letter spacing
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Title Large - 22sp, SemiBold (600), 0.0 letter spacing
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    fontFamily: 'Roboto',
  );

  /// Title Medium - 16sp, Medium (500), 0.15 letter spacing
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    fontFamily: 'Roboto',
  );

  /// Title Small - 14sp, Medium (500), 0.1 letter spacing
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: 'Roboto',
  );

  /// Body Large - 16sp, Normal (400), 0.5 letter spacing
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );

  /// Body Medium - 14sp, Normal (400), 0.25 letter spacing
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    fontFamily: 'Roboto',
  );

  /// Body Small - 12sp, Normal (400), 0.4 letter spacing
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    fontFamily: 'Roboto',
  );

  /// Label Large - 14sp, Medium (500), 0.1 letter spacing
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: 'Roboto',
  );

  /// Label Medium - 12sp, Medium (500), 0.5 letter spacing
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );

  /// Label Small - 11sp, Medium (500), 0.5 letter spacing
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );
}

/// Material 3 TextTheme using the app's typography scale.
/// 
/// Maps all text styles from AppTypography to Material 3 TextTheme.
const TextTheme appTextTheme = TextTheme(
  displayLarge: AppTypography.displayLarge,
  displayMedium: AppTypography.displayMedium,
  headlineLarge: AppTypography.headlineLarge,
  headlineMedium: AppTypography.headlineMedium,
  headlineSmall: AppTypography.headlineSmall,
  titleLarge: AppTypography.titleLarge,
  titleMedium: AppTypography.titleMedium,
  titleSmall: AppTypography.titleSmall,
  bodyLarge: AppTypography.bodyLarge,
  bodyMedium: AppTypography.bodyMedium,
  bodySmall: AppTypography.bodySmall,
  labelLarge: AppTypography.labelLarge,
  labelMedium: AppTypography.labelMedium,
  labelSmall: AppTypography.labelSmall,
);
