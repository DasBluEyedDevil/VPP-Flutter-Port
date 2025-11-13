import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/routine_repository.dart';
import '../../domain/models/routine.dart' as domain;
import 'connection_log_provider.dart' show appDatabaseProvider;

/// Repository provider for routine operations
final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return RoutineRepository(database.workoutDao, database.exerciseDao);
});

/// Stream provider for routines
///
/// Ported from MainViewModel.kt routines (lines 127-135)
final routinesProvider = StreamProvider<List<domain.Routine>>((ref) {
  final repo = ref.watch(routineRepositoryProvider);
  return repo.getAllRoutines();
});

/// Actions provider for routine operations
final routineActionsProvider = Provider<RoutineActions>((ref) {
  final repo = ref.watch(routineRepositoryProvider);
  return RoutineActions(repo);
});

class RoutineActions {
  final RoutineRepository _repo;

  RoutineActions(this._repo);

  Future<void> saveRoutine(domain.Routine routine) async {
    final result = await _repo.saveRoutine(routine);
    result.fold(
      (error) => throw error,
      (_) => null,
    );
  }

  Future<void> updateRoutine(domain.Routine routine) async {
    final result = await _repo.updateRoutine(routine);
    result.fold(
      (error) => throw error,
      (_) => null,
    );
  }

  Future<void> deleteRoutine(String routineId) async {
    final result = await _repo.deleteRoutine(routineId);
    result.fold(
      (error) => throw error,
      (_) => null,
    );
  }

  Stream<domain.Routine?> watchRoutineById(String id) {
    return _repo.getRoutineById(id);
  }

  Future<void> markRoutineUsed(String routineId) async {
    final result = await _repo.markRoutineUsed(routineId);
    result.fold(
      (error) => throw error,
      (_) => null,
    );
  }
}

/// Provider for a specific routine by ID
final routineProvider = StreamProvider.family<domain.Routine?, String>((ref, routineId) {
  final actions = ref.watch(routineActionsProvider);
  return actions.watchRoutineById(routineId);
});
