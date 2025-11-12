import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/workout_state.dart';
import '../providers/workout_session_provider.dart';
import '../providers/ble_connection_provider.dart';
import '../widgets/workout/countdown_card.dart';
import '../widgets/workout/rest_timer_card.dart';
import '../widgets/workout/set_summary_card.dart';
import '../widgets/cards/stats_card.dart';
import '../widgets/dialogs/connection_lost_dialog.dart';
import '../navigation/routes.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final bleState = ref.watch(bleConnectionProvider);

    // Show connection lost dialog if disconnected during workout
    if (workoutState.connectionLost && bleState is! BleConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showConnectionLostDialog(context, ref);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: workoutState.state == WorkoutState.active
                ? () => ref.read(workoutSessionProvider.notifier).pauseWorkout()
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () => _confirmEndWorkout(context, ref),
          ),
        ],
      ),
      body: _buildWorkoutBody(context, ref, workoutState),
    );
  }

  Widget _buildWorkoutBody(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
  ) {
    return switch (state.state) {
      WorkoutState.countdownToStart => CountdownCard(
          secondsRemaining: state.autoStartSecondsRemaining ?? 5,
        ),
      WorkoutState.active => _buildActiveWorkoutView(context, ref, state),
      WorkoutState.paused => _buildPausedView(context, ref, state),
      WorkoutState.rest => RestTimerCard(
          secondsRemaining: state.restSecondsRemaining ?? 0,
          totalSeconds: 60, // TODO: get from preferences
          onSkip: () => ref.read(workoutSessionProvider.notifier).skipRest(),
        ),
      WorkoutState.completed ||
      WorkoutState.summary =>
        _buildSummaryView(context, ref, state),
      _ => const Center(child: Text('Unknown state')),
    };
  }

  Widget _buildActiveWorkoutView(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current metrics display
          Text('Current Set', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          _MetricsDisplay(metrics: state.currentMetrics),

          const SizedBox(height: 24),

          // Rep counter
          Center(
            child: Text(
              'Reps: ${state.repCount ?? 0}',
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Completed sets
          Text('Completed Sets', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Expanded(
            child: state.completedSets.isEmpty
                ? Center(
                    child: Text(
                      'No sets completed yet',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.completedSets.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SetSummaryCard(
                        setNumber: i + 1,
                        reps: state.completedSets[i].reps,
                        concentric: state.completedSets[i].concentricAvg,
                        eccentric: state.completedSets[i].eccentricAvg,
                        power: state.completedSets[i].powerPeak,
                        duration: state.completedSets[i].duration,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPausedView(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pause_circle_outline,
            size: 120,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Workout Paused',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () =>
                ref.read(workoutSessionProvider.notifier).resumeWorkout(),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Resume'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryView(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.check_circle,
              size: 100,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Workout Complete!',
              style: theme.textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: 32),
          StatsCard(
            title: 'Total Sets',
            value: '${state.completedSets.length}',
          ),
          const SizedBox(height: 12),
          StatsCard(
            title: 'Total Reps',
            value: '${_totalReps(state.completedSets)}',
          ),
          const SizedBox(height: 12),
          StatsCard(
            title: 'Duration',
            value: _formatDuration(state.workoutDuration ?? 0),
          ),
          const SizedBox(height: 12),
          StatsCard(
            title: 'Total Volume',
            value:
                '${_totalVolume(state.completedSets).toStringAsFixed(0)} kg',
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(workoutSessionProvider.notifier).completeWorkout();
                context.go(Routes.home);
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  void _showConnectionLostDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConnectionLostDialog(
        onReconnect: () {
          Navigator.pop(context);
          ref.read(bleConnectionProvider.notifier).connect();
        },
        onEndWorkout: () {
          Navigator.pop(context);
          ref.read(workoutSessionProvider.notifier).endWorkout();
          context.go(Routes.home);
        },
      ),
    );
  }

  Future<void> _confirmEndWorkout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('End Workout?'),
        content: const Text(
          'Are you sure you want to end this workout? Progress will be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('End Workout'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      ref.read(workoutSessionProvider.notifier).endWorkout();
      context.go(Routes.home);
    }
  }

  int _totalReps(List<dynamic> sets) =>
      sets.fold(0, (sum, set) => sum + (set.reps as int));

  double _totalVolume(List<dynamic> sets) => sets.fold(
        0.0,
        (sum, set) =>
            sum + ((set.concentricAvg as double) * (set.reps as int)),
      );

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}m ${secs}s';
  }
}

class _MetricsDisplay extends StatelessWidget {
  final dynamic metrics; // WorkoutMetric from domain

  const _MetricsDisplay({this.metrics});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (metrics == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Waiting for data...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _MetricRow(
              'Concentric',
              '${metrics.concentricLoad.toStringAsFixed(1)} kg',
            ),
            const Divider(height: 16),
            _MetricRow(
              'Eccentric',
              '${metrics.eccentricLoad.toStringAsFixed(1)} kg',
            ),
            const Divider(height: 16),
            _MetricRow(
              'Power',
              '${metrics.power.toStringAsFixed(0)} W',
            ),
            const Divider(height: 16),
            _MetricRow(
              'Velocity',
              '${metrics.velocity.toStringAsFixed(2)} m/s',
            ),
          ],
        ),
      ),
    );
  }

  Widget _MetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
