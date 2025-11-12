import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_stop_ui_state.freezed.dart';

/// Auto-stop UI state for Just Lift mode
/// 
/// Shows 3-second countdown timer when handles are in danger zone
@freezed
class AutoStopUiState with _$AutoStopUiState {
  const factory AutoStopUiState({
    @Default(false) bool isActive,
    @Default(0.0) double progress, // 0.0 to 1.0
    @Default(0) int secondsRemaining,
  }) = _AutoStopUiState;
}
