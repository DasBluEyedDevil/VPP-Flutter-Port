import 'package:freezed_annotation/freezed_annotation.dart';
import 'routine_exercise.dart';

part 'routine.freezed.dart';

/// Workout routine domain model
/// 
/// Contains a list of exercises with sets, reps, and weight configuration
@freezed
class Routine with _$Routine {
  const factory Routine({
    required String id,
    required String name,
    @Default('') String description, // Optional description for Phase 2
    required int createdAt,
    required int lastUsed,
    required int exerciseCount,
    @Default([]) List<RoutineExercise> exercises,
  }) = _Routine;
}
