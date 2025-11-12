import 'package:drift/drift.dart';
import 'weekly_programs.dart';
import 'routines.dart';

/// Program days table - links routines to days of the week in programs
/// 
/// Foreign keys to WeeklyPrograms and Routines with CASCADE delete
class ProgramDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get programId => text().references(WeeklyPrograms, #id, onDelete: KeyAction.cascade)();
  TextColumn get routineId => text().references(Routines, #id, onDelete: KeyAction.cascade)();
  IntColumn get dayOfWeek => integer()(); // 0=Sunday, 1=Monday, ..., 6=Saturday

  Set<Index> get customIndexes => {
    Index('idx_program_days_program_id', 'CREATE INDEX idx_program_days_program_id ON program_days (program_id)'),
    Index('idx_program_days_routine_id', 'CREATE INDEX idx_program_days_routine_id ON program_days (routine_id)'),
  };
}
