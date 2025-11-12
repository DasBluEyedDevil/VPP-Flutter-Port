import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_mode.freezed.dart';

/// Program modes that use command 0x4F (96-byte frame)
/// Note: Official app uses 0x4F, NOT 0x04
@freezed
class ProgramMode with _$ProgramMode {
  const ProgramMode._();

  const factory ProgramMode.oldSchool() = OldSchool;
  const factory ProgramMode.pump() = Pump;
  const factory ProgramMode.tut() = TUT;
  const factory ProgramMode.tutBeast() = TUTBeast;
  const factory ProgramMode.eccentricOnly() = EccentricOnly;

  /// Mode value for protocol
  int get modeValue => switch (this) {
        OldSchool() => 0,
        Pump() => 2,
        TUT() => 3,
        TUTBeast() => 4,
        EccentricOnly() => 6,
        _ => throw UnimplementedError(),
      };

  /// Display name for UI
  String get displayName => switch (this) {
        OldSchool() => 'Old School',
        Pump() => 'Pump',
        TUT() => 'TUT',
        TUTBeast() => 'TUT Beast',
        EccentricOnly() => 'Eccentric Only',
        _ => throw UnimplementedError(),
      };

  /// Create ProgramMode from protocol value
  static ProgramMode fromValue(int value) {
    return switch (value) {
      0 => const ProgramMode.oldSchool(),
      2 => const ProgramMode.pump(),
      3 => const ProgramMode.tut(),
      4 => const ProgramMode.tutBeast(),
      6 => const ProgramMode.eccentricOnly(),
      _ => const ProgramMode.oldSchool(),
    };
  }
}
