import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'workout_session.freezed.dart';

/// Workout session data (simplified for database storage)
@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    @Default('') String id,
    @Default(0) int timestamp,
    @Default('OldSchool') String mode,
    @Default(10) int reps,
    @Default(10.0) double weightPerCableKg,
    @Default(0.0) double progressionKg,
    @Default(0) int duration,
    @Default(0) int totalReps,
    @Default(0) int warmupReps,
    @Default(0) int workingReps,
    @Default(false) bool isJustLift,
    @Default(false) bool stopAtTop,
    // Echo mode configuration
    @Default(100) int eccentricLoad, // Percentage (0, 50, 75, 100, 125, 150)
    @Default(2) int echoLevel, // 1=Hard, 2=Harder, 3=Hardest, 4=Epic
    // Exercise tracking
    String? exerciseId, // Exercise library ID for PR tracking
  }) = _WorkoutSession;

  /// Create a new WorkoutSession with generated ID and timestamp
  factory WorkoutSession.create({
    String? id,
    int? timestamp,
    String mode = 'OldSchool',
    int reps = 10,
    double weightPerCableKg = 10.0,
    double progressionKg = 0.0,
    int duration = 0,
    int totalReps = 0,
    int warmupReps = 0,
    int workingReps = 0,
    bool isJustLift = false,
    bool stopAtTop = false,
    int eccentricLoad = 100,
    int echoLevel = 2,
    String? exerciseId,
  }) {
    return WorkoutSession(
      id: id ?? const Uuid().v4(),
      timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      mode: mode,
      reps: reps,
      weightPerCableKg: weightPerCableKg,
      progressionKg: progressionKg,
      duration: duration,
      totalReps: totalReps,
      warmupReps: warmupReps,
      workingReps: workingReps,
      isJustLift: isJustLift,
      stopAtTop: stopAtTop,
      eccentricLoad: eccentricLoad,
      echoLevel: echoLevel,
      exerciseId: exerciseId,
    );
  }
}
