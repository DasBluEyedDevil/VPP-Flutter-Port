import 'package:drift/drift.dart';

/// Workout session table - stores workout session metadata
class WorkoutSessions extends Table {
  TextColumn get id => text()();
  Int64Column get timestamp => int64()();
  TextColumn get mode => text()(); // ProgramMode as string (OldSchool, Pump, TUT, etc.)
  IntColumn get reps => integer()();
  RealColumn get weightPerCableKg => real()();
  RealColumn get progressionKg => real()();
  IntColumn get duration => integer()(); // Duration in milliseconds
  IntColumn get totalReps => integer()();
  IntColumn get warmupReps => integer()();
  IntColumn get workingReps => integer()();
  BoolColumn get isJustLift => boolean()();
  BoolColumn get stopAtTop => boolean()();
  // Echo mode configuration
  IntColumn get eccentricLoad => integer()(); // Percentage (0, 50, 75, 100, 125, 150)
  IntColumn get echoLevel => integer()(); // 1=Hard, 2=Harder, 3=Hardest, 4=Epic
  // Exercise tracking
  TextColumn get exerciseId => text().nullable()(); // Exercise library ID for PR tracking

  @override
  Set<Column> get primaryKey => {id};
}
