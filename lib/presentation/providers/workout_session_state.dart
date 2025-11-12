import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/workout_state.dart';
import '../../domain/models/workout_parameters.dart';
import '../../domain/models/rep_count.dart';
import '../../domain/models/rep_ranges.dart';
import '../../domain/models/workout_metric.dart';
import '../../domain/models/routine.dart';
import '../../domain/models/auto_stop_ui_state.dart';

part 'workout_session_state.freezed.dart';

/// Workout session state for Riverpod provider
/// 
/// Contains all state related to workout execution, rep counting, timers, and metrics
@freezed
class WorkoutSessionState with _$WorkoutSessionState {
  const factory WorkoutSessionState({
    @Default(WorkoutState.idle()) WorkoutState workoutState,
    WorkoutMetric? currentMetric,
    required WorkoutParameters workoutParameters,
    @Default(RepCount()) RepCount repCount,
    RepRanges? repRanges,
    @Default(AutoStopUiState()) AutoStopUiState autoStopState,
    int? autoStartCountdown,
    Routine? loadedRoutine,
    @Default(0) int currentExerciseIndex,
    @Default(0) int currentSetIndex,
    @Default(false) bool connectionLostDuringWorkout,
    
    // Internal state (not exposed in Kotlin but needed)
    String? currentSessionId,
    int? workoutStartTime,
    @Default([]) List<WorkoutMetric> collectedMetrics,
  }) = _WorkoutSessionState;
}
