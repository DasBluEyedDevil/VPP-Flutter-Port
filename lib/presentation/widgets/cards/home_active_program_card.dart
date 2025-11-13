import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/weight_unit.dart';
import '../../../domain/models/routine.dart';
import '../../../domain/models/routine_exercise.dart';
import '../../../data/database/daos/workout_dao.dart';
import '../../navigation/routes.dart';

/// Active program card widget matching Kotlin HomeActiveProgramCard
/// 
/// Displays today's scheduled routine from the active weekly program.
/// Shows exercise list with format: "{Name} | {Reps} | {Weight} | {Mode}"
/// Includes Start Routine button or Rest day display.
class HomeActiveProgramCard extends ConsumerWidget {
  final WeeklyProgramWithDays program;
  final List<Routine> routines;
  final WeightUnit weightUnit;

  const HomeActiveProgramCard({
    super.key,
    required this.program,
    required this.routines,
    required this.weightUnit,
  });

  /// Get today's day of week (0=Sunday, 1=Monday, ..., 6=Saturday)
  int _getTodayDayOfWeek() {
    final now = DateTime.now();
    return now.weekday % 7; // Convert to 0-6 (Sunday=0)
  }

  /// Get today's routine ID from program days
  String? _getTodayRoutineId() {
    final todayDay = _getTodayDayOfWeek();
    final todayDayEntry = program.days.firstWhere(
      (day) => day.dayOfWeek == todayDay,
      orElse: () => throw StateError('No routine for today'),
    );
    return todayDayEntry.routineId;
  }

  /// Check if there's a workout today
  bool _hasWorkoutToday() {
    try {
      _getTodayRoutineId();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get today's routine
  Routine? _getTodayRoutine() {
    try {
      final routineId = _getTodayRoutineId();
      return routines.firstWhere(
        (r) => r.id == routineId,
        orElse: () => throw StateError('Routine not found'),
      );
    } catch (_) {
      return null;
    }
  }

  /// Format weight for display
  String _formatWeight(double kg, WeightUnit unit) {
    final displayValue = unit == WeightUnit.lb ? kg * 2.20462 : kg;
    final unitSuffix = unit == WeightUnit.kg ? 'kg' : 'lbs';
    return '${displayValue.toStringAsFixed(1)} $unitSuffix';
  }

  /// Format exercise display string
  String _formatExercise(RoutineExercise exercise, String exerciseName) {
    // Format reps: "10, 10, 12" for multiple sets
    final repsList = List.generate(
      exercise.sets,
      (index) => exercise.reps.toString(),
    );
    final repsStr = repsList.join(', ');

    // Format weight: single value or range
    final weightStr = _formatWeight(exercise.weightPerCableKg, weightUnit);

    // Format mode
    final modeStr = exercise.mode.displayName;

    return '$exerciseName | $repsStr | $weightStr | $modeStr';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasWorkoutToday = _hasWorkoutToday();
    final todayRoutine = _getTodayRoutine();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFF5F3FF), // purple-50
          width: 1,
        ),
      ),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!hasWorkoutToday)
              // Rest day display
              Text(
                'Rest day',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else if (todayRoutine != null)
              // Exercise list
              ...todayRoutine.exercises.map((exercise) {
                // TODO: Fetch exercise name from exercise repository
                // For now, use exercise ID as placeholder
                final exerciseName = 'Exercise ${exercise.exerciseId}';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    _formatExercise(exercise, exerciseName),
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }),
            if (hasWorkoutToday && todayRoutine != null) ...[
              const SizedBox(height: 16),
              // Start Routine button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final routineId = _getTodayRoutineId();
                    if (routineId != null) {
                      // TODO: Implement ensureConnection and startWorkout logic
                      // For now, just navigate to daily routines
                      context.go(Routes.dailyRoutines);
                    }
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Routine'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
