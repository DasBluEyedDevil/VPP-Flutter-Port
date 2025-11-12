import 'weight_unit.dart';

/// User preferences data class
///
/// Ported from UserPreferences.kt
class UserPreferences {
  final WeightUnit weightUnit;
  final bool autoplayEnabled;
  final bool stopAtTop; // false = stop at bottom (extended), true = stop at top (contracted)
  final bool enableVideoPlayback; // true = show videos, false = hide videos to avoid slow loading

  const UserPreferences({
    this.weightUnit = WeightUnit.kg,
    this.autoplayEnabled = true,
    this.stopAtTop = false,
    this.enableVideoPlayback = true,
  });

  UserPreferences copyWith({
    WeightUnit? weightUnit,
    bool? autoplayEnabled,
    bool? stopAtTop,
    bool? enableVideoPlayback,
  }) {
    return UserPreferences(
      weightUnit: weightUnit ?? this.weightUnit,
      autoplayEnabled: autoplayEnabled ?? this.autoplayEnabled,
      stopAtTop: stopAtTop ?? this.stopAtTop,
      enableVideoPlayback: enableVideoPlayback ?? this.enableVideoPlayback,
    );
  }
}
