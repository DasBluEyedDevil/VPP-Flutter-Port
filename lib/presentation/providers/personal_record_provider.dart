import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/personal_record_repository.dart';
import '../../domain/models/personal_record.dart';

/// Provider for PersonalRecordRepository instance
final personalRecordRepositoryProvider = Provider<PersonalRecordRepository>((ref) {
  throw UnimplementedError('personalRecordRepositoryProvider must be overridden');
});

/// Stream provider for personal records
///
/// Ported from MainViewModel.kt personalRecords (lines 112-116)
/// Uses getAllPRsGrouped() to get all PRs (grouping logic done in UI layer)
final personalRecordsProvider = StreamProvider<List<PersonalRecord>>((ref) {
  final repo = ref.watch(personalRecordRepositoryProvider);
  return repo.getAllPRsGrouped();
});

/// Actions provider for personal record operations
final personalRecordActionsProvider = Provider<PersonalRecordActions>((ref) {
  final repo = ref.watch(personalRecordRepositoryProvider);
  return PersonalRecordActions(repo);
});

class PersonalRecordActions {
  final PersonalRecordRepository _repo;

  PersonalRecordActions(this._repo);

  Future<PersonalRecord?> getPRForExercise(String exerciseId, String workoutMode) async {
    return await _repo.getLatestPR(exerciseId, workoutMode);
  }

  Stream<List<PersonalRecord>> getPRsForExercise(String exerciseId) {
    return _repo.getPRsForExercise(exerciseId);
  }

  Future<PersonalRecord?> getBestPR(String exerciseId) async {
    return await _repo.getBestPR(exerciseId);
  }
}
