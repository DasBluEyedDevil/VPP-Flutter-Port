import 'dart:async';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/daos/pr_dao.dart';
import '../../domain/models/personal_record.dart' as domain;

final logger = Logger();

/// Repository for managing personal records (PRs)
/// 
/// Ported from PersonalRecordRepository.kt
class PersonalRecordRepository {
  final PrDao _prDao;

  PersonalRecordRepository(this._prDao);

  /// Get the latest PR for an exercise in a specific workout mode
  Future<domain.PersonalRecord?> getLatestPR(String exerciseId, String workoutMode) async {
    try {
      final entity = await _prDao.getPersonalRecord(exerciseId, workoutMode);
      return entity?.toPersonalRecord();
    } catch (e) {
      logger.e("Failed to get PR for exercise $exerciseId", error: e);
      return null;
    }
  }

  /// Get all PRs for an exercise across all workout modes
  Stream<List<domain.PersonalRecord>> getPRsForExercise(String exerciseId) {
    return _prDao.watchPersonalRecordsForExercise(exerciseId).map((entities) {
      return entities.map((entity) => entity.toPersonalRecord()).toList();
    });
  }

  /// Get the best PR for an exercise across all modes
  Future<domain.PersonalRecord?> getBestPR(String exerciseId) async {
    try {
      final prs = await _prDao.getPersonalRecordsForExercise(exerciseId);
      if (prs.isEmpty) return null;

      // Find the best PR (highest weight, or same weight with more reps)
      domain.PersonalRecord? bestPR;
      for (final pr in prs) {
        final current = pr.toPersonalRecord();
        if (bestPR == null) {
          bestPR = current;
        } else {
          if (current.weightPerCableKg > bestPR.weightPerCableKg ||
              (current.weightPerCableKg == bestPR.weightPerCableKg &&
                  current.reps > bestPR.reps)) {
            bestPR = current;
          }
        }
      }
      return bestPR;
    } catch (e) {
      logger.e("Failed to get best PR for exercise $exerciseId", error: e);
      return null;
    }
  }

  /// Get all personal records
  Stream<List<domain.PersonalRecord>> getAllPRs() {
    return _prDao.watchPersonalRecords().map((entities) {
      return entities.map((entity) => entity.toPersonalRecord()).toList();
    });
  }

  /// Get all personal records grouped by exercise (for analytics)
  /// 
  /// Note: This returns all PRs, grouped logic should be done in UI layer
  Stream<List<domain.PersonalRecord>> getAllPRsGrouped() {
    return getAllPRs(); // Same as getAllPRs for now
  }

  /// Update PR if the new performance is better
  /// Returns Either.right(true) if a new PR was set, Either.right(false) otherwise
  Future<Either<Exception, bool>> updatePRIfBetter(
    String exerciseId,
    double weightPerCableKg,
    int reps,
    String workoutMode,
    int timestamp,
  ) async {
    try {
      final isNewPR = await _prDao.isNewPersonalRecord(
        exerciseId,
        workoutMode,
        weightPerCableKg,
        reps,
      );

      if (isNewPR) {
        final companion = PersonalRecordsCompanion.insert(
          exerciseId: exerciseId,
          weightPerCableKg: weightPerCableKg,
          reps: reps,
          workoutMode: workoutMode,
          timestamp: BigInt.from(timestamp),
        );
        await _prDao.upsertPersonalRecord(companion);
        logger.d("New PR set for exercise $exerciseId: ${weightPerCableKg}kg x $reps reps ($workoutMode)");
        return right(true);
      } else {
        return right(false);
      }
    } catch (e) {
      logger.e("Failed to update PR for exercise $exerciseId", error: e);
      return left(e as Exception);
    }
  }
}

// Extension functions for mapping between entities and domain models
extension PersonalRecordTableExt on PersonalRecord {
  domain.PersonalRecord toPersonalRecord() {
    return domain.PersonalRecord(
      id: id,
      exerciseId: exerciseId,
      weightPerCableKg: weightPerCableKg,
      reps: reps,
      timestamp: timestamp.toInt(),
      workoutMode: workoutMode,
    );
  }
}

extension PersonalRecordDomainExt on domain.PersonalRecord {
  PersonalRecordsCompanion toEntity() {
    return PersonalRecordsCompanion.insert(
      id: Value(id),
      exerciseId: exerciseId,
      weightPerCableKg: weightPerCableKg,
      reps: reps,
      timestamp: BigInt.from(timestamp),
      workoutMode: workoutMode,
    );
  }
}
