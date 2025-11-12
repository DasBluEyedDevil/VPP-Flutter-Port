import 'package:drift/drift.dart';

/// Workout metrics table - HIGH PERFORMANCE!
/// 
/// This table receives 100Hz inserts (6000 records/minute during workouts).
/// Must use efficient batch inserts in DAO.
class WorkoutMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()(); // Foreign key to WorkoutSessions.id
  Int64Column get timestamp => int64()();
  RealColumn get loadA => real()();
  RealColumn get loadB => real()();
  IntColumn get positionA => integer()();
  IntColumn get positionB => integer()();
  IntColumn get ticks => integer()();
  RealColumn get velocityA => real()();
  RealColumn get velocityB => real()();
  RealColumn get power => real()();

  Set<Index> get customIndexes => {
    Index('idx_workout_metrics_session_id', 'CREATE INDEX idx_workout_metrics_session_id ON workout_metrics (session_id)'),
    Index('idx_workout_metrics_timestamp', 'CREATE INDEX idx_workout_metrics_timestamp ON workout_metrics (timestamp)'),
  };
}
