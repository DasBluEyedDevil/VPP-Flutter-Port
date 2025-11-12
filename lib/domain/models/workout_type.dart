import 'package:freezed_annotation/freezed_annotation.dart';
import 'echo_level.dart';
import 'eccentric_load.dart';
import 'program_mode.dart';
import 'workout_mode.dart' show WorkoutMode;

part 'workout_type.freezed.dart';

/// Workout type - either Program (0x04) or Echo (0x4E)
@freezed
class WorkoutType with _$WorkoutType {
  const WorkoutType._();

  const factory WorkoutType.program({
    required ProgramMode mode,
  }) = Program;
  const factory WorkoutType.echo({
    required EchoLevel level,
    required EccentricLoad eccentricLoad,
  }) = Echo;

  /// Display name for UI
  String get displayName => switch (this) {
        Program(:final mode) => mode.displayName,
        Echo() => 'Echo',
        _ => throw UnimplementedError(),
      };

  /// Mode value for protocol
  int get modeValue => switch (this) {
        Program(:final mode) => mode.modeValue,
        Echo() => 10,
        _ => throw UnimplementedError(),
      };

  /// Convert WorkoutType to WorkoutMode for UI compatibility
  WorkoutMode toWorkoutMode() {
    return switch (this) {
      Program(:final mode) => switch (mode) {
          OldSchool() => const WorkoutMode.oldSchool(),
          Pump() => const WorkoutMode.pump(),
          TUT() => const WorkoutMode.tut(),
          TUTBeast() => const WorkoutMode.tutBeast(),
          EccentricOnly() => const WorkoutMode.eccentricOnly(),
          _ => throw UnimplementedError(),
        },
      Echo(:final level) => WorkoutMode.echo(level: level),
      _ => throw UnimplementedError(),
    };
  }
}
