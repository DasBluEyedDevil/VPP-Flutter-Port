import 'package:freezed_annotation/freezed_annotation.dart';
import 'program_mode.dart';
import 'eccentric_load.dart';
import 'echo_level.dart';

part 'routine_exercise.freezed.dart';

/// Exercise within a routine
/// 
/// Defines sets, reps, weight, and mode for a single exercise in a routine
@freezed
class RoutineExercise with _$RoutineExercise {
  const factory RoutineExercise({
    required String exerciseId,
    required int order, // Order within routine
    required int sets,
    required int reps,
    required double weightPerCableKg,
    required ProgramMode mode,
    EccentricLoad? eccentricLoad, // For Echo mode
    EchoLevel? echoLevel, // For Echo mode
    @Default(90) int restSeconds, // Rest duration between sets
  }) = _RoutineExercise;
}
