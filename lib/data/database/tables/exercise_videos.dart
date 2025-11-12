import 'package:drift/drift.dart';
import 'exercises.dart';

/// Exercise videos table - stores video URLs for exercises
/// 
/// Foreign key to Exercises with CASCADE delete
class ExerciseVideos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text().references(Exercises, #id, onDelete: KeyAction.cascade)();
  TextColumn get videoUrl => text()();
  TextColumn get thumbnailUrl => text().nullable()();
  IntColumn get order => integer()(); // Order if multiple videos
}
