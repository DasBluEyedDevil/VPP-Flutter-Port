import 'dart:typed_data';
import 'package:vpp_flutter_port/domain/models/workout_parameters.dart';
import 'package:vpp_flutter_port/domain/models/program_mode.dart';
import 'package:vpp_flutter_port/domain/models/echo_level.dart';
import 'package:vpp_flutter_port/domain/models/workout_type.dart';
import 'constants.dart';

/// Protocol Builder - Builds binary protocol frames for Vitruvian device communication
/// 
/// Ported from protocol.js and modes.js in the reference web application.
/// 
/// CRITICAL: This is the foundation for ALL device communication. Every byte must be
/// exactly correct or the hardware will reject commands. Frame sizes CANNOT be split.
class ProtocolBuilder {
  ProtocolBuilder._(); // Private constructor to prevent instantiation

  /// Build the initial 4-byte command sent before INIT
  /// 
  /// Returns: [0x0A, 0x00, 0x00, 0x00]
  static Uint8List buildInitCommand() {
    return Uint8List.fromList([0x0A, 0x00, 0x00, 0x00]);
  }

  /// Build the INIT preset frame with coefficient table (34 bytes)
  /// 
  /// Contains initialization coefficients and color scheme data.
  static Uint8List buildInitPreset() {
    return Uint8List.fromList([
      0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00,
      0xCD, 0xCC, 0xCC, 0x3E, // 0.4 as float32 LE
      0xFF, 0x00, 0x4C, 0xFF,
      0x23, 0x8C, 0xFF, 0x8C,
      0x8C, 0xFF, 0x00, 0x4C,
      0xFF, 0x23, 0x8C, 0xFF,
      0x8C, 0x8C
    ]);
  }

  /// Build the 96-byte program parameters frame
  /// 
  /// CRITICAL: Working web app uses command 0x04 (verified from console logs).
  /// This frame configures workout parameters including mode, weight, reps, and progression.
  /// 
  /// FIRMWARE QUIRKS:
  /// - Reps field: For Just Lift, use 0xFF; for others, use reps+warmup+1
  ///   The +1 compensates for completeCounter incrementing at START of concentric (not end).
  ///   Without it, machine releases tension as you BEGIN the final rep.
  /// - Weight calculation: Machine applies progression starting from "rep 0" (before first rep).
  ///   To get correct behavior where first working rep has base weight, we must subtract
  ///   progression from base weight when sending to firmware.
  /// - Effective kg = weightPerCableKg + 10.0 (firmware offset)
  static Uint8List buildProgramParams(WorkoutParameters params) {
    final frame = Uint8List(ProtocolConstants.programParamsSize);
    final byteData = ByteData.view(frame.buffer);

    // Header section - Command 0x04 for PROGRAM mode (verified from working web app)
    frame[0] = ProtocolConstants.cmdProgramParams;
    frame[1] = 0x00;
    frame[2] = 0x00;
    frame[3] = 0x00;

    // Reps field at offset 0x04
    // For Just Lift, use 0xFF; for others, use reps+warmup+1
    // The +1 compensates for completeCounter incrementing at START of concentric (not end)
    // Without it, machine releases tension as you BEGIN the final rep
    frame[0x04] = params.isJustLift 
        ? 0xFF 
        : (params.reps + params.warmupReps + 1).clamp(0, 255);

    // Some constant values from the working capture
    frame[5] = 0x03;
    frame[6] = 0x03;
    frame[7] = 0x00;

    // Float values at 0x08, 0x0c, 0x1c (appear to be constant 5.0)
    byteData.setFloat32(0x08, 5.0, Endian.little);
    byteData.setFloat32(0x0c, 5.0, Endian.little);
    byteData.setFloat32(0x1c, 5.0, Endian.little);

    // Fill in some other fields from the working capture
    frame[0x14] = 0xFA;
    frame[0x15] = 0x00;
    frame[0x16] = 0xFA;
    frame[0x17] = 0x00;
    frame[0x18] = 0xC8;
    frame[0x19] = 0x00;
    frame[0x1a] = 0x1E;
    frame[0x1b] = 0x00;

    // Repeat pattern
    frame[0x24] = 0xFA;
    frame[0x25] = 0x00;
    frame[0x26] = 0xFA;
    frame[0x27] = 0x00;
    frame[0x28] = 0xC8;
    frame[0x29] = 0x00;
    frame[0x2a] = 0x1E;
    frame[0x2b] = 0x00;

    frame[0x2c] = 0xFA;
    frame[0x2d] = 0x00;
    frame[0x2e] = 0x50;
    frame[0x2f] = 0x00;

    // Get the mode profile block (32 bytes for offsets 0x30-0x4F)
    // For Just Lift, use the base mode; otherwise use the mode directly
    ProgramMode profileMode = switch (params.workoutType) {
      Program(:final mode) => params.isJustLift
          ? const ProgramMode.oldSchool() // For Just Lift, use Old School as base mode
          : mode,
      Echo() => const ProgramMode.oldSchool(), // Echo mode uses Old School as base profile
      _ => throw UnimplementedError(),
    };
    
    final profile = _getModeProfile(profileMode);
    frame.setRange(0x30, 0x30 + profile.length, profile);

    // Calculate weights for protocol
    // FIRMWARE QUIRK: Machine applies progression starting from "rep 0" (before first rep)
    // To get correct behavior where first working rep has base weight,
    // we must subtract progression from base weight when sending to firmware
    final adjustedWeightPerCable = params.progressionRegressionKg != 0.0
        ? params.weightPerCableKg - params.progressionRegressionKg
        : params.weightPerCableKg;

    final totalWeightKg = adjustedWeightPerCable;
    final effectiveKg = adjustedWeightPerCable + 10.0;

    // Effective weight at offset 0x54
    byteData.setFloat32(0x54, effectiveKg, Endian.little);

    // Total weight at offset 0x58
    byteData.setFloat32(0x58, totalWeightKg, Endian.little);

    // Progression/Regression at offset 0x5C (kg per rep)
    byteData.setFloat32(0x5c, params.progressionRegressionKg, Endian.little);

    return frame;
  }

