import 'package:drift/drift.dart';

/// Routine table - stores workout routines
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  Int64Column get createdAt => int64()();
  Int64Column get lastUsed => int64()();
  IntColumn get exerciseCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
