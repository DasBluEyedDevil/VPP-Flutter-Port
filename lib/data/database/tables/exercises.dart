import 'package:drift/drift.dart';

/// Exercise table - stores exercise library entries
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get muscleGroups => text().nullable()(); // Comma-separated list
  TextColumn get notes => text().nullable()();
  Int64Column get createdAt => int64()();
  Int64Column get lastUsed => int64()();

  @override
  Set<Column> get primaryKey => {id};
}
