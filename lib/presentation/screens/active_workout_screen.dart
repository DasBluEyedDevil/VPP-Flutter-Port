import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/connection_state.dart' as ble;
import '../../domain/models/weight_unit.dart';
import '../../domain/models/workout_state.dart';
import '../providers/workout_session_provider.dart';
import '../providers/workout_session_state.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/preferences_provider.dart';
import '../widgets/workout/countdown_card.dart';
import '../widgets/workout/rest_timer_card.dart';
import '../widgets/workout/set_summary_card.dart';
import '../widgets/workout/cable_position_indicator.dart';
import '../widgets/workout/connection_card.dart';
import '../widgets/workout/idle_state_card.dart';
import '../widgets/workout/active_state_card.dart';
import '../widgets/workout/rep_counter_card.dart';
import '../widgets/workout/current_exercise_card.dart';
import '../widgets/workout/live_metrics_card.dart';
import '../widgets/dialogs/connection_lost_dialog.dart';
import '../widgets/dialogs/workout_setup_dialog.dart';
import '../navigation/routes.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final connectionStateAsync = ref.watch(connectionStateProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Show connection lost dialog if disconnected during workout
    connectionStateAsync.whenData((connState) {
      if (workoutState.connectionLostDuringWorkout && connState is! ble.Connected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showConnectionLostDialog(context, ref);
        });
      }
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF0F172A), // Slate-950
                  const Color(0xFF312E81), // Purple-950
                  const Color(0xFF0F172A), // Slate-950
                ]
              : [
                  const Color(0xFFF8FAFC), // Slate-50
                  const Color(0xFFF5F3FF), // Purple-50
                  const Color(0xFFEFF6FF), // Blue-50
                ],
        ),
      ),
      child: SafeArea(
        child: _buildWorkoutBody(context, ref, workoutState, connectionStateAsync),
      ),
    );
  }

  Widget _buildWorkoutBody(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
    AsyncValue<ble.ConnectionState> connectionStateAsync,
  ) {
    final workoutState = state.workoutState;
    final connectionState = connectionStateAsync.valueOrNull;
    final showPositionBars = connectionState is ble.Connected &&
        workoutState is Active &&
        state.currentMetric != null;

    return Stack(
      children: [
        // Left position bar (edge)
        if (showPositionBars)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: CablePositionIndicator(
              label: 'L',
              currentPosition: state.currentMetric!.positionA,
              minPosition: state.repRanges?.minPosition.toInt(),
              maxPosition: state.repRanges?.maxPosition.toInt(),
              isActive: state.currentMetric!.positionA > 0,
            ),
          ),

        // Center content (scrollable)
        Positioned(
          left: showPositionBars ? 56 : 0, // 40dp bar + 16dp gap
          right: showPositionBars ? 56 : 0,
          top: 0,
          bottom: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                // Connection Card (always visible if connection state available)
                if (connectionState != null) ...[
                  ConnectionCard(
                    connectionState: connectionState,
                    onScan: () {
                      ref.read(bleConnectionActionsProvider).startScanning();
                    },
                    onDisconnect: () {
                      ref.read(bleConnectionActionsProvider).disconnect();
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // State-specific cards
                ...workoutState.when(
                  idle: () => [
                    IdleStateCard(
                      onShowSetup: () async {
                        await WorkoutSetupDialog.show(context);
                        // Dialog handles starting workout if confirmed
                      },
                    ),
                  ],
                  initializing: () => [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  countdown: (secondsRemaining) => [
                    // Countdown is shown as overlay, not in scroll
                    const SizedBox.shrink(),
                  ],
                  active: () => _buildActiveWorkoutCards(context, ref, state),
                  paused: () => [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            const Icon(Icons.pause_circle, size: 64),
                            const SizedBox(height: 16),
                            Text(
                              'Workout Paused',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  resting: (
                    restSecondsRemaining,
                    nextExerciseName,
                    isLastExercise,
                    currentSet,
                    totalSets,
                  ) =>
                      [
                    // Rest timer is shown as overlay, not in scroll
                    const SizedBox.shrink(),
                  ],
                  setSummary: (metrics, peakPower, averagePower, repCount) => [
                    // Set summary is shown as overlay, not in scroll
                    const SizedBox.shrink(),
                  ],
                  completed: () => [
                    _buildCompletedCard(context, ref),
                  ],
                  error: (message) => [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            const Icon(Icons.error_outline,
                                size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(
                              'Error',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              message,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Right position bar (edge)
        if (showPositionBars)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: CablePositionIndicator(
              label: 'R',
              currentPosition: state.currentMetric!.positionB,
              minPosition: state.repRanges?.minPosition.toInt(),
              maxPosition: state.repRanges?.maxPosition.toInt(),
              isActive: state.currentMetric!.positionB > 0,
            ),
          ),

        // Overlays (floating on top)
        ...workoutState.when(
          idle: () => [],
          initializing: () => [],
          countdown: (secondsRemaining) => [
            _buildOverlay(
              context,
              CountdownCard(secondsRemaining: secondsRemaining),
            ),
          ],
          active: () => [],
          paused: () => [],
          resting: (
            restSecondsRemaining,
            nextExerciseName,
            isLastExercise,
            currentSet,
            totalSets,
          ) =>
              [
            _buildOverlay(
              context,
              RestTimerCard(
                secondsRemaining: restSecondsRemaining,
                totalSeconds: _getRestTotalSeconds(state),
                nextExerciseName: nextExerciseName,
                isLastExercise: isLastExercise,
                currentSet: currentSet,
                totalSets: totalSets,
                onSkip: () => ref.read(workoutSessionActionsProvider).skipRest(),
              ),
            ),
          ],
          setSummary: (metrics, peakPower, averagePower, repCount) => [
            _buildOverlay(
              context,
              _buildSetSummaryOverlay(context, ref, state, metrics,
                  peakPower, averagePower, repCount),
            ),
          ],
          completed: () => [],
          error: (_) => [],
        ),
      ],
    );
  }

  List<Widget> _buildActiveWorkoutCards(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState state,
  ) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final weightUnit = prefsAsync.valueOrNull?.weightUnit ?? WeightUnit.kg;

    return [
      ActiveStateCard(
        onStop: () => _confirmEndWorkout(context, ref),
        justLiftTimer: state.workoutParameters.isJustLift &&
                state.autoStopState.isActive
            ? state.autoStopState.secondsRemaining
            : null,
      ),
      const SizedBox(height: 16),
      RepCounterCard(
        warmupReps: state.repCount.warmupReps,
        workingReps: state.repCount.workingReps,
        totalReps: state.repCount.totalReps,
        isWarmup: !state.repCount.isWarmupComplete,
      ),
      const SizedBox(height: 16),
      if (state.loadedRoutine != null &&
          state.currentExerciseIndex < state.loadedRoutine!.exercises.length)
        CurrentExerciseCard(
          exerciseName: state.loadedRoutine!.exercises[state.currentExerciseIndex]
              .exerciseId,
          currentSet: state.currentSetIndex + 1,
          totalSets: state.loadedRoutine!.exercises[state.currentExerciseIndex].sets,
        ),
      if (state.loadedRoutine != null &&
          state.currentExerciseIndex < state.loadedRoutine!.exercises.length)
        const SizedBox(height: 16),
      if (state.repCount.isWarmupComplete)
        LiveMetricsCard(
          currentMetric: state.currentMetric,
          weightUnit: weightUnit,
          showDuringWarmup: false,
        ),
    ];
  }

  Widget _buildCompletedCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Workout Complete!',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ref.read(workoutSessionActionsProvider).resetForNewWorkout();
                  context.go(Routes.home);
                },
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context, Widget child) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: Center(child: child),
    );
  }

  Widget _buildSetSummaryOverlay(
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
        formatWeight: (weight, unit) =>
            '${weight.toStringAsFixed(1)} ${unit == WeightUnit.kg ? 'kg' : 'lbs'}',
        onContinue: () {
          ref.read(workoutSessionActionsProvider).proceedFromSummary();
        },
      ),
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text('Error: $err'),
        ),
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
        onDismiss: () {
          Navigator.pop(context);
          ref.read(workoutSessionActionsProvider).stopWorkout();
          context.go(Routes.home);
        },
      ),
    );
  }

  /// Get rest timer total seconds from routine exercise or default to 90
  int _getRestTotalSeconds(WorkoutSessionState state) {
    final routine = state.loadedRoutine;
    if (routine != null &&
        state.currentExerciseIndex < routine.exercises.length) {
      final exercise = routine.exercises[state.currentExerciseIndex];
      return exercise.restSeconds;
    }
    return 90; // Default rest time
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
      ref.read(workoutSessionActionsProvider).stopWorkout();
      context.go(Routes.home);
    }
  }
}
