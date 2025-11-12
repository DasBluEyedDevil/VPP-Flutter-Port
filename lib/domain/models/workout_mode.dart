import 'package:freezed_annotation/freezed_annotation.dart';
import 'echo_level.dart';
import 'eccentric_load.dart';
import 'workout_type.dart';
import 'program_mode.dart';

part 'workout_mode.freezed.dart';

/// WorkoutMode - Legacy sealed class for UI compatibility
/// Maps to WorkoutType for protocol usage
@freezed
class WorkoutMode with _$WorkoutMode {
  const WorkoutMode._();

  const factory WorkoutMode.oldSchool() = OldSchool;
  const factory WorkoutMode.pump() = Pump;
  const factory WorkoutMode.tut() = TUT;
  const factory WorkoutMode.tutBeast() = TUTBeast;
  const factory WorkoutMode.eccentricOnly() = EccentricOnly;
  const factory WorkoutMode.echo({
    required EchoLevel level,
  }) = Echo;

  /// Convert WorkoutMode to WorkoutType
  WorkoutType toWorkoutType({
    EccentricLoad eccentricLoad = EccentricLoad.load100,
  }) {
    return switch (this) {
      OldSchool() => WorkoutType.program(mode: const ProgramMode.oldSchool()),
      Pump() => WorkoutType.program(mode: const ProgramMode.pump()),
      TUT() => WorkoutType.program(mode: const ProgramMode.tut()),
      TUTBeast() => WorkoutType.program(mode: const ProgramMode.tutBeast()),
      EccentricOnly() => WorkoutType.program(
          mode: const ProgramMode.eccentricOnly(),
        ),
      Echo(:final level) => WorkoutType.echo(
          level: level,
          eccentricLoad: eccentricLoad,
        ),
      _ => throw UnimplementedError(),
    };
  }

  /// Display name for UI
  String get displayName => switch (this) {
        OldSchool() => 'Old School',
        Pump() => 'Pump',
        TUT() => 'TUT',
        TUTBeast() => 'TUT Beast',
        EccentricOnly() => 'Eccentric Only',
        Echo() => 'Echo',
        _ => throw UnimplementedError(),
      };
}
