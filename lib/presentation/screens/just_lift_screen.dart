import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/workout_state.dart';
import '../../domain/models/connection_state.dart' as domain;
import '../providers/workout_session_provider.dart';
import '../providers/workout_session_state.dart';
import '../providers/ble_connection_provider.dart';
import '../widgets/workout/cable_position_indicator.dart';
import '../widgets/workout/auto_start_stop_card.dart';

class JustLiftScreen extends ConsumerWidget {
  const JustLiftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final connectionStateAsync = ref.watch(connectionStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Just Lift'),
      ),
      body: connectionStateAsync.when(
        data: (connState) => _buildBody(context, ref, workoutState, connState),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState workoutState,
    domain.ConnectionState connectionState,
  ) {
    // Just Lift logic:
    // - Shows "Grab handles to start" when idle
    // - Auto-starts countdown when handles grabbed (auto-start timer)
    // - Shows active workout view during reps
    // - Auto-stops after 3s of no movement (auto-stop timer)
    // - Returns to idle instead of summary (Just Lift special behavior)

    if (connectionState is! domain.Connected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bluetooth_disabled, size: 80),
            const SizedBox(height: 16),
            const Text('Not connected to Vitruvian device'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final actions = ref.read(bleConnectionActionsProvider);
                actions.ensureConnection(
                  onConnected: () {},
                  onFailed: () {},
                );
              },
              child: const Text('Connect'),
            ),
          ],
        ),
      );
    }

    final state = workoutState.workoutState;
    return state.when(
      idle: () => _buildIdleView(context),
      initializing: () => const Center(child: CircularProgressIndicator()),
      countdown: (secondsRemaining) => _buildCountdownView(context, workoutState),
      active: () => _buildActiveView(context, workoutState),
      paused: () => const Center(child: Text('Paused')),
      resting: (_, __, ___, ____, _____) => const Center(child: Text('Unexpected state')),
      setSummary: (_, __, ___, ____) => _buildJustLiftSummary(context, ref, workoutState),
      completed: () => const Center(child: Text('Completed')),
      error: (message) => Center(child: Text('Error: $message')),
    );
  }

  Widget _buildIdleView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.back_hand_outlined,
            size: 120,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Grab the handles to start',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Workout will automatically begin when you pick up the handles',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownView(BuildContext context, WorkoutSessionState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutoStartStopCard(
          workoutState: state.workoutState,
          autoStartCountdown: state.autoStartCountdown,
          autoStopState: state.autoStopState,
        ),
      ),
    );
  }

  Widget _buildActiveView(BuildContext context, WorkoutSessionState state) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Cable position indicators
          if (state.currentMetric != null)
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 200,
                    child: CablePositionIndicator(
                      label: 'L',
                      currentPosition: state.currentMetric!.positionA,
                      isActive: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 80,
                    height: 200,
                    child: CablePositionIndicator(
                      label: 'R',
                      currentPosition: state.currentMetric!.positionB,
                      isActive: true,
                    ),
                  ),
                ],
              ),
            ),
          if (state.currentMetric != null) const SizedBox(height: 24),
          // Current metrics
          if (state.currentMetric != null) ...[
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _MetricRow(
                      'Load A',
                      '${state.currentMetric!.loadA.toStringAsFixed(1)} N',
                    ),
                    const Divider(height: 16),
                    _MetricRow(
                      'Load B',
                      '${state.currentMetric!.loadB.toStringAsFixed(1)} N',
                    ),
                    const Divider(height: 16),
                    _MetricRow(
                      'Total Load',
                      '${state.currentMetric!.totalLoad.toStringAsFixed(1)} N',
                    ),
                    const Divider(height: 16),
                    _MetricRow(
                      'Power',
                      '${state.currentMetric!.power.toStringAsFixed(0)} W',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],

          // Rep counter
          Text(
            'Reps',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '${state.repCount.totalReps}',
            style: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 32),

          // Auto-start/stop card
          AutoStartStopCard(
            workoutState: state.workoutState,
            autoStartCountdown: state.autoStartCountdown,
            autoStopState: state.autoStopState,
          ),
          const SizedBox(height: 32),

          Text(
            'Set will auto-complete when you stop moving',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildJustLiftSummary(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
    // Show set summary, then auto-return to idle after 3s
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          // Just Lift special: reset to idle (proceedFromSummary does this for Just Lift)
          ref.read(workoutSessionProvider.notifier).proceedFromSummary();
        }
      });
    });

    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Set Complete!',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _SummaryRow('Reps', '${state.repCount.totalReps}'),
                  const Divider(height: 16),
                  _SummaryRow(
                    'Total Metrics',
                    '${state.collectedMetrics.length} samples',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Returning to idle...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _MetricRow(String label, String value) {
    return Row(
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
    );
  }

  Widget _SummaryRow(String label, String value) {
    return Row(
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
    );
  }
}
