import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpp_flutter_port/presentation/providers/theme_provider.dart';
import 'package:vpp_flutter_port/presentation/providers/preferences_provider.dart';
import 'package:vpp_flutter_port/data/preferences/preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeProvider', () {
    setUp(() async {
      // Initialize SharedPreferences with mock values for testing
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state is default theme', () async {
      final sharedPrefs = await SharedPreferences.getInstance();
      final prefsManager = PreferencesManager(sharedPrefs);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          preferencesManagerProvider.overrideWithValue(prefsManager),
        ],
      );
      addTearDown(() {
        container.dispose();
        prefsManager.dispose();
      });

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(themeProvider);

      expect(state.colorSchemeIndex, 0);
      expect(state.brightness, Brightness.dark);
    });

    test('setColorScheme updates state and persists', () async {
      final sharedPrefs = await SharedPreferences.getInstance();
      final prefsManager = PreferencesManager(sharedPrefs);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          preferencesManagerProvider.overrideWithValue(prefsManager),
        ],
      );
      addTearDown(() {
        container.dispose();
        prefsManager.dispose();
      });

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      final notifier = container.read(themeProvider.notifier);

      await notifier.setColorScheme(3);
      final state = container.read(themeProvider);

      expect(state.colorSchemeIndex, 3);
      expect(prefsManager.getThemeColorSchemeIndex(), 3);
    });

    test('toggleBrightness switches between light and dark', () async {
      final sharedPrefs = await SharedPreferences.getInstance();
      final prefsManager = PreferencesManager(sharedPrefs);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          preferencesManagerProvider.overrideWithValue(prefsManager),
        ],
      );
      addTearDown(() {
        container.dispose();
        prefsManager.dispose();
      });

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 100));

      final notifier = container.read(themeProvider.notifier);

      // Initial state is dark
      expect(container.read(themeProvider).brightness, Brightness.dark);

      // Toggle to light
      await notifier.toggleBrightness();
      expect(container.read(themeProvider).brightness, Brightness.light);
      expect(prefsManager.getThemeBrightness(), false);

      // Toggle back to dark
      await notifier.toggleBrightness();
      expect(container.read(themeProvider).brightness, Brightness.dark);
      expect(prefsManager.getThemeBrightness(), true);
    });
  });
}