  /// Build Echo mode control frame (40 bytes)
  /// 
  /// Configures Echo mode workout parameters including difficulty level,
  /// rep counts, and eccentric load settings.
  /// 
  /// NOTE: Kotlin source uses 32 bytes, but ProtocolConstants specifies 40 bytes.
  /// Using 40 bytes to match the constant definition.
  /// 
  /// FIRMWARE QUIRK: For Just Lift Echo mode, use 0xFF; otherwise use targetReps+1.
  /// The +1 compensates for completeCounter incrementing at START of concentric (not end).
  /// Without it, machine releases tension as you BEGIN the final rep.
  static Uint8List buildEchoControl({
    required EchoLevel level,
    int warmupReps = 3,
    int targetReps = 2,
    bool isJustLift = false,
    int eccentricPct = 75,
  }) {
    // NOTE: Kotlin uses 32 bytes, but ProtocolConstants.echoControlSize = 40
    // Using 40 bytes to match the constant. Extra 8 bytes will be zero-padded.
    final frame = Uint8List(ProtocolConstants.echoControlSize);
    final byteData = ByteData.view(frame.buffer);

    // Command ID at 0x00 (u32) = 0x4E (78 decimal)
    byteData.setInt32(0x00, 0x0000004E, Endian.little);

    // Warmup (0x04) and working reps (0x05)
    frame[0x04] = warmupReps.clamp(0, 255);

    // For Just Lift Echo mode, use 0xFF; otherwise use targetReps+1
    // The +1 compensates for completeCounter incrementing at START of concentric (not end)
    // Without it, machine releases tension as you BEGIN the final rep
    frame[0x05] = isJustLift 
        ? 0xFF 
        : (targetReps + 1).clamp(0, 255);

    // Reserved at 0x06-0x07 (u16 = 0)
    byteData.setInt16(0x06, 0, Endian.little);

    // Get Echo parameters for this level
    final echoParams = _getEchoParams(level, eccentricPct);

    // Eccentric % at 0x08 (u16)
    byteData.setInt16(0x08, echoParams.eccentricPct, Endian.little);

    // Concentric % at 0x0A (u16)
    byteData.setInt16(0x0a, echoParams.concentricPct, Endian.little);

    // Smoothing at 0x0C (f32)
    byteData.setFloat32(0x0c, echoParams.smoothing, Endian.little);

    // Gain at 0x10 (f32)
    byteData.setFloat32(0x10, echoParams.gain, Endian.little);

    // Cap at 0x14 (f32)
    byteData.setFloat32(0x14, echoParams.cap, Endian.little);

    // Floor at 0x18 (f32)
    byteData.setFloat32(0x18, echoParams.floor, Endian.little);

    // Neg limit at 0x1C (f32)
    byteData.setFloat32(0x1c, echoParams.negLimit, Endian.little);

    return frame;
  }

