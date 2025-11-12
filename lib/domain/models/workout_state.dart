import 'package:freezed_annotation/freezed_annotation.dart';
import 'workout_metric.dart';

part 'workout_state.freezed.dart';

/// Workout state sealed class representing workout execution states
@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState.idle() = Idle;
  const factory WorkoutState.initializing() = Initializing;
  const factory WorkoutState.countdown({
    required int secondsRemaining,
  }) = Countdown;
  const factory WorkoutState.active() = Active;
  const factory WorkoutState.setSummary({
    required List<WorkoutMetric> metrics,
    required double peakPower,
    required double averagePower,
    required int repCount,
  }) = SetSummary;
  const factory WorkoutState.paused() = Paused;
  const factory WorkoutState.completed() = Completed;
  const factory WorkoutState.error({
    required String message,
  }) = WorkoutError;
  const factory WorkoutState.resting({
    required int restSecondsRemaining,
    required String nextExerciseName,
    required bool isLastExercise,
    required int currentSet,
    required int totalSets,
  }) = Resting;
}
