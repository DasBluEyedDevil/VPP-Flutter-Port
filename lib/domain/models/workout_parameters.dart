import 'package:freezed_annotation/freezed_annotation.dart';
import 'workout_type.dart';

part 'workout_parameters.freezed.dart';

/// Workout parameters for configuring a workout session
@freezed
class WorkoutParameters with _$WorkoutParameters {
  const factory WorkoutParameters({
    required WorkoutType workoutType,
    required int reps,
    @Default(0.0) double weightPerCableKg, // Only used for Program modes
    @Default(0.0) double progressionRegressionKg, // Only used for Program modes (not TUT/TUTBeast)
    @Default(false) bool isJustLift,
    @Default(false) bool useAutoStart, // true for Just Lift, false for others
    @Default(false) bool stopAtTop, // false = stop at bottom (extended), true = stop at top (contracted)
    @Default(3) int warmupReps,
    String? selectedExerciseId,
  }) = _WorkoutParameters;
}
