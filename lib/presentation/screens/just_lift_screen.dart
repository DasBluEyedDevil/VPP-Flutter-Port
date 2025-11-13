import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/connection_state.dart' as domain;
import '../../domain/models/workout_mode.dart';
import '../../domain/models/program_mode.dart' as prog;
import '../../domain/models/echo_level.dart';
import '../../domain/models/eccentric_load.dart';
import '../../domain/models/weight_unit.dart';
import '../../domain/models/workout_parameters.dart';
import '../../domain/models/workout_state.dart';
import '../providers/workout_session_provider.dart';
import '../providers/workout_session_state.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/preferences_provider.dart';
import '../theme/spacing.dart';
import '../widgets/workout/cable_position_indicator.dart';
import '../widgets/workout/auto_start_stop_card.dart';
import '../widgets/workout/mode_selection_card.dart';
import '../widgets/workout/eccentric_load_card.dart';
import '../widgets/workout/echo_level_card.dart';
import '../widgets/workout/active_status_card.dart';
import '../widgets/inputs/compact_number_picker.dart';
import '../widgets/overlays/connecting_overlay.dart';
import '../widgets/dialogs/connection_error_dialog.dart';

/// Just Lift screen - Quick workout configuration with auto-start/stop
///
/// Ported from Kotlin JustLiftScreen.kt (lines 1-850)
/// Provides auto-start (grab handles) and auto-stop (rest 3s) functionality
class JustLiftScreen extends ConsumerStatefulWidget {
  const JustLiftScreen({super.key});

  @override
  ConsumerState<JustLiftScreen> createState() => _JustLiftScreenState();
}

class _JustLiftScreenState extends ConsumerState<JustLiftScreen> {
  // Local state for Just Lift configuration
  WorkoutMode _selectedMode = const WorkoutMode.oldSchool();
  double _weightPerCableKg = 20.0; // Default 20 kg
  double _weightChangePerRepKg = 0.0;
  EccentricLoad _eccentricLoad = EccentricLoad.load100;
  EchoLevel _echoLevel = EchoLevel.harder;

