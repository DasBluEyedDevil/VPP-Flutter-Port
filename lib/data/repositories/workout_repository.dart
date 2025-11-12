import 'dart:async';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/daos/workout_dao.dart';
import '../database/daos/pr_dao.dart';
import '../../domain/models/workout_session.dart' as domain;
import '../../domain/models/workout_metric.dart' as domain;
import '../../domain/models/personal_record.dart' as domain;

final logger = Logger();

/// Repository for workout history management
/// 
/// Ported from WorkoutRepository.kt
class WorkoutRepository {
  final WorkoutDao _workoutDao;
  final PrDao _prDao;

  WorkoutRepository(this._workoutDao, this._prDao);

  // ========== Workout Sessions ==========

  /// Save a workout session
  Future<Either<Exception, void>> saveSession(domain.WorkoutSession session) async {
    try {
      final entity = session.toEntity();
      await _workoutDao.insertSession(entity);
      logger.d("Saved workout session: ${session.id}");
      return right(null);
    } catch (e) {
      logger.e("Failed to save workout session", error: e);
      return left(e as Exception);
    }
  }

  /// Save workout metrics (batch insert for performance)
  Future<Either<Exception, void>> saveMetrics(String sessionId, List<domain.WorkoutMetric> metrics) async {
    try {
      final entities = metrics.map((metric) => metric.toEntity(sessionId)).toList();
      await _workoutDao.insertMetricsBatch(entities);
      logger.d("Saved ${entities.length} metrics for session $sessionId");
      return right(null);
    } catch (e) {
      logger.e("Failed to save workout metrics", error: e);
      return left(e as Exception);
    }
  }

  /// Get all workout sessions
  Stream<List<domain.WorkoutSession>> getAllSessions() {
    // Convert Future to Stream by watching recent sessions with high limit
    // TODO: Add watchAllSessions() to WorkoutDao if needed for better performance
    return _workoutDao.watchRecentSessions(limit: 1000).map((entities) {
      return entities.map((entity) => entity.toWorkoutSession()).toList();
    });
  }

  /// Get recent workout sessions
  Stream<List<domain.WorkoutSession>> getRecentSessions({int limit = 10}) {
    return _workoutDao.watchRecentSessions(limit: limit).map((entities) {
      return entities.map((entity) => entity.toWorkoutSession()).toList();
    });
  }

  /// Get a specific workout session
  Future<domain.WorkoutSession?> getSession(String sessionId) async {
    final entity = await _workoutDao.getSessionById(sessionId);
    return entity?.toWorkoutSession();
  }

  /// Get metrics for a workout session
  Stream<List<domain.WorkoutMetric>> getMetricsForSession(String sessionId) {
    return _workoutDao.watchMetricsForSession(sessionId).map((entities) {
      return entities.map((entity) => entity.toWorkoutMetric()).toList();
    });
  }

  /// Delete a workout
  Future<Either<Exception, void>> deleteWorkout(String sessionId) async {
    try {
      await _workoutDao.deleteSession(sessionId);
      logger.d("Deleted workout: $sessionId");
      return right(null);
    } catch (e) {
      logger.e("Failed to delete workout", error: e);
      return left(e as Exception);
    }
  }

  /// Delete all workouts
  Future<Either<Exception, void>> deleteAllWorkouts() async {
    try {
      // TODO: Add deleteAllWorkouts() to WorkoutDao
      // For now, get all sessions and delete them one by one
      final sessions = await _workoutDao.getAllSessions();
      for (final session in sessions) {
        await _workoutDao.deleteSession(session.id);
      }
      logger.d("Deleted all workouts");
      return right(null);
    } catch (e) {
      logger.e("Failed to delete all workouts", error: e);
      return left(e as Exception);
    }
  }

  // ========== Routine Operations ==========

  /// Save a routine with exercises
  /// 
  /// TODO: Implement when Routine and RoutineExercise domain models are ported
  Future<Either<Exception, void>> saveRoutine(/* Routine routine */) async {
    // TODO: Implement when domain models are available
    throw UnimplementedError('Routine domain model not yet ported');
  }

