import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/workout_state.dart';
import '../../domain/models/connection_state.dart';
import '../../domain/models/weight_unit.dart';
import '../providers/workout_session_provider.dart';
import '../providers/workout_session_state.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/preferences_provider.dart';
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
    final connectionStateAsync = ref.watch(connectionStateProvider);

    // Show connection lost dialog if disconnected during workout
    connectionStateAsync.whenData((connState) {
      if (workoutState.connectionLostDuringWorkout && connState is! Connected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showConnectionLostDialog(context, ref);
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
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
    final workoutState = state.workoutState;
    return workoutState.when(
      idle: () => const Center(child: Text('Idle')),
      initializing: () => const Center(child: CircularProgressIndicator()),
      countdown: (secondsRemaining) => CountdownCard(
        secondsRemaining: secondsRemaining,
      ),
      active: () => _buildActiveWorkoutView(context, ref, state),
      paused: () => const Center(child: Text('Paused')),
      resting: (restSecondsRemaining, nextExerciseName, isLastExercise, currentSet, totalSets) => RestTimerCard(
        secondsRemaining: restSecondsRemaining,
        totalSeconds: 90, // TODO: get from exercise settings
        nextExerciseName: nextExerciseName,
        isLastExercise: isLastExercise,
        currentSet: currentSet,
        totalSets: totalSets,
        onSkip: () => ref.read(workoutSessionProvider.notifier).skipRest(),
      ),
      setSummary: (metrics, peakPower, averagePower, repCount) => _buildSummaryView(context, ref, state, metrics, peakPower, averagePower, repCount),
      completed: () => _buildCompletedView(context, ref),
      error: (message) => Center(child: Text('Error: $message')),
    );
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
          _MetricsDisplay(metrics: state.currentMetric),

          const SizedBox(height: 24),

          // Rep counter
          Center(
            child: Text(
              'Reps: ${state.repCount.totalReps}',
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Current exercise info
          if (state.loadedRoutine != null) ...[
            Text('Current Exercise', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              state.loadedRoutine!.exercises[state.currentExerciseIndex].exerciseId,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              'Set ${state.currentSetIndex + 1} of ${state.loadedRoutine!.exercises[state.currentExerciseIndex].sets}',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryView(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
    List<dynamic> metrics,
    double peakPower,
    double averagePower,
    int repCount,
  ) {
    final prefsAsync = ref.watch(userPreferencesProvider);

    return prefsAsync.when(
      data: (prefs) => SetSummaryCard(
        metrics: state.collectedMetrics,
        peakPower: peakPower,
        averagePower: averagePower,
        repCount: repCount,
        weightUnit: prefs.weightUnit,
        formatWeight: (weight, unit) => '${weight.toStringAsFixed(1)} ${unit == WeightUnit.kg ? 'kg' : 'lbs'}',
        onContinue: () {
          ref.read(workoutSessionProvider.notifier).proceedFromSummary();
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildCompletedView(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 100,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Workout Complete!',
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 32),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
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
          final actions = ref.read(bleConnectionActionsProvider);
          actions.ensureConnection(
            onConnected: () {},
            onFailed: () {},
          );
        },
        onEndWorkout: () {
          Navigator.pop(context);
          ref.read(workoutSessionProvider.notifier).stopWorkout();
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
      ref.read(workoutSessionProvider.notifier).stopWorkout();
      context.go(Routes.home);
    }
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
