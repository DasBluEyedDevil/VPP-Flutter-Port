import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/workout_history_provider.dart';
import '../providers/personal_record_provider.dart';
import '../widgets/cards/stats_card.dart';
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../domain/models/workout_session.dart';
import 'package:intl/intl.dart';

/// Workout tab screen with quick action cards and recent workouts.
class WorkoutTab extends ConsumerWidget {
  const WorkoutTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final workoutsAsync = ref.watch(workoutHistoryProvider);
    final prsAsync = ref.watch(personalRecordsProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: [
        // Quick Start Section
        Text(
          'Quick Start',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.medium,
          mainAxisSpacing: AppSpacing.medium,
          childAspectRatio: 1.2,
          children: [
            _QuickActionCard(
              icon: Icons.trending_up,
              title: 'Just Lift',
              subtitle: 'Auto-start workout',
              color: theme.colorScheme.primary,
              onTap: () => context.go(Routes.justLift),
            ),
            _QuickActionCard(
              icon: Icons.fitness_center,
              title: 'Single Exercise',
              subtitle: 'One exercise workout',
              color: theme.colorScheme.secondary,
              onTap: () => context.go(Routes.singleExercise),
            ),
            _QuickActionCard(
              icon: Icons.list,
              title: 'Routine',
              subtitle: 'Start a routine',
              color: theme.colorScheme.tertiary,
              onTap: () => context.go(Routes.dailyRoutines),
            ),
            _QuickActionCard(
              icon: Icons.calendar_today,
              title: 'Program',
              subtitle: 'Weekly program',
              color: theme.colorScheme.primaryContainer,
              onTap: () => context.go(Routes.weeklyPrograms),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.large),

        // Stats Section
        Text(
          'Stats',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        workoutsAsync.when(
          data: (workouts) {
            final totalWorkouts = workouts.length;
            final totalVolume = _calculateTotalVolume(workouts);
            final prCount = prsAsync.maybeWhen(
              data: (prs) => prs.length,
              orElse: () => 0,
            );

            return Row(
              children: [
                Expanded(
                  child: StatsCard(
                    label: 'Total Workouts',
                    value: '$totalWorkouts',
                    icon: Icons.fitness_center,
                    iconColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: StatsCard(
                    label: 'Total Volume',
                    value: '${totalVolume.toStringAsFixed(0)} kg',
                    icon: Icons.scale,
                    iconColor: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: StatsCard(
                    label: 'Personal Records',
                    value: '$prCount',
                    icon: Icons.emoji_events,
                    iconColor: Colors.amber,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error loading stats: $error'),
        ),

        const SizedBox(height: AppSpacing.large),

        // Recent Workouts Section
        Text(
          'Recent Workouts',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        workoutsAsync.when(
          data: (workouts) {
            final recentWorkouts = workouts.take(3).toList();
            if (recentWorkouts.isEmpty) {
              return const EmptyState(
                icon: Icons.history,
                title: 'No Recent Workouts',
                message: 'Complete your first workout to see it here!',
              );
            }

            return Column(
              children: recentWorkouts.map((workout) => _WorkoutCard(workout: workout)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error loading workouts: $error'),
        ),
      ],
    );
  }

  double _calculateTotalVolume(List<WorkoutSession> workouts) {
    return workouts.fold(0.0, (sum, workout) {
      return sum + (workout.weightPerCableKg * workout.totalReps * 2); // 2 cables
    });
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: AppSpacing.small),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.extraSmall),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final WorkoutSession workout;

  const _WorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = DateTime.fromMillisecondsSinceEpoch(workout.timestamp);
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.fitness_center,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          workout.mode,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}'),
            const SizedBox(height: AppSpacing.extraSmall),
            Text('${workout.totalReps} reps • ${workout.weightPerCableKg.toStringAsFixed(1)} kg'),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to workout detail screen
        },
      ),
    );
  }
}
