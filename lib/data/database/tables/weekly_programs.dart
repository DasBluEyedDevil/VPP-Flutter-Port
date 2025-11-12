import 'package:drift/drift.dart';

/// Weekly programs table - stores weekly workout programs
class WeeklyPrograms extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  Int64Column get createdAt => int64()();
  Int64Column get lastUsed => int64()();

  @override
  Set<Column> get primaryKey => {id};
}
