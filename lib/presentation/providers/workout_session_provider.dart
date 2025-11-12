import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/ble_repository.dart';
import '../../data/repositories/workout_repository.dart';
import '../../domain/models/workout_state.dart';
import '../../domain/models/workout_parameters.dart';
import '../../domain/models/workout_type.dart';
import '../../domain/models/program_mode.dart';
import '../../domain/models/rep_count.dart';
import '../../domain/models/workout_metric.dart';
import '../../domain/models/routine.dart';
import '../../domain/models/auto_stop_ui_state.dart';
import '../../domain/models/rep_notification.dart';
import '../../domain/models/haptic_event.dart';
import '../../domain/services/rep_counter_from_machine.dart';
import '../../domain/services/metrics_calculator.dart';
import 'workout_session_state.dart';
import 'preferences_provider.dart';
import 'haptic_provider.dart';

final logger = Logger();
const _uuid = Uuid();

/// Provider for BLE repository (must be overridden in main.dart)
final bleRepositoryProvider = Provider<BleRepository>((ref) {
  throw UnimplementedError('bleRepositoryProvider must be overridden');
});

/// Provider for workout repository (must be overridden in main.dart)
final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  throw UnimplementedError('workoutRepositoryProvider must be overridden');
});

/// Provider for rep counter service
final repCounterProvider = Provider<RepCounterFromMachine>((ref) {
  return RepCounterFromMachine();
});

/// Provider for metrics calculator service
final metricsCalculatorProvider = Provider<MetricsCalculator>((ref) {
  return MetricsCalculator();
});

/// StateNotifier for workout session management
/// 
/// Ported from MainViewModel.kt workout state machine (lines 57-1155)
/// Manages workout execution, rep counting, timers, and metrics collection
class WorkoutSessionNotifier extends StateNotifier<WorkoutSessionState> {
  final BleRepository _bleRepository;
  // ignore: unused_field
  final WorkoutRepository _workoutRepository; // TODO: Use for session persistence
  final RepCounterFromMachine _repCounter;
  final MetricsCalculator _metricsCalculator;
  final HapticActions _hapticActions;
  final Ref _ref;

  Timer? _autoStartTimer;
  Timer? _restTimer;
  Timer? _autoStopTimer;

  DateTime? _autoStopStartTime;
  bool _autoStopTriggered = false;
  bool _autoStopStopRequested = false;

  StreamSubscription<WorkoutMetric>? _monitorSubscription;
  StreamSubscription<RepNotification>? _repSubscription;

  WorkoutSessionNotifier(
    this._bleRepository,
    this._workoutRepository,
    this._repCounter,
    this._metricsCalculator,
    this._hapticActions,
    this._ref,
  ) : super(WorkoutSessionState(
        workoutParameters: const WorkoutParameters(
          workoutType: WorkoutType.program(mode: ProgramMode.oldSchool()),
          reps: 0,
        ),
      )) {
    _setupRepCounterCallback();
    _setupMonitorSubscription();
    _setupRepSubscription();
  }

  void _setupRepCounterCallback() {
    _repCounter.onRepEvent = (RepEvent event) {
      final newRepCount = _repCounter.getRepCount();
      state = state.copyWith(repCount: newRepCount);

      // Emit haptic feedback
      switch (event.type) {
        case RepType.warmupCompleted:
        case RepType.workingCompleted:
          _hapticActions.onRepCompleted();
          break;
        case RepType.warmupComplete:
          _hapticActions.emitHaptic(HapticEvent.warmupComplete);
          break;
        case RepType.workoutComplete:
          _hapticActions.emitHaptic(HapticEvent.workoutComplete);
          break;
      }

      // Check if should stop
      if (_repCounter.shouldStopWorkout()) {
        handleSetCompletion();
      }
    };
  }

  void _setupMonitorSubscription() {
    _monitorSubscription?.cancel();
    _monitorSubscription = _bleRepository.monitorData.listen((metric) {
      handleMonitorMetric(metric);
    });
  }

  void _setupRepSubscription() {
    _repSubscription?.cancel();
    _repSubscription = _bleRepository.repEvents.listen((notification) {
      handleRepNotification(notification);
    });
  }