  @override
  void initState() {
    super.initState();
    // Initialize from current workout parameters if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workoutState = ref.read(workoutSessionProvider);
      final params = workoutState.workoutParameters;
      if (params.isJustLift) {
        _updateFromParameters(params);
      }
    });
  }

  void _updateFromParameters(WorkoutParameters params) {
    // Extract mode from workoutType
    params.workoutType.when(
      program: (mode) {
        setState(() {
          _selectedMode = switch (mode) {
            prog.OldSchool() => const WorkoutMode.oldSchool(),
            prog.Pump() => const WorkoutMode.pump(),
            _ => const WorkoutMode.oldSchool(),
          };
          _weightPerCableKg = params.weightPerCableKg;
          _weightChangePerRepKg = params.progressionRegressionKg;
        });
      },
      echo: (level, eccentricLoad) {
        setState(() {
          _selectedMode = WorkoutMode.echo(level: level);
          _eccentricLoad = eccentricLoad;
          _echoLevel = level;
        });
      },
    );
  }

  void _updateWorkoutParameters() {
    final notifier = ref.read(workoutSessionProvider.notifier);
    final currentState = ref.read(workoutSessionProvider);
    final weightUnit = ref.read(weightUnitProvider);

    // Convert display weight to kg if needed
    final weightKg = weightUnit == WeightUnit.kg
        ? _weightPerCableKg
        : _weightPerCableKg / 2.20462;
    final changeKg = weightUnit == WeightUnit.kg
        ? _weightChangePerRepKg
        : _weightChangePerRepKg / 2.20462;

    // Convert WorkoutMode to WorkoutType
    final workoutType = _selectedMode.toWorkoutType(
      eccentricLoad: _eccentricLoad,
    );

    final newParams = currentState.workoutParameters.copyWith(
      workoutType: workoutType,
      weightPerCableKg: weightKg,
      progressionRegressionKg: changeKg,
      isJustLift: true,
      useAutoStart: true,
    );

    // Update state via notifier's public method
    notifier.updateWorkoutParameters(newParams);
  }

  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(workoutSessionProvider);
    final connectionStateAsync = ref.watch(connectionStateProvider);
    final weightUnit = ref.watch(weightUnitProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Gradient background colors
    final gradientColors = isDark
        ? [
            const Color(0xFF0F172A), // slate-900
            const Color(0xFF1E1B4B), // indigo-950
            const Color(0xFF172554), // blue-950
          ]
        : [
            const Color(0xFFE0E7FF), // indigo-200
            const Color(0xFFFCE7F3), // pink-100
            const Color(0xFFDDD6FE), // violet-200
          ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Just Lift'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: connectionStateAsync.when(
          data: (connState) => _buildBody(
            context,
            workoutState,
            connState,
            weightUnit,
            isDark,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WorkoutSessionState workoutState,
    domain.ConnectionState connectionState,
    WeightUnit weightUnit,
    bool isDark,
  ) {
    final workoutStateValue = workoutState.workoutState;
    final isActive = workoutStateValue is Active ||
        workoutStateValue is Countdown ||
        workoutStateValue is Resting;
    final showPositionBars = isActive && workoutState.currentMetric != null;

    return Stack(
      children: [
        // Left position bar (only when active)
        if (showPositionBars)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: CablePositionIndicator(
              label: 'L',
              currentPosition: workoutState.currentMetric!.positionA,
              isActive: true,
            ),
          ),

        // Center content (scrollable)
        Positioned(
          left: showPositionBars ? 56 : 0,
          right: showPositionBars ? 56 : 0,
          top: 0,
          bottom: 0,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Auto-start/stop card
                AutoStartStopCard(
                  workoutState: workoutStateValue,
                  autoStartCountdown: workoutState.autoStartCountdown,
                  autoStopState: workoutState.autoStopState,
                ),

                const SizedBox(height: AppSpacing.medium),

                // Mode selection
                ModeSelectionCard(
                  selectedMode: _selectedMode,
                  onModeChanged: (mode) {
                    setState(() => _selectedMode = mode);
                    _updateWorkoutParameters();
                  },
                ),

                const SizedBox(height: AppSpacing.medium),

                // Conditional: Old School / Pump configuration
                if (!_selectedMode.map(
                  oldSchool: (_) => false,
                  pump: (_) => false,
                  tut: (_) => false,
                  tutBeast: (_) => false,
                  eccentricOnly: (_) => false,
                  echo: (_) => true,
                )) ...[
                  CompactNumberPicker(
                    label: 'Weight per Cable',
                    value: _getDisplayWeight(_weightPerCableKg, weightUnit),
                    min: 1,
                    max: weightUnit == WeightUnit.kg ? 100 : 220,
                    suffix: weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
                    onChanged: (value) {
                      setState(() {
                        _weightPerCableKg = weightUnit == WeightUnit.kg
                            ? value.toDouble()
                            : value / 2.20462;
                      });
                      _updateWorkoutParameters();
                    },
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CompactNumberPicker(
                        label: 'Weight Change Per Rep',
                        value: _getDisplayWeight(_weightChangePerRepKg, weightUnit),
                        min: -10,
                        max: 10,
                        suffix: weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
                        onChanged: (value) {
                          setState(() {
                            _weightChangePerRepKg = weightUnit == WeightUnit.kg
                                ? value.toDouble()
                                : value / 2.20462;
                          });
                          _updateWorkoutParameters();
                        },
                      ),
                      const SizedBox(height: AppSpacing.small),
                      Text(
                        'Negative = Regression, Positive = Progression',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ],

                // Conditional: Echo configuration
                if (_selectedMode.map(
                  oldSchool: (_) => false,
                  pump: (_) => false,
                  tut: (_) => false,
                  tutBeast: (_) => false,
                  eccentricOnly: (_) => false,
                  echo: (_) => true,
                )) ...[
                  EccentricLoadCard(
                    eccentricLoad: _eccentricLoad,
                    onChanged: (load) {
                      setState(() => _eccentricLoad = load);
                      _updateWorkoutParameters();
                    },
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  EchoLevelCard(
                    selectedLevel: _echoLevel,
                    onChanged: (level) {
                      setState(() {
                        _echoLevel = level;
                        _selectedMode = WorkoutMode.echo(level: level);
                      });
                      _updateWorkoutParameters();
                    },
                  ),
                ],

                // Conditional: Active status card
                if (isActive) ...[
                  const SizedBox(height: AppSpacing.medium),
                  const Divider(),
                  const SizedBox(height: AppSpacing.medium),
                  ActiveStatusCard(
                    workoutState: workoutStateValue,
                    totalReps: workoutState.repCount.totalReps,
                    currentLoad: workoutState.currentMetric?.totalLoad ?? 0.0,
                    weightUnit: weightUnit,
                    onStop: () {
                      ref.read(workoutSessionProvider.notifier).stopWorkout();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),

        // Right position bar (only when active)
        if (showPositionBars)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 40,
            child: CablePositionIndicator(
              label: 'R',
              currentPosition: workoutState.currentMetric!.positionB,
              isActive: true,
            ),
          ),

        // Overlays
        if (connectionState is domain.Connecting)
          ConnectingOverlay(
            onCancel: () {
              final actions = ref.read(bleConnectionActionsProvider);
              actions.disconnect();
            },
          ),
        if (connectionState is domain.ConnectionError)
          ConnectionErrorDialog(
            message: connectionState.message,
            onRetry: () {
              final actions = ref.read(bleConnectionActionsProvider);
              actions.ensureConnection(onConnected: () {}, onFailed: () {});
            },
            onDismiss: () {
              // Error state will clear automatically
            },
          ),
      ],
    );
  }

  int _getDisplayWeight(double weightKg, WeightUnit unit) {
    return unit == WeightUnit.kg
        ? weightKg.round()
        : (weightKg * 2.20462).round();
  }
}