  /// Build a 44-byte color scheme packet
  /// 
  /// Configures LED colors and brightness for the device display.
  /// 
  /// Requires exactly 3 colors (repeated twice for left/right mirroring).
  static Uint8List buildColorScheme(double brightness, List<RGBColor> colors) {
    if (colors.length != 3) {
      throw ArgumentError('Color scheme must have exactly 3 colors');
    }

    final frame = Uint8List(ProtocolConstants.colorSchemeSize);
    final byteData = ByteData.view(frame.buffer);

    // Command ID: 0x00000011
    byteData.setInt32(0, 0x00000011, Endian.little);

    // Reserved fields
    byteData.setInt32(4, 0, Endian.little);
    byteData.setInt32(8, 0, Endian.little);

    // Brightness (float32)
    byteData.setFloat32(12, brightness, Endian.little);

    // Colors: 6 RGB triplets (3 colors repeated twice for left/right mirroring)
    var offset = 16;
    for (var i = 0; i < 2; i++) {
      // Repeat twice
      for (final color in colors) {
        frame[offset++] = color.r;
        frame[offset++] = color.g;
        frame[offset++] = color.b;
      }
    }

    return frame;
  }

  /// Build the START command (4 bytes)
  static Uint8List buildStartCommand() {
    return Uint8List.fromList([0x03, 0x00, 0x00, 0x00]);
  }

  /// Build the STOP command (4 bytes)
  static Uint8List buildStopCommand() {
    return Uint8List.fromList([0x05, 0x00, 0x00, 0x00]);
  }

  /// Build a color scheme command using predefined schemes
  static Uint8List buildColorSchemeCommand(int schemeIndex) {
    final schemes = ColorSchemes.all;
    final scheme = schemeIndex >= 0 && schemeIndex < schemes.length
        ? schemes[schemeIndex]
        : schemes[0];
    return buildColorScheme(scheme.brightness, scheme.colors);
  }

