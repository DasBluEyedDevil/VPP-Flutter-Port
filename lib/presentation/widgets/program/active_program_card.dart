import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/daos/workout_dao.dart';

/// Active program card widget - shows the currently active program with today's workout
/// 
/// Matches Kotlin ActiveProgramCard exactly with:
/// - primaryContainer background
/// - "Active Program" label
/// - Program name (titleLarge, Bold)
/// - Today's day name
/// - "Start Today's Workout" button (if routine assigned) OR "Rest day"
/// - 16dp padding, 16dp radius
class ActiveProgramCard extends ConsumerWidget {
  final WeeklyProgramWithDays program;
  final VoidCallback onStartWorkout;

  const ActiveProgramCard({
    super.key,
    required this.program,
    required this.onStartWorkout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final today = DateTime.now().weekday; // 1=Monday, 7=Sunday
    final todayRoutine = program.days.where((d) => d.dayOfWeek == today).firstOrNull;

    final hasWorkoutToday = todayRoutine != null && todayRoutine.routineId.isNotEmpty && todayRoutine.routineId != '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Card(
        elevation: 4,
        color: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFF5F3FF), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Program Label
              Text(
                'Active Program',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // Program Name
              Text(
                program.program.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 12),

              // Today's Workout Info
              Text(
                'Today: ${_getDayName(today)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 8),

              if (hasWorkoutToday) ...[
                Text(
                  'Workout scheduled',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onStartWorkout,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Today\'s Workout'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  'Rest day',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[dayOfWeek];
  }
}
