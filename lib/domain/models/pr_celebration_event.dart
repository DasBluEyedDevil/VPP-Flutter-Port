import 'package:freezed_annotation/freezed_annotation.dart';

part 'pr_celebration_event.freezed.dart';

/// PR Celebration Event - Triggered when user achieves a new Personal Record
@freezed
class PRCelebrationEvent with _$PRCelebrationEvent {
  const factory PRCelebrationEvent({
    required String exerciseName,
    required double weightPerCableKg,
    required int reps,
    required String workoutMode,
  }) = _PRCelebrationEvent;
}
