import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/workout_sessions.dart';
import 'tables/workout_metrics.dart';
import 'tables/routines.dart';
import 'tables/routine_exercises.dart';
import 'tables/exercises.dart';
import 'tables/exercise_videos.dart';
import 'tables/personal_records.dart';
import 'tables/weekly_programs.dart';
import 'tables/program_days.dart';
import 'tables/connection_logs.dart';

import 'daos/workout_dao.dart';
import 'daos/exercise_dao.dart';
import 'daos/pr_dao.dart';
import 'daos/connection_log_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WorkoutSessions,
    WorkoutMetrics,
    Routines,
    RoutineExercises,
    Exercises,
    ExerciseVideos,
    PersonalRecords,
    WeeklyPrograms,
    ProgramDays,
    ConnectionLogs,
  ],
  daos: [
    WorkoutDao,
    ExerciseDao,
    PrDao,
    ConnectionLogDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 15; // Match Kotlin database version

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'vitruvian_workout.db'));
      return NativeDatabase(file);
    });
  }
}