  /// Get mode profile block for program modes (32 bytes)
  /// 
  /// Returns the binary profile data for the specified program mode.
  /// These profiles define resistance curves and timing parameters.
  static Uint8List _getModeProfile(ProgramMode mode) {
    final buffer = Uint8List(32);
    final byteData = ByteData.view(buffer.buffer);

    switch (mode) {
      case OldSchool():
        byteData.setInt16(0x00, 0, Endian.little);
        byteData.setInt16(0x02, 20, Endian.little);
        byteData.setFloat32(0x04, 3.0, Endian.little);
        byteData.setInt16(0x08, 75, Endian.little);
        byteData.setInt16(0x0a, 600, Endian.little);
        byteData.setFloat32(0x0c, 50.0, Endian.little);
        byteData.setInt16(0x10, -1300, Endian.little);
        byteData.setInt16(0x12, -1200, Endian.little);
        byteData.setFloat32(0x14, 100.0, Endian.little);
        byteData.setInt16(0x18, -260, Endian.little);
        byteData.setInt16(0x1a, -110, Endian.little);
        byteData.setFloat32(0x1c, 0.0, Endian.little);
        break;

      case Pump():
        byteData.setInt16(0x00, 50, Endian.little);
        byteData.setInt16(0x02, 450, Endian.little);
        byteData.setFloat32(0x04, 10.0, Endian.little);
        byteData.setInt16(0x08, 500, Endian.little);
        byteData.setInt16(0x0a, 600, Endian.little);
        byteData.setFloat32(0x0c, 50.0, Endian.little);
        byteData.setInt16(0x10, -700, Endian.little);
        byteData.setInt16(0x12, -550, Endian.little);
        byteData.setFloat32(0x14, 1.0, Endian.little);
        byteData.setInt16(0x18, -100, Endian.little);
        byteData.setInt16(0x1a, -50, Endian.little);
        byteData.setFloat32(0x1c, 1.0, Endian.little);
        break;

      case TUT():
        byteData.setInt16(0x00, 250, Endian.little);
        byteData.setInt16(0x02, 350, Endian.little);
        byteData.setFloat32(0x04, 7.0, Endian.little);
        byteData.setInt16(0x08, 450, Endian.little);
        byteData.setInt16(0x0a, 600, Endian.little);
        byteData.setFloat32(0x0c, 50.0, Endian.little);
        byteData.setInt16(0x10, -900, Endian.little);
        byteData.setInt16(0x12, -700, Endian.little);
        byteData.setFloat32(0x14, 70.0, Endian.little);
        byteData.setInt16(0x18, -100, Endian.little);
        byteData.setInt16(0x1a, -50, Endian.little);
        byteData.setFloat32(0x1c, 14.0, Endian.little);
        break;

      case TUTBeast():
        byteData.setInt16(0x00, 150, Endian.little);
        byteData.setInt16(0x02, 250, Endian.little);
        byteData.setFloat32(0x04, 7.0, Endian.little);
        byteData.setInt16(0x08, 350, Endian.little);
        byteData.setInt16(0x0a, 450, Endian.little);
        byteData.setFloat32(0x0c, 50.0, Endian.little);
        byteData.setInt16(0x10, -900, Endian.little);
        byteData.setInt16(0x12, -700, Endian.little);
        byteData.setFloat32(0x14, 70.0, Endian.little);
        byteData.setInt16(0x18, -100, Endian.little);
        byteData.setInt16(0x1a, -50, Endian.little);
        byteData.setFloat32(0x1c, 28.0, Endian.little);
        break;

      case EccentricOnly():
        byteData.setInt16(0x00, 50, Endian.little);
        byteData.setInt16(0x02, 550, Endian.little);
        byteData.setFloat32(0x04, 50.0, Endian.little);
        byteData.setInt16(0x08, 650, Endian.little);
        byteData.setInt16(0x0a, 750, Endian.little);
        byteData.setFloat32(0x0c, 10.0, Endian.little);
        byteData.setInt16(0x10, -900, Endian.little);
        byteData.setInt16(0x12, -700, Endian.little);
        byteData.setFloat32(0x14, 70.0, Endian.little);
        byteData.setInt16(0x18, -100, Endian.little);
        byteData.setInt16(0x1a, -50, Endian.little);
        byteData.setFloat32(0x1c, 20.0, Endian.little);
        break;
    }

    return buffer;
  }

  /// Get Echo parameters for a given level
  static _EchoParams _getEchoParams(EchoLevel level, int eccentricPct) {
    final baseParams = _EchoParams(
      eccentricPct: eccentricPct,
      concentricPct: 50, // constant
      smoothing: 0.1,
      floor: 0.0,
      negLimit: -100.0,
      gain: 1.0,
      cap: 50.0,
    );

    switch (level) {
      case EchoLevel.hard:
        return baseParams.copyWith(gain: 1.0, cap: 50.0);
      case EchoLevel.harder:
        return baseParams.copyWith(gain: 1.25, cap: 40.0);
      case EchoLevel.hardest:
        return baseParams.copyWith(gain: 1.667, cap: 30.0);
      case EchoLevel.epic:
        return baseParams.copyWith(gain: 3.333, cap: 15.0);
    }
  }
}

