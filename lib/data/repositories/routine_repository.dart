import 'dart:async';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/daos/workout_dao.dart';
import '../database/daos/exercise_dao.dart';
import '../../domain/models/routine.dart' as domain;
import '../../domain/models/routine_exercise.dart' as domain;
import '../../domain/models/program_mode.dart';
import '../../domain/models/eccentric_load.dart';
import '../../domain/models/echo_level.dart';

final logger = Logger();

/// Repository for routine management
/// 
/// Bridges database entities and domain models
class RoutineRepository {
  final WorkoutDao _workoutDao;
  final ExerciseDao _exerciseDao;

  RoutineRepository(this._workoutDao, this._exerciseDao);

  /// Get all routines as domain models
  Stream<List<domain.Routine>> getAllRoutines() {
    return _workoutDao.watchRoutines().asyncMap((dbRoutines) async {
      final routines = <domain.Routine>[];
      for (final dbRoutine in dbRoutines) {
        final dbExercises = await _exerciseDao.getExercisesForRoutine(dbRoutine.id);
        routines.add(_mapRoutineToDomain(dbRoutine, dbExercises));
      }
      return routines;
    });
  }

  /// Get a specific routine by ID
  Stream<domain.Routine?> getRoutineById(String id) {
    return _exerciseDao.watchExercisesForRoutine(id).asyncMap((dbExercises) async {
      final dbRoutine = await _workoutDao.getRoutineById(id);
      if (dbRoutine == null) return null;
      return _mapRoutineToDomain(dbRoutine, dbExercises);
    });
  }

  /// Save a new routine
  Future<Either<Exception, void>> saveRoutine(domain.Routine routine) async {
    try {
      // Insert routine
      final routineCompanion = RoutinesCompanion.insert(
        id: routine.id,
        name: routine.name,
        createdAt: BigInt.from(routine.createdAt),
        lastUsed: BigInt.from(routine.lastUsed),
        exerciseCount: routine.exerciseCount,
      );
      await _workoutDao.insertRoutine(routineCompanion);

      // Insert exercises
      for (final exercise in routine.exercises) {
        final exerciseCompanion = RoutineExercisesCompanion.insert(
          routineId: routine.id,
          exerciseId: exercise.exerciseId,
          order: exercise.order,
          sets: exercise.sets,
          reps: exercise.reps,
          weightPerCableKg: exercise.weightPerCableKg,
          mode: _serializeProgramMode(exercise.mode),
          eccentricLoad: Value(exercise.eccentricLoad?.index),
          echoLevel: Value(exercise.echoLevel?.index),
        );
        await _exerciseDao.insertRoutineExercise(exerciseCompanion);
      }

      logger.d("Saved routine: ${routine.id}");
      return right(null);
    } catch (e) {
      logger.e("Failed to save routine", error: e);
      return left(e as Exception);
    }
  }

  /// Update an existing routine
  Future<Either<Exception, void>> updateRoutine(domain.Routine routine) async {
    try {
      // Update routine
      final routineCompanion = RoutinesCompanion(
        id: Value(routine.id),
        name: Value(routine.name),
        createdAt: Value(BigInt.from(routine.createdAt)),
        lastUsed: Value(BigInt.from(routine.lastUsed)),
        exerciseCount: Value(routine.exerciseCount),
      );
      await _workoutDao.updateRoutine(routineCompanion);

      // Delete old exercises and insert new ones
      await _exerciseDao.deleteExercisesForRoutine(routine.id);
      for (final exercise in routine.exercises) {
        final exerciseCompanion = RoutineExercisesCompanion.insert(
          routineId: routine.id,
          exerciseId: exercise.exerciseId,
          order: exercise.order,
          sets: exercise.sets,
          reps: exercise.reps,
          weightPerCableKg: exercise.weightPerCableKg,
          mode: _serializeProgramMode(exercise.mode),
          eccentricLoad: Value(exercise.eccentricLoad?.index),
          echoLevel: Value(exercise.echoLevel?.index),
        );
        await _exerciseDao.insertRoutineExercise(exerciseCompanion);
      }

      logger.d("Updated routine: ${routine.id}");
      return right(null);
    } catch (e) {
      logger.e("Failed to update routine", error: e);
      return left(e as Exception);
    }
  }

  /// Delete a routine (CASCADE deletes exercises)
  Future<Either<Exception, void>> deleteRoutine(String id) async {
    try {
      await _workoutDao.deleteRoutine(id);
      logger.d("Deleted routine: $id");
      return right(null);
    } catch (e) {
      logger.e("Failed to delete routine", error: e);
      return left(e as Exception);
    }
  }

  /// Mark routine as used (updates lastUsed timestamp)
  Future<Either<Exception, void>> markRoutineUsed(String id) async {
    try {
      final dbRoutine = await _workoutDao.getRoutineById(id);
      if (dbRoutine == null) {
        return left(Exception("Routine not found: $id"));
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final routineCompanion = RoutinesCompanion(
        id: Value(id),
        name: Value(dbRoutine.name),
        createdAt: Value(dbRoutine.createdAt),
        lastUsed: Value(BigInt.from(now)),
        exerciseCount: Value(dbRoutine.exerciseCount),
      );
      await _workoutDao.updateRoutine(routineCompanion);

      logger.d("Marked routine used: $id");
      return right(null);
    } catch (e) {
      logger.e("Failed to mark routine used", error: e);
      return left(e as Exception);
    }
  }

  // ========== Helper Methods ==========

  /// Map database Routine to domain Routine
  domain.Routine _mapRoutineToDomain(
    Routine dbRoutine,
    List<RoutineExercise> dbExercises,
  ) {
    return domain.Routine(
      id: dbRoutine.id,
      name: dbRoutine.name,
      description: '', // Phase 2: Description field not in database yet
      createdAt: dbRoutine.createdAt.toInt(),
      lastUsed: dbRoutine.lastUsed.toInt(),
      exerciseCount: dbRoutine.exerciseCount,
      exercises: dbExercises.map(_mapRoutineExerciseToDomain).toList(),
    );
  }

  /// Map database RoutineExercise to domain RoutineExercise
  domain.RoutineExercise _mapRoutineExerciseToDomain(RoutineExercise dbExercise) {
    return domain.RoutineExercise(
      exerciseId: dbExercise.exerciseId,
      order: dbExercise.order,
      sets: dbExercise.sets,
      reps: dbExercise.reps,
      weightPerCableKg: dbExercise.weightPerCableKg,
      mode: _parseProgramMode(dbExercise.mode),
      eccentricLoad: dbExercise.eccentricLoad != null
          ? EccentricLoad.values[dbExercise.eccentricLoad!]
          : null,
      echoLevel: dbExercise.echoLevel != null
          ? EchoLevel.values[dbExercise.echoLevel!]
          : null,
      restSeconds: 90, // Default, column doesn't exist yet
    );
  }

  // ========== String Conversion Helpers ==========

  /// Convert ProgramMode to string for database storage (using displayName)
  String _serializeProgramMode(ProgramMode mode) {
    return mode.displayName;
  }

  /// Convert string to ProgramMode from database
  ProgramMode _parseProgramMode(String mode) {
    return switch (mode) {
      'oldSchool' => const ProgramMode.oldSchool(),
      'pump' => const ProgramMode.pump(),
      'tut' => const ProgramMode.tut(),
      'tutBeast' => const ProgramMode.tutBeast(),
      'eccentricOnly' => const ProgramMode.eccentricOnly(),
      _ => const ProgramMode.oldSchool(), // Default fallback
    };
  }
}
