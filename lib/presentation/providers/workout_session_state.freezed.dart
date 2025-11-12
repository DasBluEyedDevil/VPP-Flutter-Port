// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutSessionState {
  WorkoutState get workoutState => throw _privateConstructorUsedError;
  WorkoutMetric? get currentMetric => throw _privateConstructorUsedError;
  WorkoutParameters get workoutParameters => throw _privateConstructorUsedError;
  RepCount get repCount => throw _privateConstructorUsedError;
  RepRanges? get repRanges => throw _privateConstructorUsedError;
  AutoStopUiState get autoStopState => throw _privateConstructorUsedError;
  int? get autoStartCountdown => throw _privateConstructorUsedError;
  Routine? get loadedRoutine => throw _privateConstructorUsedError;
  int get currentExerciseIndex => throw _privateConstructorUsedError;
  int get currentSetIndex => throw _privateConstructorUsedError;
  bool get connectionLostDuringWorkout =>
      throw _privateConstructorUsedError; // Internal state (not exposed in Kotlin but needed)
  String? get currentSessionId => throw _privateConstructorUsedError;
  int? get workoutStartTime => throw _privateConstructorUsedError;
  List<WorkoutMetric> get collectedMetrics =>
      throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionStateCopyWith<WorkoutSessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionStateCopyWith<$Res> {
  factory $WorkoutSessionStateCopyWith(
    WorkoutSessionState value,
    $Res Function(WorkoutSessionState) then,
  ) = _$WorkoutSessionStateCopyWithImpl<$Res, WorkoutSessionState>;
  @useResult
  $Res call({
    WorkoutState workoutState,
    WorkoutMetric? currentMetric,
    WorkoutParameters workoutParameters,
    RepCount repCount,
    RepRanges? repRanges,
    AutoStopUiState autoStopState,
    int? autoStartCountdown,
    Routine? loadedRoutine,
    int currentExerciseIndex,
    int currentSetIndex,
    bool connectionLostDuringWorkout,
    String? currentSessionId,
    int? workoutStartTime,
    List<WorkoutMetric> collectedMetrics,
  });

  $WorkoutStateCopyWith<$Res> get workoutState;
  $WorkoutMetricCopyWith<$Res>? get currentMetric;
  $WorkoutParametersCopyWith<$Res> get workoutParameters;
  $RepCountCopyWith<$Res> get repCount;
  $RepRangesCopyWith<$Res>? get repRanges;
  $AutoStopUiStateCopyWith<$Res> get autoStopState;
  $RoutineCopyWith<$Res>? get loadedRoutine;
}

