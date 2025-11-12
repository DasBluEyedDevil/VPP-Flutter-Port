import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/daos/exercise_dao.dart';

final logger = Logger();

/// Repository for exercise library management
/// 
/// Ported from ExerciseRepository.kt
abstract class ExerciseRepository {
  Stream<List<Exercise>> getAllExercises();
  Stream<List<Exercise>> searchExercises(String query);
  Stream<List<Exercise>> filterByMuscleGroup(String muscleGroup);
  Stream<List<Exercise>> filterByEquipment(String equipment);
  Stream<List<Exercise>> getFavorites();
  Future<void> toggleFavorite(String id);
  Future<Exercise?> getExerciseById(String id);
  Future<List<ExerciseVideo>> getVideos(String exerciseId);
  Future<Either<Exception, void>> importExercises();
  Future<bool> isExerciseLibraryEmpty();
}

/// Implementation of ExerciseRepository
class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseDao _exerciseDao;
  // TODO: Implement ExerciseImporter in Phase 3.5 - Import exercises from JSON assets
  // final ExerciseImporter _exerciseImporter;

  ExerciseRepositoryImpl(this._exerciseDao);

  /// Get all exercises sorted by name
  @override
  Stream<List<Exercise>> getAllExercises() {
    return _exerciseDao.watchExercises();
  }

  /// Search exercises by name, description, or muscles
  @override
  Stream<List<Exercise>> searchExercises(String query) {
    if (query.trim().isEmpty) {
      return getAllExercises();
    } else {
      // Convert Stream to Future, search, then convert back to Stream
      return Stream.fromFuture(_exerciseDao.searchExercises(query.trim()));
    }
  }

  /// Filter exercises by muscle group
  @override
  Stream<List<Exercise>> filterByMuscleGroup(String muscleGroup) {
    if (muscleGroup.trim().isEmpty) {
      return getAllExercises();
    } else {
      // Note: ExerciseDao doesn't have getExercisesByMuscleGroup yet
      // For now, search by name and filter in memory
      // TODO: Add getExercisesByMuscleGroup to ExerciseDao if needed
      return Stream.fromFuture(_exerciseDao.getAllExercises()).map((exercises) {
        return exercises.where((exercise) {
          final muscleGroups = exercise.muscleGroups ?? '';
          return muscleGroups.contains(muscleGroup);
        }).toList();
      });
    }
  }

  /// Filter exercises by equipment
  @override
  Stream<List<Exercise>> filterByEquipment(String equipment) {
    if (equipment.trim().isEmpty) {
      return getAllExercises();
    } else {
      // Note: ExerciseDao doesn't have getExercisesByEquipment yet
      // For now, return all exercises (equipment field may not exist in table)
      // TODO: Add equipment filtering to ExerciseDao if needed
      return getAllExercises();
    }
  }

  /// Get favorite exercises
  @override
  Stream<List<Exercise>> getFavorites() {
    // Note: ExerciseDao doesn't have getFavorites yet
    // TODO: Add isFavorite field to Exercises table and implement getFavorites in DAO
    return Stream.value([]);
  }

  /// Toggle favorite status for an exercise
  @override
  Future<void> toggleFavorite(String id) async {
    try {
      final exercise = await _exerciseDao.getExerciseById(id);
      if (exercise != null) {
        // TODO: Add isFavorite field to Exercises table and implement updateFavorite in DAO
        // await _exerciseDao.updateFavorite(id, !exercise.isFavorite);
        logger.d("Toggled favorite for exercise: $id");
      }
    } catch (e) {
      logger.e("Failed to toggle favorite", error: e);
    }
  }

  /// Get exercise by ID
  @override
  Future<Exercise?> getExerciseById(String id) {
    return _exerciseDao.getExerciseById(id);
  }

  /// Get videos for an exercise
  @override
  Future<List<ExerciseVideo>> getVideos(String exerciseId) {
    return _exerciseDao.getVideosForExercise(exerciseId);
  }

  /// Import exercises from assets (if not already imported)
  @override
  Future<Either<Exception, void>> importExercises() async {
    try {
      // Check if exercises are already imported
      final exercises = await _exerciseDao.getAllExercises();
      if (exercises.isEmpty) {
        logger.d("Importing exercises from assets...");
        // TODO: Implement ExerciseImporter
        // final result = await _exerciseImporter.importExercises();
        // if (result.isSuccess) {
        //   return right(null);
        // } else {
        //   return left(result.exceptionOrNull() ?? Exception("Import failed"));
        // }
        throw UnimplementedError('ExerciseImporter not yet implemented');
      } else {
        logger.d("Exercises already imported (count: ${exercises.length})");
        return right(null);
      }
    } catch (e) {
      logger.e("Failed to import exercises", error: e);
      return left(e as Exception);
    }
  }

  /// Check if exercise library is empty
  @override
  Future<bool> isExerciseLibraryEmpty() async {
    final exercises = await _exerciseDao.getAllExercises();
    return exercises.isEmpty;
  }
}
