import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/workout_repository.dart';
import '../../data/database/daos/workout_dao.dart';
import 'workout_session_provider.dart'; // Import to reuse workoutRepositoryProvider

/// Stream provider for weekly programs
///
/// Ported from MainViewModel.kt weeklyPrograms (lines 137-145)
final weeklyProgramsProvider = StreamProvider<List<WeeklyProgramWithDays>>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getAllPrograms();
});

/// Actions provider for weekly program operations
final weeklyProgramActionsProvider = Provider<WeeklyProgramActions>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return WeeklyProgramActions(repo);
});

class WeeklyProgramActions {
  final WorkoutRepository _repo;

  WeeklyProgramActions(this._repo);

  Future<void> saveWeeklyProgram(WeeklyProgramWithDays program) async {
    await _repo.saveProgram(program);
  }

  Future<void> deleteWeeklyProgram(String programId) async {
    await _repo.deleteProgram(programId);
  }

  Stream<WeeklyProgramWithDays?> getCurrentWeeklyProgram() {
    return _repo.getActiveProgram();
  }

  Stream<WeeklyProgramWithDays?> getProgramById(String programId) {
    return _repo.getProgramById(programId);
  }

  Future<void> activateProgram(String programId) async {
    await _repo.activateProgram(programId);
  }

  Future<void> deactivateAll() async {
    await _repo.deactivateAllPrograms();
  }
}

/// Provider for a specific program by ID
final programProvider = StreamProvider.family<WeeklyProgramWithDays?, String>((ref, programId) {
  final actions = ref.watch(weeklyProgramActionsProvider);
  return actions.getProgramById(programId);
});