  /// Update a routine
  /// 
  /// TODO: Implement when Routine and RoutineExercise domain models are ported
  Future<Either<Exception, void>> updateRoutine(/* Routine routine */) async {
    // TODO: Implement when domain models are available
    throw UnimplementedError('Routine domain model not yet ported');
  }

  /// Get all routines
  Stream<List<Routine>> getAllRoutines() {
    return _workoutDao.watchRoutines();
  }

  /// Get a specific routine
  Future<Routine?> getRoutine(String routineId) async {
    return await _workoutDao.getRoutineById(routineId);
  }

  /// Delete a routine
  Future<Either<Exception, void>> deleteRoutine(String routineId) async {
    try {
      await _workoutDao.deleteRoutine(routineId);
      logger.d("Deleted routine: $routineId");
      return right(null);
    } catch (e) {
      logger.e("Failed to delete routine", error: e);
      return left(e as Exception);
    }
  }

  /// Mark routine as used (updates lastUsed and increments useCount)
  /// 
  /// TODO: Add useCount field to Routines table and implement markRoutineUsed in DAO
  Future<Either<Exception, void>> markRoutineUsed(String routineId) async {
    try {
      final routine = await _workoutDao.getRoutineById(routineId);
      if (routine != null) {
        // TODO: Update lastUsed timestamp and increment useCount
        // await _workoutDao.markRoutineUsed(routineId);
        logger.d("Marked routine used: $routineId");
        return right(null);
      } else {
        return left(Exception("Routine not found: $routineId"));
      }
    } catch (e) {
      logger.e("Failed to mark routine used", error: e);
      return left(e as Exception);
    }
  }

  /// Get routine by ID as a Stream
  Stream<Routine?> getRoutineById(String routineId) {
    // TODO: Add observeRoutineById() to WorkoutDao
    // For now, convert Future to Stream
    return Stream.fromFuture(_workoutDao.getRoutineById(routineId));
  }

  // ========== Weekly Programs ==========

  /// Get all weekly programs with their assigned days
  Stream<List<WeeklyProgramWithDays>> getAllPrograms() {
    return _workoutDao.watchWeeklyProgramsWithDays();
  }

  /// Get the currently active program with its days
  Stream<WeeklyProgramWithDays?> getActiveProgram() {
    return _workoutDao.watchActiveProgramWithDays();
  }

  /// Get a specific program by ID with its days
  Stream<WeeklyProgramWithDays?> getProgramById(String programId) {
    // TODO: Add getProgramWithDaysById() to WorkoutDao
    // For now, get all programs and filter
    return getAllPrograms().map((programs) {
      return programs.where((p) => p.program.id == programId).firstOrNull;
    });
  }

  /// Save a new weekly program or update existing one
  Future<Either<Exception, void>> saveProgram(WeeklyProgramWithDays programWithDays) async {
    try {
      // Check if program exists
      final existing = await _workoutDao.getWeeklyProgramById(programWithDays.program.id);
      
      if (existing != null) {
        // Update existing program
        await _workoutDao.updateWeeklyProgram(
          WeeklyProgramsCompanion(
            id: Value(programWithDays.program.id),
            name: Value(programWithDays.program.name),
            createdAt: Value(programWithDays.program.createdAt),
            lastUsed: Value(programWithDays.program.lastUsed),
            isActive: Value(programWithDays.program.isActive),
          ),
        );
        
        // Delete old days
        final oldDays = await _workoutDao.getProgramDaysForProgram(programWithDays.program.id);
        for (final day in oldDays) {
          await _workoutDao.deleteProgramDay(day.id);
        }
      } else {
        // Insert new program
        await _workoutDao.insertWeeklyProgram(
          WeeklyProgramsCompanion.insert(
            id: programWithDays.program.id,
            name: programWithDays.program.name,
            createdAt: programWithDays.program.createdAt,
            lastUsed: programWithDays.program.lastUsed,
            isActive: programWithDays.program.isActive,
          ),
        );
      }

      // Insert/update days
      for (final day in programWithDays.days) {
        await _workoutDao.insertProgramDay(
          ProgramDaysCompanion.insert(
            programId: day.programId,
            routineId: day.routineId,
            dayOfWeek: day.dayOfWeek,
          ),
        );
      }

      logger.d("Saved weekly program: ${programWithDays.program.name}");
      return right(null);
    } catch (e) {
      logger.e("Failed to save weekly program", error: e);
      return left(e as Exception);
    }
  }

