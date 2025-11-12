import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/routine_provider.dart' show routineProvider, routineActionsProvider, RoutineActions;
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/exercise_repository.dart';
import '../providers/connection_log_provider.dart';

/// Provider for exercise repository
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  // TODO: This should be properly injected, for now create directly
  // In a real app, this would be provided via dependency injection
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepositoryImpl(db.exerciseDao);
});

/// Provider for all exercises
final exercisesProvider = StreamProvider<List<Exercise>>((ref) {
  final repo = ref.watch(exerciseRepositoryProvider);
  return repo.getAllExercises();
});

/// Daily Routines Screen - displays routine details and allows execution/editing
class DailyRoutinesScreen extends ConsumerWidget {
  final String routineId;

  const DailyRoutinesScreen({
    super.key,
    this.routineId = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (routineId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Routines'),
        ),
        body: const EmptyState(
          icon: Icons.fitness_center,
          title: 'No Routine Selected',
          message: 'Please select a routine to view its details.',
        ),
      );
    }

    final routineAsync = ref.watch(routineProvider(routineId));
    final routineActions = ref.watch(routineActionsProvider);
    final exercisesAsync = ref.watch(exercisesProvider);
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context, ref, routineId, routineActions, exercisesAsync),
            tooltip: 'Edit Routine',
          ),
        ],
      ),
      body: routineAsync.when(
        data: (routine) {
          if (routine == null) {
            return const EmptyState(
              icon: Icons.error_outline,
              title: 'Routine Not Found',
              message: 'The requested routine could not be found.',
            );
          }

          return StreamBuilder<List<RoutineExercise>>(
            stream: db.exerciseDao.watchExercisesForRoutine(routineId),
            builder: (context, snapshot) {
              final routineExercises = snapshot.data ?? [];
              
              if (routineExercises.isEmpty) {
                return const EmptyState(
                  icon: Icons.list,
                  title: 'No Exercises',
                  message: 'This routine has no exercises yet.',
                );
              }

              return Column(
                children: [
                  // Routine header
                  Card(
                    margin: const EdgeInsets.all(AppSpacing.small),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            routine.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.small),
                          Text(
                            '${routine.exerciseCount} exercise${routine.exerciseCount != 1 ? 's' : ''}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Exercises list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
                      itemCount: routineExercises.length,
                      itemBuilder: (context, index) {
                        final routineExercise = routineExercises[index];
                        return exercisesAsync.when(
                          data: (exercises) {
                            final exercise = exercises.firstWhere(
                              (e) => e.id == routineExercise.exerciseId,
                              orElse: () => Exercise(
                                id: routineExercise.exerciseId,
                                name: 'Unknown Exercise',
                                createdAt: BigInt.from(0),
                                lastUsed: BigInt.from(0),
                              ),
                            );
                            
                            return Card(
                              margin: const EdgeInsets.only(bottom: AppSpacing.small),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  exercise.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      '${routineExercise.sets} sets × ${routineExercise.reps} reps',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      '@ ${routineExercise.weightPerCableKg}kg per cable',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    // TODO: Add restSeconds field to database RoutineExercises table
                                    // For now using default 90s rest period
                                    Text(
                                      'Rest: 90s',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                          loading: () => const ListTile(
                            leading: CircularProgressIndicator(),
                            title: Text('Loading exercise...'),
                          ),
                          error: (error, stack) => ListTile(
                            leading: const Icon(Icons.error_outline, color: Colors.red),
                            title: Text('Error loading exercise: $error'),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Start button
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    child: FilledButton.icon(
                      onPressed: () => _startWorkout(context, routineId),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Workout'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: AppSpacing.medium),
              Text('Error loading routine: $error'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    String routineId,
    RoutineActions routineActions,
    AsyncValue<List<Exercise>> exercisesAsync,
  ) async {
    exercisesAsync.whenData((exercises) async {
      final routine = await routineActions.getRoutineById(routineId);
      if (routine == null || !context.mounted) return;

      // TODO: Convert database Routine to domain Routine
      // For now, show a message that editing needs domain model conversion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Routine editing requires domain model conversion - coming soon'),
        ),
      );
    });
  }

  void _startWorkout(BuildContext context, String routineId) {
    // Navigate to active workout with routine ID
    // TODO: Pass routine as parameter when ActiveWorkoutScreen supports it
    context.go(Routes.activeWorkout);
  }
}

