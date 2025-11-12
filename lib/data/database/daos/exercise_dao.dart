import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/exercises.dart';
import '../tables/exercise_videos.dart';
import '../tables/routine_exercises.dart';

part 'exercise_dao.g.dart';

@DriftAccessor(tables: [
  Exercises,
  ExerciseVideos,
  RoutineExercises,
])
class ExerciseDao extends DatabaseAccessor<AppDatabase> with _$ExerciseDaoMixin {
  final AppDatabase db;
  ExerciseDao(this.db) : super(db);

  // ========== Exercises ==========

  /// Insert a new exercise
  Future<String> insertExercise(ExercisesCompanion exercise) async {
    await into(exercises).insert(exercise);
    return exercise.id.value;
  }

  /// Update an exercise
  Future<bool> updateExercise(ExercisesCompanion exercise) {
    return update(exercises).replace(exercise);
  }

  /// Delete an exercise (CASCADE will delete ExerciseVideos)
  Future<int> deleteExercise(String exerciseId) {
    return (delete(exercises)..where((t) => t.id.equals(exerciseId))).go();
  }

  /// Get an exercise by ID
  Future<Exercise?> getExerciseById(String exerciseId) {
    return (select(exercises)..where((t) => t.id.equals(exerciseId))).getSingleOrNull();
  }

  /// Watch all exercises (reactive stream)
  Stream<List<Exercise>> watchExercises() {
    return (select(exercises)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .watch();
  }

  /// Get all exercises
  Future<List<Exercise>> getAllExercises() {
    return (select(exercises)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .get();
  }

  /// Search exercises by name
  Future<List<Exercise>> searchExercises(String query) {
    final searchPattern = '%$query%';
    return (select(exercises)
          ..where((t) => t.name.like(searchPattern))
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .get();
  }

  /// Get exercises by category
  Future<List<Exercise>> getExercisesByCategory(String category) {
    return (select(exercises)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .get();
  }

  // ========== Exercise Videos ==========

  /// Insert an exercise video
  Future<int> insertExerciseVideo(ExerciseVideosCompanion video) {
    return into(exerciseVideos).insert(video);
  }

  /// Update an exercise video
  Future<bool> updateExerciseVideo(ExerciseVideosCompanion video) {
    return update(exerciseVideos).replace(video);
  }

  /// Delete an exercise video
  Future<int> deleteExerciseVideo(int videoId) {
    return (delete(exerciseVideos)..where((t) => t.id.equals(videoId))).go();
  }

  /// Get videos for an exercise
  Future<List<ExerciseVideo>> getVideosForExercise(String exerciseId) {
    return (select(exerciseVideos)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .get();
  }

  /// Watch videos for an exercise (reactive stream)
  Stream<List<ExerciseVideo>> watchVideosForExercise(String exerciseId) {
    return (select(exerciseVideos)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .watch();
  }

  // ========== Routine Exercises ==========

  /// Insert a routine exercise
  Future<int> insertRoutineExercise(RoutineExercisesCompanion routineExercise) {
    return into(routineExercises).insert(routineExercise);
  }

  /// Update a routine exercise
  Future<bool> updateRoutineExercise(RoutineExercisesCompanion routineExercise) {
    return update(routineExercises).replace(routineExercise);
  }

  /// Delete a routine exercise
  Future<int> deleteRoutineExercise(int routineExerciseId) {
    return (delete(routineExercises)..where((t) => t.id.equals(routineExerciseId))).go();
  }

  /// Get exercises for a routine
  Future<List<RoutineExercise>> getExercisesForRoutine(String routineId) {
    return (select(routineExercises)
          ..where((t) => t.routineId.equals(routineId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .get();
  }

  /// Watch exercises for a routine (reactive stream)
  Stream<List<RoutineExercise>> watchExercisesForRoutine(String routineId) {
    return (select(routineExercises)
          ..where((t) => t.routineId.equals(routineId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .watch();
  }

  /// Delete all exercises for a routine
  Future<int> deleteExercisesForRoutine(String routineId) {
    return (delete(routineExercises)..where((t) => t.routineId.equals(routineId))).go();
  }
}
