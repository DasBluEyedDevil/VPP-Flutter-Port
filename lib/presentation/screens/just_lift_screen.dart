import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/workout_state.dart';
import '../providers/workout_session_provider.dart';
import '../providers/ble_connection_provider.dart';

class JustLiftScreen extends ConsumerWidget {
  const JustLiftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final bleState = ref.watch(bleConnectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Just Lift'),
        subtitle: const Text('Auto-start when you grab the handles'),
      ),
      body: _buildBody(context, ref, workoutState, bleState),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState workoutState,
    BleConnectionState bleState,
  ) {
    // Just Lift logic:
    // - Shows "Grab handles to start" when idle
    // - Auto-starts countdown when handles grabbed (auto-start timer)
    // - Shows active workout view during reps
    // - Auto-stops after 3s of no movement (auto-stop timer)
    // - Returns to idle instead of summary (Just Lift special behavior)

    if (bleState is! BleConnected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bluetooth_disabled, size: 80),
            const SizedBox(height: 16),
            const Text('Not connected to Vitruvian device'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(bleConnectionProvider.notifier).connect(),
              child: const Text('Connect'),
            ),
          ],
        ),
      );
    }

    return switch (workoutState.state) {
      WorkoutState.idle => _buildIdleView(context),
      WorkoutState.countdownToStart => _buildCountdownView(context, workoutState),
      WorkoutState.active => _buildActiveView(context, workoutState),
      WorkoutState.autoStop => _buildAutoStopView(context, workoutState),
      WorkoutState.justLiftSummary => _buildJustLiftSummary(context, ref, workoutState),
      _ => const Center(child: Text('Unexpected state')),
    };
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Get Ready!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Text(
            '${state.autoStartSecondsRemaining ?? 5}',
            style: TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
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
          // Current metrics
          if (state.currentMetrics != null) ...[
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _MetricRow(
                      'Concentric',
                      '${state.currentMetrics!.concentricLoad.toStringAsFixed(1)} kg',
                    ),
                    const Divider(height: 16),
                    _MetricRow(
                      'Eccentric',
                      '${state.currentMetrics!.eccentricLoad.toStringAsFixed(1)} kg',
                    ),
                    const Divider(height: 16),
                    _MetricRow(
                      'Power',
                      '${state.currentMetrics!.power.toStringAsFixed(0)} W',
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
            '${state.repCount ?? 0}',
            style: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 32),
          Text(
            'Set will auto-complete when you stop moving',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAutoStopView(BuildContext context, WorkoutSessionState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            'Auto-stopping in ${state.autoStopSecondsRemaining ?? 3}s',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Continue moving to cancel',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
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
          ref.read(workoutSessionProvider.notifier).resetToIdle(); // Just Lift special: reset to idle
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
                  _SummaryRow('Reps', '${state.repCount ?? 0}'),
                  if (state.completedSets.isNotEmpty) ...[
                    const Divider(height: 16),
                    _SummaryRow(
                      'Avg Concentric',
                      '${state.completedSets.last.concentricAvg.toStringAsFixed(1)} kg',
                    ),
                    const Divider(height: 16),
                    _SummaryRow(
                      'Peak Power',
                      '${state.completedSets.last.powerPeak.toStringAsFixed(0)} W',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Returning to idle...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
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