  /// Start workout with optional countdown
  /// 
  /// Ported from MainViewModel.kt startWorkout() (lines 733-817)
  Future<void> startWorkout({
    bool skipCountdown = false,
    bool isJustLiftMode = false,
  }) async {
    final params = state.workoutParameters;

    // Pre-workout countdown
    if (!skipCountdown && !params.isJustLift) {
      for (int i = 5; i >= 1; i--) {
        state = state.copyWith(
          workoutState: WorkoutState.countdown(secondsRemaining: i),
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    // Reset rep counter
    final workingTarget = isJustLiftMode ? 0 : params.reps;
    _repCounter.reset();
    _repCounter.configure(
      warmupTarget: params.warmupReps,
      workingTarget: workingTarget,
      isJustLift: params.isJustLift,
      stopAtTop: params.stopAtTop,
    );

    // Session tracking
    final sessionId = _uuid.v4();
    final startTime = DateTime.now().millisecondsSinceEpoch;

    state = state.copyWith(
      currentSessionId: sessionId,
      workoutStartTime: startTime,
      collectedMetrics: [],
      workoutState: WorkoutState.active(),
      repCount: const RepCount(),
    );

    // Start BLE monitoring
    final result = await _bleRepository.startWorkout(params);
    result.fold(
      (error) {
        state = state.copyWith(
          workoutState: WorkoutState.error(message: error.toString()),
        );
      },
      (_) {
        _hapticActions.onWorkoutStart();
      },
    );
  }

  /// Stop workout and save session
  /// 
  /// Ported from MainViewModel.kt stopWorkout() (lines 819-865)
  Future<void> stopWorkout() async {
    // Cancel timers
    _autoStartTimer?.cancel();
    _restTimer?.cancel();
    _autoStopTimer?.cancel();
    _autoStartTimer = null;
    _restTimer = null;
    _autoStopTimer = null;

    // Stop BLE
    await _bleRepository.stopWorkout();

    // Save session
    await _saveWorkoutSession();

    // Reset state
    _repCounter.reset();
    state = state.copyWith(
      workoutState: WorkoutState.completed(),
      autoStopState: const AutoStopUiState(),
      autoStartCountdown: null,
    );

    _hapticActions.onWorkoutEnd();
  }

  /// Handle set completion (auto-stop or rep target reached)
  /// 
  /// Ported from MainViewModel.kt handleSetCompletion() (lines 888-928)
  Future<void> handleSetCompletion() async {
    final metrics = state.collectedMetrics;

    // Calculate summary metrics
    final peakPower = _metricsCalculator.calculatePeakPower(metrics);
    final averagePower = _metricsCalculator.calculateAveragePower(metrics);
    final repCount = state.repCount.totalReps;

    state = state.copyWith(
      workoutState: WorkoutState.setSummary(
        metrics: metrics,
        peakPower: peakPower,
        averagePower: averagePower,
        repCount: repCount,
      ),
    );

    _hapticActions.onWorkoutEnd();
  }

  /// Proceed from summary screen
  /// 
  /// Ported from MainViewModel.kt proceedFromSummary() (lines 946-1018)
  /// CRITICAL: Just Lift auto-resets to Idle (NOT Completed)
  Future<void> proceedFromSummary() async {
    final params = state.workoutParameters;

    // Just Lift auto-resets to Idle
    if (params.isJustLift) {
      state = state.copyWith(workoutState: WorkoutState.idle());
      return;
    }

    // Check if more sets/exercises
    final routine = state.loadedRoutine;
    if (routine != null && _hasMoreSetsOrExercises()) {
      await startRestTimer();
    } else {
      state = state.copyWith(workoutState: WorkoutState.completed());
    }
  }

  /// Start rest timer between sets
  /// 
  /// Ported from MainViewModel.kt startRestTimer() (lines 1043-1155)
  Future<void> startRestTimer() async {
    final routine = state.loadedRoutine;
    final exerciseIndex = state.currentExerciseIndex;
    final exercise = routine?.exercises[exerciseIndex];
    final restDuration = exercise?.restSeconds ?? 90;

    final nextExercise = _getNextExerciseName();
    final isLastExercise = _isLastExercise();
    final currentSet = state.currentSetIndex + 1;
    final totalSets = exercise?.sets ?? 1;

    state = state.copyWith(
      workoutState: WorkoutState.resting(
        restSecondsRemaining: restDuration,
        nextExerciseName: nextExercise,
        isLastExercise: isLastExercise,
        currentSet: currentSet,
        totalSets: totalSets,
      ),
    );

    // Countdown timer
    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final currentState = state.workoutState;
      if (currentState is Resting) {
        final remaining = currentState.restSecondsRemaining - 1;

        if (remaining <= 0) {
          timer.cancel();
          _restTimer = null;

          // Auto-advance if enabled
          final prefsAsync = _ref.read(userPreferencesProvider);
          prefsAsync.whenData((prefs) async {
            if (prefs.autoplayEnabled) {
              await startNextSetOrExercise();
            } else {
              // Stay in Resting(0) waiting for manual skipRest()
              state = state.copyWith(
                workoutState: currentState.copyWith(restSecondsRemaining: 0),
              );
            }
          });
        } else {
          state = state.copyWith(
            workoutState: currentState.copyWith(restSecondsRemaining: remaining),
          );
        }
      } else {
        timer.cancel();
        _restTimer = null;
      }
    });
  }

  /// Skip rest timer and start next set/exercise immediately
  /// 
  /// Ported from MainViewModel.kt skipRest() (lines 1240-1267)
  Future<void> skipRest() async {
    _restTimer?.cancel();
    _restTimer = null;
    await startNextSetOrExercise();
  }

  /// Start next set or exercise in routine
  /// 
  /// Ported from MainViewModel.kt startNextSetOrExercise() (lines 1157-1238)
  /// State Guard: ONLY callable from Resting state
  Future<void> startNextSetOrExercise() async {
    final currentState = state.workoutState;
    if (currentState is! Resting) {
      logger.w('startNextSetOrExercise called from non-Resting state');
      return;
    }

    final routine = state.loadedRoutine;
    if (routine == null) {
      await stopWorkout();
      return;
    }

    var setIndex = state.currentSetIndex + 1;
    var exerciseIndex = state.currentExerciseIndex;

    final currentExercise = routine.exercises[exerciseIndex];

    // Move to next exercise?
    if (setIndex >= currentExercise.sets) {
      setIndex = 0;
      exerciseIndex++;
    }

    // No more exercises?
    if (exerciseIndex >= routine.exercises.length) {
      await stopWorkout();
      return;
    }

    // Update indices
    state = state.copyWith(
      currentSetIndex: setIndex,
      currentExerciseIndex: exerciseIndex,
    );

    // Update parameters for new exercise
    final nextExercise = routine.exercises[exerciseIndex];
    state = state.copyWith(
      workoutParameters: state.workoutParameters.copyWith(
        selectedExerciseId: nextExercise.exerciseId,
        reps: nextExercise.reps,
        weightPerCableKg: nextExercise.weightPerCableKg,
      ),
    );

    await startWorkout(skipCountdown: true);
  }

  /// Handle monitor metric from BLE
  /// 
  /// Ported from MainViewModel.kt handleMonitorMetric() (lines 450-462)
  void handleMonitorMetric(WorkoutMetric metric) {
    state = state.copyWith(currentMetric: metric);

    final currentState = state.workoutState;
    if (currentState is Active) {
      // Collect metrics
      final updated = List<WorkoutMetric>.from(state.collectedMetrics)..add(metric);
      state = state.copyWith(collectedMetrics: updated);

      // Check auto-stop for Just Lift
      if (state.workoutParameters.isJustLift) {
        _checkAutoStop(metric);
      } else {
        _resetAutoStopTimer();
      }
    }
  }

  /// Handle rep notification from BLE
  /// 
  /// Ported from MainViewModel.kt handleRepNotification() (lines 467-478)
  void handleRepNotification(RepNotification notification) {
    _repCounter.process(
      topCounter: notification.topCounter,
      completeCounter: notification.completeCounter,
      posA: state.currentMetric?.positionA.toDouble(),
      posB: state.currentMetric?.positionB.toDouble(),
    );

    state = state.copyWith(
      repRanges: _repCounter.getRepRanges(),
    );
  }

  /// Check auto-stop timer for Just Lift mode
  /// 
  /// Ported from MainViewModel.kt checkAutoStop() (lines 495-529)
  void _checkAutoStop(WorkoutMetric metric) {
    final inDangerZone = _repCounter.isInDangerZone();

    if (inDangerZone && !_autoStopTriggered) {
      _autoStopStartTime ??= DateTime.now();

      final elapsed = DateTime.now().difference(_autoStopStartTime!).inMilliseconds / 1000.0;
      final progress = (elapsed / 3.0).clamp(0.0, 1.0);
      final secondsRemaining = math.max(0, 3 - elapsed.ceil());

      state = state.copyWith(
        autoStopState: AutoStopUiState(
          isActive: true,
          progress: progress,
          secondsRemaining: secondsRemaining,
        ),
      );

      // Trigger after 3 seconds
      if (elapsed >= 3.0 && !_autoStopStopRequested) {
        _autoStopTriggered = true;
        _autoStopStopRequested = true;
        handleSetCompletion();
      }
    } else if (!inDangerZone) {
      _resetAutoStopTimer();
    }
  }

  void _resetAutoStopTimer() {
    _autoStopStartTime = null;
    _autoStopTriggered = false;
    _autoStopStopRequested = false;

    state = state.copyWith(
      autoStopState: const AutoStopUiState(),
    );
  }

  /// Start auto-start timer (grab-to-start 3s countdown)
  /// 
  /// Ported from MainViewModel.kt startAutoStartTimer() (lines 428-448)
  void startAutoStartTimer() {
    if (state.workoutState is! Idle) return;
    if (!state.workoutParameters.useAutoStart) return;

    state = state.copyWith(autoStartCountdown: 3);

    _autoStartTimer?.cancel();
    _autoStartTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final countdown = state.autoStartCountdown;
      if (countdown == null) {
        timer.cancel();
        _autoStartTimer = null;
        return;
      }

      final next = countdown - 1;
      if (next <= 0) {
        timer.cancel();
        _autoStartTimer = null;
        state = state.copyWith(autoStartCountdown: null);
        startWorkout(isJustLiftMode: true);
      } else {
        state = state.copyWith(autoStartCountdown: next);
      }
    });
  }

  /// Cancel auto-start timer
  void cancelAutoStartTimer() {
    _autoStartTimer?.cancel();
    _autoStartTimer = null;
    state = state.copyWith(autoStartCountdown: null);
  }

  /// Reset for new workout without disconnecting BLE
  /// 
  /// Ported from MainViewModel.kt resetForNewWorkout() (lines 1452-1459)
  void resetForNewWorkout() {
    _repCounter.reset();
    state = state.copyWith(
      workoutState: WorkoutState.idle(),
      repCount: const RepCount(),
      repRanges: null,
      currentExerciseIndex: 0,
      currentSetIndex: 0,
      autoStopState: const AutoStopUiState(),
      autoStartCountdown: null,
    );
  }

  /// Load routine and configure workout parameters
  /// 
  /// Ported from MainViewModel.kt loadRoutine() (lines 1525-1568)
  /// CRITICAL: Set isJustLift=false
  void loadRoutine(Routine routine) {
    if (routine.exercises.isEmpty) {
      logger.w('Cannot load routine with no exercises');
      return;
    }

    final firstExercise = routine.exercises.first;
    state = state.copyWith(
      loadedRoutine: routine,
      currentExerciseIndex: 0,
      currentSetIndex: 0,
      workoutParameters: state.workoutParameters.copyWith(
        isJustLift: false,
        selectedExerciseId: firstExercise.exerciseId,
        reps: firstExercise.reps,
        weightPerCableKg: firstExercise.weightPerCableKg,
      ),
    );
  }

  /// Helper: Check if more sets or exercises remain
  bool _hasMoreSetsOrExercises() {
    final routine = state.loadedRoutine;
    if (routine == null) return false;

    final exerciseIndex = state.currentExerciseIndex;
    final setIndex = state.currentSetIndex;

    if (exerciseIndex >= routine.exercises.length) return false;

    final currentExercise = routine.exercises[exerciseIndex];
    if (setIndex + 1 < currentExercise.sets) return true;

    return exerciseIndex + 1 < routine.exercises.length;
  }

  /// Helper: Get next exercise name for rest timer display
  String _getNextExerciseName() {
    final routine = state.loadedRoutine;
    if (routine == null) return '';

    final exerciseIndex = state.currentExerciseIndex;
    final setIndex = state.currentSetIndex;

    // If more sets in current exercise
    if (setIndex + 1 < routine.exercises[exerciseIndex].sets) {
      return routine.exercises[exerciseIndex].exerciseId; // TODO: Get exercise name
    }

    // Next exercise
    if (exerciseIndex + 1 < routine.exercises.length) {
      return routine.exercises[exerciseIndex + 1].exerciseId; // TODO: Get exercise name
    }

    return '';
  }

  /// Helper: Check if current exercise is last in routine
  bool _isLastExercise() {
    final routine = state.loadedRoutine;
    if (routine == null) return true;

    final exerciseIndex = state.currentExerciseIndex;
    final setIndex = state.currentSetIndex;
    final currentExercise = routine.exercises[exerciseIndex];

    // If more sets in current exercise, not last
    if (setIndex + 1 < currentExercise.sets) return false;

    // Check if last exercise
    return exerciseIndex + 1 >= routine.exercises.length;
  }

  /// Save workout session to database
  /// 
  /// TODO: Implement full session persistence
  Future<void> _saveWorkoutSession() async {
    final sessionId = state.currentSessionId;
    final startTime = state.workoutStartTime;
    final metrics = state.collectedMetrics;

    if (sessionId == null || startTime == null) {
      logger.w('Cannot save workout session: missing sessionId or startTime');
      return;
    }

    // TODO: Create WorkoutSession domain model and save via repository
    // For now, just log
    logger.d('Would save workout session: $sessionId with ${metrics.length} metrics');
  }

  @override
  void dispose() {
    _autoStartTimer?.cancel();
    _restTimer?.cancel();
    _autoStopTimer?.cancel();
    _monitorSubscription?.cancel();
    _repSubscription?.cancel();
    super.dispose();
  }
}

