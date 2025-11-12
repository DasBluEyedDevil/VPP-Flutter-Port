import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/workout_sessions.dart';
import '../tables/workout_metrics.dart';
import '../tables/routines.dart';
import '../tables/weekly_programs.dart';
import '../tables/program_days.dart';

part 'workout_dao.g.dart';

/// Embedded relation pattern - Weekly program with its days
class WeeklyProgramWithDays {
  final WeeklyProgram program;
  final List<ProgramDay> days;

  WeeklyProgramWithDays({
    required this.program,
    required this.days,
  });
}

@DriftAccessor(tables: [
  WorkoutSessions,
  WorkoutMetrics,
  Routines,
  WeeklyPrograms,
  ProgramDays,
])
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  final AppDatabase db;
  WorkoutDao(this.db) : super(db);

  // ========== Workout Sessions ==========

  /// Insert a new workout session and return its ID
  Future<String> insertSession(WorkoutSessionsCompanion session) async {
    await into(workoutSessions).insert(session);
    return session.id.value;
  }

  /// Update an existing workout session
  Future<bool> updateSession(WorkoutSessionsCompanion session) {
    return update(workoutSessions).replace(session);
  }

  /// Delete a workout session
  Future<int> deleteSession(String sessionId) {
    return (delete(workoutSessions)..where((t) => t.id.equals(sessionId))).go();
  }

  /// Get a single workout session by ID
  Future<WorkoutSession?> getSessionById(String sessionId) {
    return (select(workoutSessions)..where((t) => t.id.equals(sessionId))).getSingleOrNull();
  }

  /// Watch recent workout sessions (reactive stream)
  Stream<List<WorkoutSession>> watchRecentSessions({int limit = 20}) {
    return (select(workoutSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .watch();
  }

  /// Get all workout sessions
  Future<List<WorkoutSession>> getAllSessions() {
    return (select(workoutSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Get workout sessions for a date range
  Future<List<WorkoutSession>> getSessionsInRange(int startTimestamp, int endTimestamp) {
    return (select(workoutSessions)
          ..where((t) => t.timestamp.isBetweenValues(BigInt.from(startTimestamp), BigInt.from(endTimestamp)))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  // ========== Workout Metrics (HIGH PERFORMANCE - 100Hz inserts) ==========

  /// Batch insert metrics (CRITICAL for 100Hz performance)
  /// 
  /// Uses batch() API for efficient bulk inserts
  Future<void> insertMetricsBatch(List<WorkoutMetricsCompanion> metrics) {
    return batch((batch) {
      batch.insertAll(workoutMetrics, metrics);
    });
  }

  /// Insert a single metric (use batch insert for multiple)
  Future<int> insertMetric(WorkoutMetricsCompanion metric) {
    return into(workoutMetrics).insert(metric);
  }

  /// Get all metrics for a session
  Future<List<WorkoutMetric>> getMetricsForSession(String sessionId) {
    return (select(workoutMetrics)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  /// Watch metrics for a session (reactive stream)
  Stream<List<WorkoutMetric>> watchMetricsForSession(String sessionId) {
    return (select(workoutMetrics)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .watch();
  }

  /// Delete all metrics for a session
  Future<int> deleteMetricsForSession(String sessionId) {
    return (delete(workoutMetrics)..where((t) => t.sessionId.equals(sessionId))).go();
  }

  /// Get metrics in a time range for a session
  Future<List<WorkoutMetric>> getMetricsInRange(
    String sessionId,
    int startTimestamp,
    int endTimestamp,
  ) {
    return (select(workoutMetrics)
          ..where((t) =>
              t.sessionId.equals(sessionId) &
              t.timestamp.isBetweenValues(BigInt.from(startTimestamp), BigInt.from(endTimestamp)))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  // ========== Routines ==========

  /// Insert a new routine
  Future<String> insertRoutine(RoutinesCompanion routine) async {
    await into(routines).insert(routine);
    return routine.id.value;
  }

  /// Update a routine
  Future<bool> updateRoutine(RoutinesCompanion routine) {
    return update(routines).replace(routine);
  }

  /// Delete a routine (CASCADE will delete RoutineExercises)
  Future<int> deleteRoutine(String routineId) {
    return (delete(routines)..where((t) => t.id.equals(routineId))).go();
  }

  /// Get a routine by ID
  Future<Routine?> getRoutineById(String routineId) {
    return (select(routines)..where((t) => t.id.equals(routineId))).getSingleOrNull();
  }

  /// Watch all routines (reactive stream)
  Stream<List<Routine>> watchRoutines() {
    return (select(routines)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .watch();
  }

  /// Get all routines
  Future<List<Routine>> getAllRoutines() {
    return (select(routines)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .get();
  }

  // ========== Weekly Programs ==========

  /// Insert a new weekly program
  Future<String> insertWeeklyProgram(WeeklyProgramsCompanion program) async {
    await into(weeklyPrograms).insert(program);
    return program.id.value;
  }

  /// Update a weekly program
  Future<bool> updateWeeklyProgram(WeeklyProgramsCompanion program) {
    return update(weeklyPrograms).replace(program);
  }

  /// Delete a weekly program (CASCADE will delete ProgramDays)
  Future<int> deleteWeeklyProgram(String programId) {
    return (delete(weeklyPrograms)..where((t) => t.id.equals(programId))).go();
  }

  /// Get a weekly program by ID
  Future<WeeklyProgram?> getWeeklyProgramById(String programId) {
    return (select(weeklyPrograms)..where((t) => t.id.equals(programId))).getSingleOrNull();
  }

  /// Watch all weekly programs (reactive stream)
  Stream<List<WeeklyProgram>> watchWeeklyPrograms() {
    return (select(weeklyPrograms)
          ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]))
        .watch();
  }

  /// Get weekly program with days (embedded relation pattern)
  Future<List<WeeklyProgramWithDays>> getWeeklyProgramsWithDays() async {
    final query = select(weeklyPrograms)
      ..orderBy([(t) => OrderingTerm.desc(t.lastUsed)]);

    final programs = await query.get();
    final allProgramDays = await (select(programDays)).get();

    return programs.map((program) {
      final days = allProgramDays
          .where((day) => day.programId == program.id)
          .toList();
      return WeeklyProgramWithDays(program: program, days: days);
    }).toList();
  }

  // ========== Program Days ==========

  /// Insert a program day
  Future<int> insertProgramDay(ProgramDaysCompanion day) {
    return into(programDays).insert(day);
  }

  /// Update a program day
  Future<bool> updateProgramDay(ProgramDaysCompanion day) {
    return update(programDays).replace(day);
  }

  /// Delete a program day
  Future<int> deleteProgramDay(int dayId) {
    return (delete(programDays)..where((t) => t.id.equals(dayId))).go();
  }

  /// Get program days for a program
  Future<List<ProgramDay>> getProgramDaysForProgram(String programId) {
    return (select(programDays)
          ..where((t) => t.programId.equals(programId))
          ..orderBy([(t) => OrderingTerm.asc(t.dayOfWeek)]))
        .get();
  }

  /// Watch program days for a program (reactive stream)
  Stream<List<ProgramDay>> watchProgramDaysForProgram(String programId) {
    return (select(programDays)
          ..where((t) => t.programId.equals(programId))
          ..orderBy([(t) => OrderingTerm.asc(t.dayOfWeek)]))
        .watch();
  }
}
