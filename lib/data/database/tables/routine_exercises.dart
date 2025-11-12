import 'package:drift/drift.dart';
import 'routines.dart';

/// Routine exercises table - links exercises to routines
/// 
/// Foreign key to Routines with CASCADE delete
class RoutineExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routineId => text().references(Routines, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseId => text()();
  IntColumn get order => integer()(); // Order within routine
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();
  RealColumn get weightPerCableKg => real()();
  TextColumn get mode => text()(); // ProgramMode as string
  IntColumn get eccentricLoad => integer().nullable()(); // For Echo mode
  IntColumn get echoLevel => integer().nullable()(); // For Echo mode

  Set<Index> get customIndexes => {
    Index('idx_routine_exercises_routine_id', 'CREATE INDEX idx_routine_exercises_routine_id ON routine_exercises (routine_id)'),
  };
}
