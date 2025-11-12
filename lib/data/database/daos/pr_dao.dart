import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/personal_records.dart';

part 'pr_dao.g.dart';

@DriftAccessor(tables: [PersonalRecords])
class PrDao extends DatabaseAccessor<AppDatabase> with _$PrDaoMixin {
  final AppDatabase db;
  PrDao(this.db) : super(db);

  // ========== Personal Records ==========

  /// Insert or update a personal record
  /// 
  /// Uses unique constraint on (exerciseId, workoutMode) to handle upsert
  Future<int> upsertPersonalRecord(PersonalRecordsCompanion pr) async {
    // Try to find existing PR
    final existing = await (select(personalRecords)
          ..where((t) =>
              t.exerciseId.equals(pr.exerciseId.value) &
              t.workoutMode.equals(pr.workoutMode.value)))
        .getSingleOrNull();

    if (existing != null) {
      // Update if new PR is better (higher weight or same weight with more reps)
      final isBetter = pr.weightPerCableKg.value > existing.weightPerCableKg ||
          (pr.weightPerCableKg.value == existing.weightPerCableKg &&
              pr.reps.value > existing.reps);

      if (isBetter) {
        await update(personalRecords).replace(pr.copyWith(id: Value(existing.id)));
        return existing.id;
      }
      return existing.id;
    } else {
      // Insert new PR
      return into(personalRecords).insert(pr);
    }
  }

  /// Insert a personal record (will fail if unique constraint violated)
  Future<int> insertPersonalRecord(PersonalRecordsCompanion pr) {
    return into(personalRecords).insert(pr);
  }

  /// Update a personal record
  Future<bool> updatePersonalRecord(PersonalRecordsCompanion pr) {
    return update(personalRecords).replace(pr);
  }

  /// Delete a personal record
  Future<int> deletePersonalRecord(int prId) {
    return (delete(personalRecords)..where((t) => t.id.equals(prId))).go();
  }

  /// Get a personal record by ID
  Future<PersonalRecord?> getPersonalRecordById(int prId) {
    return (select(personalRecords)..where((t) => t.id.equals(prId))).getSingleOrNull();
  }

  /// Get personal record for an exercise and workout mode
  Future<PersonalRecord?> getPersonalRecord(String exerciseId, String workoutMode) {
    return (select(personalRecords)
          ..where((t) =>
              t.exerciseId.equals(exerciseId) & t.workoutMode.equals(workoutMode)))
        .getSingleOrNull();
  }

  /// Watch all personal records (reactive stream)
  Stream<List<PersonalRecord>> watchPersonalRecords() {
    return (select(personalRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch();
  }

  /// Get all personal records
  Future<List<PersonalRecord>> getAllPersonalRecords() {
    return (select(personalRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Get personal records for an exercise
  Future<List<PersonalRecord>> getPersonalRecordsForExercise(String exerciseId) {
    return (select(personalRecords)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Watch personal records for an exercise (reactive stream)
  Stream<List<PersonalRecord>> watchPersonalRecordsForExercise(String exerciseId) {
    return (select(personalRecords)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch();
  }

  /// Get recent personal records (limit)
  Future<List<PersonalRecord>> getRecentPersonalRecords({int limit = 10}) {
    return (select(personalRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .get();
  }

  /// Check if a workout would be a new PR
  Future<bool> isNewPersonalRecord(
    String exerciseId,
    String workoutMode,
    double weightPerCableKg,
    int reps,
  ) async {
    final existing = await getPersonalRecord(exerciseId, workoutMode);
    if (existing == null) return true;

    // New PR if higher weight or same weight with more reps
    return weightPerCableKg > existing.weightPerCableKg ||
        (weightPerCableKg == existing.weightPerCableKg && reps > existing.reps);
  }
}