/// @nodoc
class _$WorkoutSessionStateCopyWithImpl<$Res, $Val extends WorkoutSessionState>
    implements $WorkoutSessionStateCopyWith<$Res> {
  _$WorkoutSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutState = null,
    Object? currentMetric = freezed,
    Object? workoutParameters = null,
    Object? repCount = null,
    Object? repRanges = freezed,
    Object? autoStopState = null,
    Object? autoStartCountdown = freezed,
    Object? loadedRoutine = freezed,
    Object? currentExerciseIndex = null,
    Object? currentSetIndex = null,
    Object? connectionLostDuringWorkout = null,
    Object? currentSessionId = freezed,
    Object? workoutStartTime = freezed,
    Object? collectedMetrics = null,
  }) {
    return _then(
      _value.copyWith(
            workoutState: null == workoutState
                ? _value.workoutState
                : workoutState // ignore: cast_nullable_to_non_nullable
                      as WorkoutState,
            currentMetric: freezed == currentMetric
                ? _value.currentMetric
                : currentMetric // ignore: cast_nullable_to_non_nullable
                      as WorkoutMetric?,
            workoutParameters: null == workoutParameters
                ? _value.workoutParameters
                : workoutParameters // ignore: cast_nullable_to_non_nullable
                      as WorkoutParameters,
            repCount: null == repCount
                ? _value.repCount
                : repCount // ignore: cast_nullable_to_non_nullable
                      as RepCount,
            repRanges: freezed == repRanges
                ? _value.repRanges
                : repRanges // ignore: cast_nullable_to_non_nullable
                      as RepRanges?,
            autoStopState: null == autoStopState
                ? _value.autoStopState
                : autoStopState // ignore: cast_nullable_to_non_nullable
                      as AutoStopUiState,
            autoStartCountdown: freezed == autoStartCountdown
                ? _value.autoStartCountdown
                : autoStartCountdown // ignore: cast_nullable_to_non_nullable
                      as int?,
            loadedRoutine: freezed == loadedRoutine
                ? _value.loadedRoutine
                : loadedRoutine // ignore: cast_nullable_to_non_nullable
                      as Routine?,
            currentExerciseIndex: null == currentExerciseIndex
                ? _value.currentExerciseIndex
                : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            currentSetIndex: null == currentSetIndex
                ? _value.currentSetIndex
                : currentSetIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            connectionLostDuringWorkout: null == connectionLostDuringWorkout
                ? _value.connectionLostDuringWorkout
                : connectionLostDuringWorkout // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentSessionId: freezed == currentSessionId
                ? _value.currentSessionId
                : currentSessionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            workoutStartTime: freezed == workoutStartTime
                ? _value.workoutStartTime
                : workoutStartTime // ignore: cast_nullable_to_non_nullable
                      as int?,
            collectedMetrics: null == collectedMetrics
                ? _value.collectedMetrics
                : collectedMetrics // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutMetric>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutStateCopyWith<$Res> get workoutState {
    return $WorkoutStateCopyWith<$Res>(_value.workoutState, (value) {
      return _then(_value.copyWith(workoutState: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutMetricCopyWith<$Res>? get currentMetric {
    if (_value.currentMetric == null) {
      return null;
    }

    return $WorkoutMetricCopyWith<$Res>(_value.currentMetric!, (value) {
      return _then(_value.copyWith(currentMetric: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutParametersCopyWith<$Res> get workoutParameters {
    return $WorkoutParametersCopyWith<$Res>(_value.workoutParameters, (value) {
      return _then(_value.copyWith(workoutParameters: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepCountCopyWith<$Res> get repCount {
    return $RepCountCopyWith<$Res>(_value.repCount, (value) {
      return _then(_value.copyWith(repCount: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepRangesCopyWith<$Res>? get repRanges {
    if (_value.repRanges == null) {
      return null;
    }

    return $RepRangesCopyWith<$Res>(_value.repRanges!, (value) {
      return _then(_value.copyWith(repRanges: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AutoStopUiStateCopyWith<$Res> get autoStopState {
    return $AutoStopUiStateCopyWith<$Res>(_value.autoStopState, (value) {
      return _then(_value.copyWith(autoStopState: value) as $Val);
    });
  }

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoutineCopyWith<$Res>? get loadedRoutine {
    if (_value.loadedRoutine == null) {
      return null;
    }

    return $RoutineCopyWith<$Res>(_value.loadedRoutine!, (value) {
      return _then(_value.copyWith(loadedRoutine: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutSessionStateImplCopyWith<$Res>
    implements $WorkoutSessionStateCopyWith<$Res> {
  factory _$$WorkoutSessionStateImplCopyWith(
    _$WorkoutSessionStateImpl value,
    $Res Function(_$WorkoutSessionStateImpl) then,
  ) = __$$WorkoutSessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutState workoutState,
    WorkoutMetric? currentMetric,
    WorkoutParameters workoutParameters,
    RepCount repCount,
    RepRanges? repRanges,
    AutoStopUiState autoStopState,
    int? autoStartCountdown,
    Routine? loadedRoutine,
    int currentExerciseIndex,
    int currentSetIndex,
    bool connectionLostDuringWorkout,
    String? currentSessionId,
    int? workoutStartTime,
    List<WorkoutMetric> collectedMetrics,
  });

  @override
  $WorkoutStateCopyWith<$Res> get workoutState;
  @override
  $WorkoutMetricCopyWith<$Res>? get currentMetric;
  @override
  $WorkoutParametersCopyWith<$Res> get workoutParameters;
  @override
  $RepCountCopyWith<$Res> get repCount;
  @override
  $RepRangesCopyWith<$Res>? get repRanges;
  @override
  $AutoStopUiStateCopyWith<$Res> get autoStopState;
  @override
  $RoutineCopyWith<$Res>? get loadedRoutine;
}

/// @nodoc
class __$$WorkoutSessionStateImplCopyWithImpl<$Res>
    extends _$WorkoutSessionStateCopyWithImpl<$Res, _$WorkoutSessionStateImpl>
    implements _$$WorkoutSessionStateImplCopyWith<$Res> {
  __$$WorkoutSessionStateImplCopyWithImpl(
    _$WorkoutSessionStateImpl _value,
    $Res Function(_$WorkoutSessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutState = null,
    Object? currentMetric = freezed,
    Object? workoutParameters = null,
    Object? repCount = null,
    Object? repRanges = freezed,
    Object? autoStopState = null,
    Object? autoStartCountdown = freezed,
    Object? loadedRoutine = freezed,
    Object? currentExerciseIndex = null,
    Object? currentSetIndex = null,
    Object? connectionLostDuringWorkout = null,
    Object? currentSessionId = freezed,
    Object? workoutStartTime = freezed,
    Object? collectedMetrics = null,
  }) {
    return _then(
      _$WorkoutSessionStateImpl(
        workoutState: null == workoutState
            ? _value.workoutState
            : workoutState // ignore: cast_nullable_to_non_nullable
                  as WorkoutState,
        currentMetric: freezed == currentMetric
            ? _value.currentMetric
            : currentMetric // ignore: cast_nullable_to_non_nullable
                  as WorkoutMetric?,
        workoutParameters: null == workoutParameters
            ? _value.workoutParameters
            : workoutParameters // ignore: cast_nullable_to_non_nullable
                  as WorkoutParameters,
        repCount: null == repCount
            ? _value.repCount
            : repCount // ignore: cast_nullable_to_non_nullable
                  as RepCount,
        repRanges: freezed == repRanges
            ? _value.repRanges
            : repRanges // ignore: cast_nullable_to_non_nullable
                  as RepRanges?,
        autoStopState: null == autoStopState
            ? _value.autoStopState
            : autoStopState // ignore: cast_nullable_to_non_nullable
                  as AutoStopUiState,
        autoStartCountdown: freezed == autoStartCountdown
            ? _value.autoStartCountdown
            : autoStartCountdown // ignore: cast_nullable_to_non_nullable
                  as int?,
        loadedRoutine: freezed == loadedRoutine
            ? _value.loadedRoutine
            : loadedRoutine // ignore: cast_nullable_to_non_nullable
                  as Routine?,
        currentExerciseIndex: null == currentExerciseIndex
            ? _value.currentExerciseIndex
            : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentSetIndex: null == currentSetIndex
            ? _value.currentSetIndex
            : currentSetIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        connectionLostDuringWorkout: null == connectionLostDuringWorkout
            ? _value.connectionLostDuringWorkout
            : connectionLostDuringWorkout // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentSessionId: freezed == currentSessionId
            ? _value.currentSessionId
            : currentSessionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        workoutStartTime: freezed == workoutStartTime
            ? _value.workoutStartTime
            : workoutStartTime // ignore: cast_nullable_to_non_nullable
                  as int?,
        collectedMetrics: null == collectedMetrics
            ? _value._collectedMetrics
            : collectedMetrics // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutMetric>,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutSessionStateImpl implements _WorkoutSessionState {
  const _$WorkoutSessionStateImpl({
    this.workoutState = const WorkoutState.idle(),
    this.currentMetric,
    required this.workoutParameters,
    this.repCount = const RepCount(),
    this.repRanges,
    this.autoStopState = const AutoStopUiState(),
    this.autoStartCountdown,
    this.loadedRoutine,
    this.currentExerciseIndex = 0,
    this.currentSetIndex = 0,
    this.connectionLostDuringWorkout = false,
    this.currentSessionId,
    this.workoutStartTime,
    final List<WorkoutMetric> collectedMetrics = const [],
  }) : _collectedMetrics = collectedMetrics;

  @override
  @JsonKey()
  final WorkoutState workoutState;
  @override
  final WorkoutMetric? currentMetric;
  @override
  final WorkoutParameters workoutParameters;
  @override
  @JsonKey()
  final RepCount repCount;
  @override
  final RepRanges? repRanges;
  @override
  @JsonKey()
  final AutoStopUiState autoStopState;
  @override
  final int? autoStartCountdown;
  @override
  final Routine? loadedRoutine;
  @override
  @JsonKey()
  final int currentExerciseIndex;
  @override
  @JsonKey()
  final int currentSetIndex;
  @override
  @JsonKey()
  final bool connectionLostDuringWorkout;
  // Internal state (not exposed in Kotlin but needed)
  @override
  final String? currentSessionId;
  @override
  final int? workoutStartTime;
  final List<WorkoutMetric> _collectedMetrics;
  @override
  @JsonKey()
  List<WorkoutMetric> get collectedMetrics {
    if (_collectedMetrics is EqualUnmodifiableListView)
      return _collectedMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectedMetrics);
  }

  @override
  String toString() {
    return 'WorkoutSessionState(workoutState: $workoutState, currentMetric: $currentMetric, workoutParameters: $workoutParameters, repCount: $repCount, repRanges: $repRanges, autoStopState: $autoStopState, autoStartCountdown: $autoStartCountdown, loadedRoutine: $loadedRoutine, currentExerciseIndex: $currentExerciseIndex, currentSetIndex: $currentSetIndex, connectionLostDuringWorkout: $connectionLostDuringWorkout, currentSessionId: $currentSessionId, workoutStartTime: $workoutStartTime, collectedMetrics: $collectedMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionStateImpl &&
            (identical(other.workoutState, workoutState) ||
                other.workoutState == workoutState) &&
            (identical(other.currentMetric, currentMetric) ||
                other.currentMetric == currentMetric) &&
            (identical(other.workoutParameters, workoutParameters) ||
                other.workoutParameters == workoutParameters) &&
            (identical(other.repCount, repCount) ||
                other.repCount == repCount) &&
            (identical(other.repRanges, repRanges) ||
                other.repRanges == repRanges) &&
            (identical(other.autoStopState, autoStopState) ||
                other.autoStopState == autoStopState) &&
            (identical(other.autoStartCountdown, autoStartCountdown) ||
                other.autoStartCountdown == autoStartCountdown) &&
            (identical(other.loadedRoutine, loadedRoutine) ||
                other.loadedRoutine == loadedRoutine) &&
            (identical(other.currentExerciseIndex, currentExerciseIndex) ||
                other.currentExerciseIndex == currentExerciseIndex) &&
            (identical(other.currentSetIndex, currentSetIndex) ||
                other.currentSetIndex == currentSetIndex) &&
            (identical(
                  other.connectionLostDuringWorkout,
                  connectionLostDuringWorkout,
                ) ||
                other.connectionLostDuringWorkout ==
                    connectionLostDuringWorkout) &&
            (identical(other.currentSessionId, currentSessionId) ||
                other.currentSessionId == currentSessionId) &&
            (identical(other.workoutStartTime, workoutStartTime) ||
                other.workoutStartTime == workoutStartTime) &&
            const DeepCollectionEquality().equals(
              other._collectedMetrics,
              _collectedMetrics,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    workoutState,
    currentMetric,
    workoutParameters,
    repCount,
    repRanges,
    autoStopState,
    autoStartCountdown,
    loadedRoutine,
    currentExerciseIndex,
    currentSetIndex,
    connectionLostDuringWorkout,
    currentSessionId,
    workoutStartTime,
    const DeepCollectionEquality().hash(_collectedMetrics),
  );

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionStateImplCopyWith<_$WorkoutSessionStateImpl> get copyWith =>
      __$$WorkoutSessionStateImplCopyWithImpl<_$WorkoutSessionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutSessionState implements WorkoutSessionState {
  const factory _WorkoutSessionState({
    final WorkoutState workoutState,
    final WorkoutMetric? currentMetric,
    required final WorkoutParameters workoutParameters,
    final RepCount repCount,
    final RepRanges? repRanges,
    final AutoStopUiState autoStopState,
    final int? autoStartCountdown,
    final Routine? loadedRoutine,
    final int currentExerciseIndex,
    final int currentSetIndex,
    final bool connectionLostDuringWorkout,
    final String? currentSessionId,
    final int? workoutStartTime,
    final List<WorkoutMetric> collectedMetrics,
  }) = _$WorkoutSessionStateImpl;

  @override
  WorkoutState get workoutState;
  @override
  WorkoutMetric? get currentMetric;
  @override
  WorkoutParameters get workoutParameters;
  @override
  RepCount get repCount;
  @override
  RepRanges? get repRanges;
  @override
  AutoStopUiState get autoStopState;
  @override
  int? get autoStartCountdown;
  @override
  Routine? get loadedRoutine;
  @override
  int get currentExerciseIndex;
  @override
  int get currentSetIndex;
  @override
  bool get connectionLostDuringWorkout; // Internal state (not exposed in Kotlin but needed)
  @override
  String? get currentSessionId;
  @override
  int? get workoutStartTime;
  @override
  List<WorkoutMetric> get collectedMetrics;

  /// Create a copy of WorkoutSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionStateImplCopyWith<_$WorkoutSessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
