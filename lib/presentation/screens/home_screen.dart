import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../navigation/routes.dart';
import '../providers/workout_history_provider.dart';
import '../providers/personal_record_provider.dart';
import '../providers/weekly_program_provider.dart';
import '../widgets/cards/stats_card.dart';
import '../theme/spacing.dart';
import '../../domain/models/workout_session.dart';
import '../../data/database/daos/workout_dao.dart';

/// Home dashboard screen with welcome, stats, today's program, and quick actions.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final workoutsAsync = ref.watch(workoutHistoryProvider);
    final prsAsync = ref.watch(personalRecordsProvider);
    final programsAsync = ref.watch(weeklyProgramsProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: [
        // Welcome Section
        Text(
          'Welcome back!',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.extraSmall),
        Text(
          DateFormat.yMMMd().format(DateTime.now()),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: AppSpacing.large),

        // Quick Stats Cards
        workoutsAsync.when(
          data: (workouts) {
            final monthWorkouts = _getMonthWorkouts(workouts);
            final monthVolume = _getMonthVolume(workouts);
            final prCount = prsAsync.maybeWhen(
              data: (prs) => prs.length,
              orElse: () => 0,
            );

            return Row(
              children: [
                Expanded(
                  child: StatsCard(
                    label: 'Workouts',
                    value: '$monthWorkouts',
                    icon: Icons.fitness_center,
                    iconColor: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: StatsCard(
                    label: 'Volume',
                    value: '${monthVolume.toStringAsFixed(0)} kg',
                    icon: Icons.scale,
                    iconColor: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: StatsCard(
                    label: 'PRs',
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

        // Today's Program
        Text(
          "Today's Program",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        programsAsync.when(
          data: (programs) {
            final todayProgram = _getTodayProgram(programs);
            if (todayProgram == null) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 48,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: AppSpacing.small),
                      Text(
                        'No program today',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.calendar_today,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text(todayProgram.program.name),
                subtitle: Text(_getTodayRoutineName(todayProgram)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(Routes.weeklyPrograms),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const SizedBox.shrink(),
        ),

        const SizedBox(height: AppSpacing.large),

        // Recent Activity
        Text(
          'Recent Activity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        workoutsAsync.when(
          data: (workouts) {
            final recent = workouts.take(3).toList();
            if (recent.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Text(
                    'No recent workouts',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: recent.map((workout) => _RecentWorkoutCard(workout: workout)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const SizedBox.shrink(),
        ),

        const SizedBox(height: AppSpacing.medium),

        // View All Link
        TextButton(
          onPressed: () => context.go(Routes.homeHistory),
          child: const Text('View All History'),
        ),

        const SizedBox(height: AppSpacing.large),

        // Quick Actions
        Text(
          'Quick Actions',
          style: theme.textTheme.titleLarge?.copyWith(
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
              color: theme.colorScheme.primary,
              onTap: () => context.go(Routes.justLift),
            ),
            _QuickActionCard(
              icon: Icons.fitness_center,
              title: 'Single Exercise',
              color: theme.colorScheme.secondary,
              onTap: () => context.go(Routes.singleExercise),
            ),
            _QuickActionCard(
              icon: Icons.list,
              title: 'Browse Routines',
              color: theme.colorScheme.tertiary,
              onTap: () => context.go(Routes.homeRoutines),
            ),
            _QuickActionCard(
              icon: Icons.calendar_today,
              title: 'Weekly Programs',
              color: theme.colorScheme.primaryContainer,
              onTap: () => context.go(Routes.weeklyPrograms),
            ),
          ],
        ),
      ],
    );
  }

  int _getMonthWorkouts(List<WorkoutSession> workouts) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return workouts.where((w) {
      final date = DateTime.fromMillisecondsSinceEpoch(w.timestamp);
      return date.isAfter(monthStart) || date.isAtSameMomentAs(monthStart);
    }).length;
  }

  double _getMonthVolume(List<WorkoutSession> workouts) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return workouts.where((w) {
      final date = DateTime.fromMillisecondsSinceEpoch(w.timestamp);
      return date.isAfter(monthStart) || date.isAtSameMomentAs(monthStart);
    }).fold(0.0, (sum, w) {
      return sum + (w.weightPerCableKg * w.totalReps * 2); // 2 cables
    });
  }

  WeeklyProgramWithDays? _getTodayProgram(List<WeeklyProgramWithDays> programs) {
    // TODO: Find active program and get today's routine
    // For now, return first program if any
    if (programs.isEmpty) return null;
    return programs.first;
  }

  String _getTodayRoutineName(WeeklyProgramWithDays program) {
    // TODO: Get today's day of week and find matching ProgramDay
    // For now, return first day's routine name or 'Rest day'
    if (program.days.isEmpty) return 'Rest day';
    // TODO: Match with actual routine when ProgramDay has routineId
    return '${program.days.length} day${program.days.length != 1 ? 's' : ''}';
  }
}

class _RecentWorkoutCard extends StatelessWidget {
  final WorkoutSession workout;

  const _RecentWorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = DateTime.fromMillisecondsSinceEpoch(workout.timestamp);
    final dateFormat = DateFormat('MMM d');

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
        title: Text(workout.mode),
        subtitle: Text('${dateFormat.format(dateTime)} • ${workout.totalReps} reps'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to workout detail
        },
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
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
            ],
          ),
        ),
      ),
    );
  }
}