/// Provider for workout session notifier
final workoutSessionProvider = StateNotifierProvider<WorkoutSessionNotifier, WorkoutSessionState>((ref) {
  final bleRepo = ref.watch(bleRepositoryProvider);
  final workoutRepo = ref.watch(workoutRepositoryProvider);
  final repCounter = ref.watch(repCounterProvider);
  final metricsCalc = ref.watch(metricsCalculatorProvider);
  final hapticActions = ref.watch(hapticActionsProvider);

  return WorkoutSessionNotifier(
    bleRepo,
    workoutRepo,
    repCounter,
    metricsCalc,
    hapticActions,
    ref,
  );
});

/// Actions provider for workout operations
final workoutSessionActionsProvider = Provider<WorkoutSessionActions>((ref) {
  final notifier = ref.watch(workoutSessionProvider.notifier);
  return WorkoutSessionActions(notifier);
});

/// Actions class for workout operations
class WorkoutSessionActions {
  final WorkoutSessionNotifier _notifier;

  WorkoutSessionActions(this._notifier);

  Future<void> startWorkout({bool skipCountdown = false, bool isJustLiftMode = false}) =>
      _notifier.startWorkout(skipCountdown: skipCountdown, isJustLiftMode: isJustLiftMode);

  Future<void> stopWorkout() => _notifier.stopWorkout();
  Future<void> proceedFromSummary() => _notifier.proceedFromSummary();
  Future<void> skipRest() => _notifier.skipRest();
  void handleMonitorMetric(WorkoutMetric metric) => _notifier.handleMonitorMetric(metric);
  void handleRepNotification(RepNotification notification) => _notifier.handleRepNotification(notification);
  void startAutoStartTimer() => _notifier.startAutoStartTimer();
  void cancelAutoStartTimer() => _notifier.cancelAutoStartTimer();
  void resetForNewWorkout() => _notifier.resetForNewWorkout();
  void loadRoutine(Routine routine) => _notifier.loadRoutine(routine);
}
