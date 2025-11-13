import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/preferences/preferences_manager.dart';
import '../../domain/models/user_preferences.dart';
import '../../domain/models/weight_unit.dart';
import 'workout_session_provider.dart' show workoutRepositoryProvider;
import 'ble_connection_provider.dart' show bleRepositoryProvider;
import '../../data/repositories/workout_repository.dart';
import '../../data/repositories/ble_repository.dart';

/// Provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden with actual SharedPreferences instance',
  );
});

/// Provider for PreferencesManager
final preferencesManagerProvider = Provider<PreferencesManager>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return PreferencesManager(sharedPrefs);
});

/// Stream provider for user preferences
///
/// Emits updates whenever preferences change
final userPreferencesProvider = StreamProvider<UserPreferences>((ref) {
  final prefsManager = ref.watch(preferencesManagerProvider);
  return prefsManager.preferencesStream;
});

/// Provider for current weight unit preference
///
/// Derived from userPreferencesProvider
final weightUnitProvider = Provider<WeightUnit>((ref) {
  final prefsAsync = ref.watch(userPreferencesProvider);
  return prefsAsync.when(
    data: (prefs) => prefs.weightUnit,
    loading: () => WeightUnit.kg, // Default while loading
    error: (_, __) => WeightUnit.kg, // Default on error
  );
});

/// Provider for stop-at-top preference
///
/// Controls rep detection mode (stop at top vs full range)
final stopAtTopProvider = Provider<bool>((ref) {
  final prefsAsync = ref.watch(userPreferencesProvider);
  return prefsAsync.when(
    data: (prefs) => prefs.stopAtTop,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for video playback preference
final enableVideoPlaybackProvider = Provider<bool>((ref) {
  final prefsAsync = ref.watch(userPreferencesProvider);
  return prefsAsync.when(
    data: (prefs) => prefs.enableVideoPlayback,
    loading: () => true,
    error: (_, __) => true,
  );
});

/// Provider for autoplay preference
final autoplayEnabledProvider = Provider<bool>((ref) {
  final prefsAsync = ref.watch(userPreferencesProvider);
  return prefsAsync.when(
    data: (prefs) => prefs.autoplayEnabled,
    loading: () => true,
    error: (_, __) => true,
  );
});

/// Actions provider for updating preferences
final preferencesActionsProvider = Provider<PreferencesActions>((ref) {
  final prefsManager = ref.watch(preferencesManagerProvider);
  final workoutRepo = ref.watch(workoutRepositoryProvider);
  final bleRepo = ref.watch(bleRepositoryProvider);
  return PreferencesActions(prefsManager, workoutRepo, bleRepo);
});

/// Actions class for preference updates
///
/// Ported from MainViewModel.kt preference methods (lines 1403-1421)
class PreferencesActions {
  final PreferencesManager _prefsManager;
  final WorkoutRepository _workoutRepo;
  final BleRepository _bleRepo;

  PreferencesActions(this._prefsManager, this._workoutRepo, this._bleRepo);

  /// Update weight unit preference
  Future<void> setWeightUnit(WeightUnit unit) async {
    await _prefsManager.setWeightUnit(unit);
  }

  /// Update autoplay preference
  Future<void> setAutoplayEnabled(bool enabled) async {
    await _prefsManager.setAutoplayEnabled(enabled);
  }

  /// Update stop-at-top preference
  Future<void> setStopAtTop(bool enabled) async {
    await _prefsManager.setStopAtTop(enabled);
  }

  /// Update video playback preference
  Future<void> setEnableVideoPlayback(bool enabled) async {
    await _prefsManager.setEnableVideoPlayback(enabled);
  }

  /// Convert kilograms to display weight based on unit
  ///
  /// Ported from MainViewModel.kt (line 1430)
  double kgToDisplay(double kg, WeightUnit unit) {
    switch (unit) {
      case WeightUnit.kg:
        return kg;
      case WeightUnit.lb:
        return kg * 2.20462;
    }
  }

  /// Convert display weight to kilograms based on unit
  ///
  /// Ported from MainViewModel.kt (line 1436)
  double displayToKg(double display, WeightUnit unit) {
    switch (unit) {
      case WeightUnit.kg:
        return display;
      case WeightUnit.lb:
        return display / 2.20462;
    }
  }

  /// Format weight for display with unit suffix
  ///
  /// Ported from MainViewModel.kt (line 1442)
  String formatWeight(double kg, WeightUnit unit) {
    final displayValue = kgToDisplay(kg, unit);
    final unitSuffix = unit == WeightUnit.kg ? 'kg' : 'lb';
    return '${displayValue.toStringAsFixed(1)} $unitSuffix';
  }

  /// Delete all workouts
  ///
  /// Ported from SettingsViewModel.kt deleteAllWorkouts method
  Future<void> deleteAllWorkouts() async {
    await _workoutRepo.deleteAllWorkouts();
  }

  /// Send color scheme command to BLE device
  ///
  /// Ported from SettingsViewModel.kt sendColorSchemeCommand method
  /// [colorIndex] should be 0-6 (Blue, Green, Teal, Yellow, Pink, Red, Purple)
  Future<void> sendColorSchemeCommand(int colorIndex) async {
    if (colorIndex < 0 || colorIndex > 6) {
      throw ArgumentError('Color index must be 0-6');
    }
    final result = await _bleRepo.setColorScheme(colorIndex);
    result.fold(
      (error) => throw error,
      (_) => null,
    );
  }
}
