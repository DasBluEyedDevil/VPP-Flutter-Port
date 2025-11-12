import 'package:freezed_annotation/freezed_annotation.dart';

part 'rep_count.freezed.dart';

/// Rep count tracking
@freezed
class RepCount with _$RepCount {
  const RepCount._();

  const factory RepCount({
    @Default(0) int warmupReps,
    @Default(0) int workingReps,
    @Default(false) bool isWarmupComplete,
  }) = _RepCount;

  /// Total reps (exclude warm-up reps from total count)
  int get totalReps => workingReps;
}

/// Rep event types
enum RepType {
  warmupCompleted,
  workingCompleted,
  warmupComplete,
  workoutComplete,
}

/// Rep event data
@freezed
class RepEvent with _$RepEvent {
  const factory RepEvent({
    required RepType type,
    required int warmupCount,
    required int workingCount,
    @Default(0) int timestamp,
  }) = _RepEvent;
}
