import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../../domain/models/user_preferences.dart';
import '../../domain/models/weight_unit.dart';

final logger = Logger();

/// Manager for user preferences using SharedPreferences
///
/// Ported from PreferencesManager.kt
class PreferencesManager {
  static const String _weightUnitKey = 'weight_unit';
  static const String _autoplayEnabledKey = 'autoplay_enabled';
  static const String _stopAtTopKey = 'stop_at_top';
  static const String _enableVideoPlaybackKey = 'enable_video_playback';
  static const String _themeColorSchemeIndexKey = 'theme_color_scheme_index';
  static const String _themeBrightnessKey = 'theme_brightness';

  final SharedPreferences _prefs;
  final _preferencesController = StreamController<UserPreferences>.broadcast();

  PreferencesManager(this._prefs) {
    // Initialize the stream with current preferences
    _preferencesController.add(_loadPreferences());
  }

  /// Stream of user preferences
  Stream<UserPreferences> get preferencesStream => _preferencesController.stream;

  /// Get current preferences synchronously
  UserPreferences get currentPreferences => _loadPreferences();

  /// Load preferences from storage
  UserPreferences _loadPreferences() {
    final weightUnitString = _prefs.getString(_weightUnitKey);
    WeightUnit weightUnit;
    try {
      weightUnit = weightUnitString != null
          ? WeightUnit.values.firstWhere(
              (unit) => unit.name.toLowerCase() == weightUnitString.toLowerCase(),
              orElse: () => WeightUnit.kg,
            )
          : WeightUnit.kg;
    } catch (e) {
      logger.w('Invalid weight unit in preferences: $weightUnitString, defaulting to KG', error: e);
      weightUnit = WeightUnit.kg;
    }

    final autoplayEnabled = _prefs.getBool(_autoplayEnabledKey) ?? true;
    final stopAtTop = _prefs.getBool(_stopAtTopKey) ?? false;
    final enableVideoPlayback = _prefs.getBool(_enableVideoPlaybackKey) ?? true;

    return UserPreferences(
      weightUnit: weightUnit,
      autoplayEnabled: autoplayEnabled,
      stopAtTop: stopAtTop,
      enableVideoPlayback: enableVideoPlayback,
    );
  }

  /// Set the weight unit preference
  Future<void> setWeightUnit(WeightUnit unit) async {
    await _prefs.setString(_weightUnitKey, unit.name);
    logger.d('Weight unit preference set to: ${unit.name}');
    _preferencesController.add(_loadPreferences());
  }

  /// Set the autoplay enabled preference
  Future<void> setAutoplayEnabled(bool enabled) async {
    await _prefs.setBool(_autoplayEnabledKey, enabled);
    logger.d('Autoplay enabled preference set to: $enabled');
    _preferencesController.add(_loadPreferences());
  }

  /// Set the stop at top preference
  Future<void> setStopAtTop(bool enabled) async {
    await _prefs.setBool(_stopAtTopKey, enabled);
    logger.d('Stop at top preference set to: $enabled');
    _preferencesController.add(_loadPreferences());
  }

  /// Set the enable video playback preference
  Future<void> setEnableVideoPlayback(bool enabled) async {
    await _prefs.setBool(_enableVideoPlaybackKey, enabled);
    logger.d('Enable video playback preference set to: $enabled');
    _preferencesController.add(_loadPreferences());
  }

  /// Get the theme color scheme index (0-6)
  int getThemeColorSchemeIndex() {
    return _prefs.getInt(_themeColorSchemeIndexKey) ?? 0;
  }

  /// Set the theme color scheme index (0-6)
  Future<void> setThemeColorSchemeIndex(int index) async {
    await _prefs.setInt(_themeColorSchemeIndexKey, index);
    logger.d('Theme color scheme index set to: $index');
  }

  /// Get the theme brightness (true = dark, false = light)
  bool getThemeBrightness() {
    return _prefs.getBool(_themeBrightnessKey) ?? true; // Default to dark
  }

  /// Set the theme brightness (true = dark, false = light)
  Future<void> setThemeBrightness(bool isDark) async {
    await _prefs.setBool(_themeBrightnessKey, isDark);
    logger.d('Theme brightness set to: ${isDark ? "dark" : "light"}');
  }

  /// Dispose resources
  void dispose() {
    _preferencesController.close();
  }
}
