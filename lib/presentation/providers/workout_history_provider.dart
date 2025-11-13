import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/workout_repository.dart';
import '../../domain/models/workout_session.dart';
import 'workout_session_provider.dart'; // Import to reuse workoutRepositoryProvider

/// Stream provider for workout history
///
/// Ported from MainViewModel.kt workoutHistory (lines 340-345)
/// Loads only the 20 most recent sessions (not all workouts)
final workoutHistoryProvider = StreamProvider<List<WorkoutSession>>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getRecentSessions(limit: 20);
});

/// Actions provider for workout history operations
final workoutHistoryActionsProvider = Provider<WorkoutHistoryActions>((ref) {
  final repo = ref.watch(workoutRepositoryProvider);
  return WorkoutHistoryActions(repo);
});

class WorkoutHistoryActions {
  final WorkoutRepository _repo;

  WorkoutHistoryActions(this._repo);

  Future<void> deleteWorkoutSession(String sessionId) async {
    await _repo.deleteWorkout(sessionId);
  }

  Future<WorkoutSession?> getSessionById(String sessionId) async {
    return await _repo.getSession(sessionId);
  }

  Stream<List<WorkoutSession>> getRecentSessions({int limit = 10}) {
    return _repo.getRecentSessions(limit: limit);
  }
}