/// Echo parameters data class
class _EchoParams {
  final int eccentricPct;
  final int concentricPct;
  final double smoothing;
  final double floor;
  final double negLimit;
  final double gain;
  final double cap;

  const _EchoParams({
    required this.eccentricPct,
    required this.concentricPct,
    required this.smoothing,
    required this.floor,
    required this.negLimit,
    required this.gain,
    required this.cap,
  });

  _EchoParams copyWith({
    int? eccentricPct,
    int? concentricPct,
    double? smoothing,
    double? floor,
    double? negLimit,
    double? gain,
    double? cap,
  }) {
    return _EchoParams(
      eccentricPct: eccentricPct ?? this.eccentricPct,
      concentricPct: concentricPct ?? this.concentricPct,
      smoothing: smoothing ?? this.smoothing,
      floor: floor ?? this.floor,
      negLimit: negLimit ?? this.negLimit,
      gain: gain ?? this.gain,
      cap: cap ?? this.cap,
    );
  }
}

/// RGB Color data class
class RGBColor {
  final int r;
  final int g;
  final int b;

  const RGBColor({
    required this.r,
    required this.g,
    required this.b,
  }) : assert(r >= 0 && r <= 255, 'Red value must be 0-255'),
       assert(g >= 0 && g <= 255, 'Green value must be 0-255'),
       assert(b >= 0 && b <= 255, 'Blue value must be 0-255');
}

/// Color scheme data class
class ColorScheme {
  final String name;
  final double brightness;
  final List<RGBColor> colors;

  const ColorScheme({
    required this.name,
    required this.brightness,
    required this.colors,
  });
}

/// Predefined color schemes
class ColorSchemes {
  ColorSchemes._(); // Private constructor

  static const blue = ColorScheme(
    name: 'Blue',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0x00, g: 0xA8, b: 0xDD),
      RGBColor(r: 0x00, g: 0xCF, b: 0xFC),
      RGBColor(r: 0x5D, g: 0xDF, b: 0xFC),
    ],
  );

  static const green = ColorScheme(
    name: 'Green',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0x7D, g: 0xC1, b: 0x47),
      RGBColor(r: 0xA1, g: 0xD8, b: 0x6A),
      RGBColor(r: 0xBA, g: 0xE0, b: 0x94),
    ],
  );

  static const teal = ColorScheme(
    name: 'Teal',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0x3E, g: 0x9A, b: 0xB7),
      RGBColor(r: 0x83, g: 0xBE, b: 0xD1),
      RGBColor(r: 0xC2, g: 0xDF, b: 0xE8),
    ],
  );

  static const yellow = ColorScheme(
    name: 'Yellow',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0xFF, g: 0x90, b: 0x51),
      RGBColor(r: 0xFF, g: 0xD6, b: 0x47),
      RGBColor(r: 0xFF, g: 0xB7, b: 0x00),
    ],
  );

  static const pink = ColorScheme(
    name: 'Pink',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0xFF, g: 0x00, b: 0x4C),
      RGBColor(r: 0xFF, g: 0x23, b: 0x8C),
      RGBColor(r: 0xFF, g: 0x8C, b: 0x8C),
    ],
  );

  static const red = ColorScheme(
    name: 'Red',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0xFF, g: 0x00, b: 0x00),
      RGBColor(r: 0xFF, g: 0x55, b: 0x55),
      RGBColor(r: 0xFF, g: 0xAA, b: 0xAA),
    ],
  );

  static const purple = ColorScheme(
    name: 'Purple',
    brightness: 0.4,
    colors: [
      RGBColor(r: 0x88, g: 0x00, b: 0xFF),
      RGBColor(r: 0xAA, g: 0x55, b: 0xFF),
      RGBColor(r: 0xDD, g: 0xAA, b: 0xFF),
    ],
  );

  static const all = [
    blue,
    green,
    teal,
    yellow,
    pink,
    red,
    purple,
  ];
}
