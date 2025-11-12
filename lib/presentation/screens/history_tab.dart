import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_history_provider.dart';
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../domain/models/workout_session.dart';
import 'package:intl/intl.dart';

/// History tab screen displaying workout history list.
class HistoryTab extends ConsumerWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutHistoryProvider);

    return workoutsAsync.when(
      data: (workouts) {
        if (workouts.isEmpty) {
          return const EmptyState(
            icon: Icons.history,
            title: 'No Workout History',
            message: 'Complete your first workout to see it here!',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.small),
          itemCount: workouts.length,
          itemBuilder: (context, index) => _WorkoutHistoryCard(workout: workouts[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: AppSpacing.medium),
            Text('Error loading workout history: $error'),
          ],
        ),
      ),
    );
  }
}

class _WorkoutHistoryCard extends StatelessWidget {
  final WorkoutSession workout;

  const _WorkoutHistoryCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = DateTime.fromMillisecondsSinceEpoch(workout.timestamp);
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    
    // Calculate duration in minutes
    final durationMinutes = workout.duration ~/ 60;
    final durationSeconds = workout.duration % 60;
    final durationText = durationMinutes > 0 
        ? '${durationMinutes}m ${durationSeconds}s'
        : '${durationSeconds}s';

    // Calculate volume (weight × reps × 2 cables)
    final volume = workout.weightPerCableKg * workout.totalReps * 2;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to workout detail screen
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.mode,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.extraSmall),
                        Text(
                          '${dateFormat.format(dateTime)} • ${timeFormat.format(dateTime)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (workout.isJustLift)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Just Lift',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.medium),
              Row(
                children: [
                  _MetricChip(
                    icon: Icons.repeat,
                    label: '${workout.totalReps} reps',
                    theme: theme,
                  ),
                  const SizedBox(width: AppSpacing.small),
                  _MetricChip(
                    icon: Icons.scale,
                    label: '${volume.toStringAsFixed(0)} kg',
                    theme: theme,
                  ),
                  const SizedBox(width: AppSpacing.small),
                  _MetricChip(
                    icon: Icons.timer,
                    label: durationText,
                    theme: theme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;

  const _MetricChip({
    required this.icon,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
