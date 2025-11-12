import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/preferences/preferences_manager.dart';
import 'preferences_provider.dart';

part 'theme_provider.freezed.dart';

/// Theme state containing color scheme index and brightness.
///
/// [colorSchemeIndex] - Index of the color scheme (0-6)
/// [brightness] - Brightness mode (light or dark)
@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default(0) int colorSchemeIndex,
    @Default(Brightness.dark) Brightness brightness,
  }) = _ThemeState;
}

/// StateNotifier for managing theme state.
///
/// Handles theme persistence and state updates.
class ThemeNotifier extends StateNotifier<ThemeState> {
  final PreferencesManager _prefs;

  ThemeNotifier(this._prefs) : super(const ThemeState()) {
    _loadTheme();
  }

  /// Load theme preferences from storage.
  Future<void> _loadTheme() async {
    final colorSchemeIndex = _prefs.getThemeColorSchemeIndex();
    final isDark = _prefs.getThemeBrightness();
    
    state = ThemeState(
      colorSchemeIndex: colorSchemeIndex,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  /// Set the color scheme index (0-6).
  ///
  /// Updates state and persists to preferences.
  Future<void> setColorScheme(int index) async {
    if (index < 0 || index > 6) {
      throw ArgumentError('Color scheme index must be between 0 and 6');
    }
    
    state = state.copyWith(colorSchemeIndex: index);
    await _prefs.setThemeColorSchemeIndex(index);
  }

  /// Toggle between light and dark brightness.
  ///
  /// Updates state and persists to preferences.
  Future<void> toggleBrightness() async {
    final newBrightness = state.brightness == Brightness.dark 
        ? Brightness.light 
        : Brightness.dark;
    state = state.copyWith(brightness: newBrightness);
    await _prefs.setThemeBrightness(newBrightness == Brightness.dark);
  }
}

/// Provider for theme state management.
///
/// Provides ThemeNotifier that manages theme preferences.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final prefsManager = ref.watch(preferencesManagerProvider);
  return ThemeNotifier(prefsManager);
});
