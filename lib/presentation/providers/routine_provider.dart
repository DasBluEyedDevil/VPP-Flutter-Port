import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/workout_repository.dart';
import '../../data/database/app_database.dart'; // Use database Routine type
import 'workout_session_provider.dart'; // Import to reuse workoutRepositoryProvider

/// Stream provider for routines
///
/// Ported from MainViewModel.kt routines (lines 127-135)
final routinesProvider = StreamProvider<List<Routine>>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getAllRoutines();
});

/// Actions provider for routine operations
final routineActionsProvider = Provider<RoutineActions>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return RoutineActions(repo);
});

class RoutineActions {
  final WorkoutRepository _repo;

  RoutineActions(this._repo);

  Future<void> saveRoutine(Routine routine) async {
    // TODO: Implement when Routine domain model persistence is complete
    // await _repo.saveRoutine(routine);
    throw UnimplementedError('saveRoutine not yet implemented');
  }

  Future<void> deleteRoutine(String routineId) async {
    await _repo.deleteRoutine(routineId);
  }

  Future<Routine?> getRoutineById(String id) async {
    return await _repo.getRoutine(id);
  }

  Stream<Routine?> watchRoutineById(String id) {
    return _repo.getRoutineById(id);
  }

  Future<void> markRoutineUsed(String routineId) async {
    await _repo.markRoutineUsed(routineId);
  }
}

/// Provider for a specific routine by ID
final routineProvider = StreamProvider.family<Routine?, String>((ref, routineId) {
  final actions = ref.watch(routineActionsProvider);
  return actions.watchRoutineById(routineId);
});
