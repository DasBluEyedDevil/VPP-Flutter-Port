import 'package:drift/drift.dart';

/// Personal records table - tracks PRs for exercises
/// 
/// Unique constraint on (exerciseId, workoutMode)
class PersonalRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text()();
  RealColumn get weightPerCableKg => real()();
  IntColumn get reps => integer()();
  Int64Column get timestamp => int64()();
  TextColumn get workoutMode => text()(); // WorkoutMode as string

  @override
  List<Set<Column>> get uniqueKeys => [
    {exerciseId, workoutMode},
  ];
}