  /// Delete a weekly program
  Future<Either<Exception, void>> deleteProgram(String programId) async {
    try {
      await _workoutDao.deleteWeeklyProgram(programId);
      logger.d("Deleted weekly program: $programId");
      return right(null);
    } catch (e) {
      logger.e("Failed to delete weekly program", error: e);
      return left(e as Exception);
    }
  }

  /// Activate a weekly program (deactivates all others)
  Future<Either<Exception, void>> activateProgram(String programId) async {
    try {
      await _workoutDao.deactivateAllPrograms();
      await _workoutDao.activateProgram(programId);
      logger.d("Activated weekly program: $programId");
      return right(null);
    } catch (e) {
      logger.e("Failed to activate weekly program", error: e);
      return left(e as Exception);
    }
  }

  /// Deactivate all weekly programs
  Future<Either<Exception, void>> deactivateAllPrograms() async {
    try {
      await _workoutDao.deactivateAllPrograms();
      logger.d("Deactivated all weekly programs");
      return right(null);
    } catch (e) {
      logger.e("Failed to deactivate all weekly programs", error: e);
      return left(e as Exception);
    }
  }

  // ========== Personal Records ==========

  /// Get all personal records
  Stream<List<domain.PersonalRecord>> getAllPersonalRecords() {
    // TODO: Import PersonalRecordRepository and use it instead
    // For now, return empty stream
    return Stream.value([]);
  }

  /// Update personal record if the new performance is better
  Future<bool> updatePersonalRecordIfNeeded(
    String exerciseId,
    double weightPerCableKg,
    int reps,
    String workoutMode,
  ) async {
    try {
      final isNewPR = await _prDao.isNewPersonalRecord(
        exerciseId,
        workoutMode,
        weightPerCableKg,
        reps,
      );

      if (isNewPR) {
        final companion = PersonalRecordsCompanion.insert(
          exerciseId: exerciseId,
          weightPerCableKg: weightPerCableKg,
          reps: reps,
          workoutMode: workoutMode,
          timestamp: BigInt.from(DateTime.now().millisecondsSinceEpoch),
        );
        await _prDao.upsertPersonalRecord(companion);
        logger.d("New PR set for exercise $exerciseId: ${weightPerCableKg}kg x $reps reps ($workoutMode)");
        return true;
      }
      return false;
    } catch (e) {
      logger.e("Failed to update personal record", error: e);
      return false;
    }
  }
}

// Extension functions for mapping between entities and domain models
extension WorkoutSessionEntityExt on WorkoutSession {
  domain.WorkoutSession toWorkoutSession() {
    return domain.WorkoutSession(
      id: id,
      timestamp: timestamp.toInt(),
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

extension WorkoutSessionDomainExt on domain.WorkoutSession {
  WorkoutSessionsCompanion toEntity() {
    return WorkoutSessionsCompanion.insert(
      id: id,
      timestamp: BigInt.from(timestamp),
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
      exerciseId: Value(exerciseId),
    );
  }
}

extension WorkoutMetricEntityExt on WorkoutMetric {
  domain.WorkoutMetric toWorkoutMetric() {
    return domain.WorkoutMetric(
      timestamp: timestamp.toInt(),
      loadA: loadA,
      loadB: loadB,
      positionA: positionA,
      positionB: positionB,
      ticks: ticks,
      velocityA: velocityA,
      velocityB: velocityB,
      power: power,
    );
  }
}

extension WorkoutMetricDomainExt on domain.WorkoutMetric {
  WorkoutMetricsCompanion toEntity(String sessionId) {
    return WorkoutMetricsCompanion.insert(
      sessionId: sessionId,
      timestamp: BigInt.from(timestamp),
      loadA: loadA,
      loadB: loadB,
      positionA: positionA,
      positionB: positionB,
      ticks: ticks,
      velocityA: velocityA,
      velocityB: velocityB,
      power: power,
    );
  }
}
