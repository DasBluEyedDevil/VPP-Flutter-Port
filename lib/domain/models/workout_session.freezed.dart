// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get mode => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double get weightPerCableKg => throw _privateConstructorUsedError;
  double get progressionKg => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get totalReps => throw _privateConstructorUsedError;
  int get warmupReps => throw _privateConstructorUsedError;
  int get workingReps => throw _privateConstructorUsedError;
  bool get isJustLift => throw _privateConstructorUsedError;
  bool get stopAtTop =>
      throw _privateConstructorUsedError; // Echo mode configuration
  int get eccentricLoad =>
      throw _privateConstructorUsedError; // Percentage (0, 50, 75, 100, 125, 150)
  int get echoLevel =>
      throw _privateConstructorUsedError; // 1=Hard, 2=Harder, 3=Hardest, 4=Epic
  // Exercise tracking
  String? get exerciseId => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
    WorkoutSession value,
    $Res Function(WorkoutSession) then,
  ) = _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call({
    String id,
    int timestamp,
    String mode,
    int reps,
    double weightPerCableKg,
    double progressionKg,
    int duration,
    int totalReps,
    int warmupReps,
    int workingReps,
    bool isJustLift,
    bool stopAtTop,
    int eccentricLoad,
    int echoLevel,
    String? exerciseId,
  });
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? mode = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? progressionKg = null,
    Object? duration = null,
    Object? totalReps = null,
    Object? warmupReps = null,
    Object? workingReps = null,
    Object? isJustLift = null,
    Object? stopAtTop = null,
    Object? eccentricLoad = null,
    Object? echoLevel = null,
    Object? exerciseId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as String,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weightPerCableKg: null == weightPerCableKg
                ? _value.weightPerCableKg
                : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                      as double,
            progressionKg: null == progressionKg
                ? _value.progressionKg
                : progressionKg // ignore: cast_nullable_to_non_nullable
                      as double,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            totalReps: null == totalReps
                ? _value.totalReps
                : totalReps // ignore: cast_nullable_to_non_nullable
                      as int,
            warmupReps: null == warmupReps
                ? _value.warmupReps
                : warmupReps // ignore: cast_nullable_to_non_nullable
                      as int,
            workingReps: null == workingReps
                ? _value.workingReps
                : workingReps // ignore: cast_nullable_to_non_nullable
                      as int,
            isJustLift: null == isJustLift
                ? _value.isJustLift
                : isJustLift // ignore: cast_nullable_to_non_nullable
                      as bool,
            stopAtTop: null == stopAtTop
                ? _value.stopAtTop
                : stopAtTop // ignore: cast_nullable_to_non_nullable
                      as bool,
            eccentricLoad: null == eccentricLoad
                ? _value.eccentricLoad
                : eccentricLoad // ignore: cast_nullable_to_non_nullable
                      as int,
            echoLevel: null == echoLevel
                ? _value.echoLevel
                : echoLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseId: freezed == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(
    _$WorkoutSessionImpl value,
    $Res Function(_$WorkoutSessionImpl) then,
  ) = __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int timestamp,
    String mode,
    int reps,
    double weightPerCableKg,
    double progressionKg,
    int duration,
    int totalReps,
    int warmupReps,
    int workingReps,
    bool isJustLift,
    bool stopAtTop,
    int eccentricLoad,
    int echoLevel,
    String? exerciseId,
  });
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
    _$WorkoutSessionImpl _value,
    $Res Function(_$WorkoutSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? mode = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? progressionKg = null,
    Object? duration = null,
    Object? totalReps = null,
    Object? warmupReps = null,
    Object? workingReps = null,
    Object? isJustLift = null,
    Object? stopAtTop = null,
    Object? eccentricLoad = null,
    Object? echoLevel = null,
    Object? exerciseId = freezed,
  }) {
    return _then(
      _$WorkoutSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as String,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weightPerCableKg: null == weightPerCableKg
            ? _value.weightPerCableKg
            : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                  as double,
        progressionKg: null == progressionKg
            ? _value.progressionKg
            : progressionKg // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        totalReps: null == totalReps
            ? _value.totalReps
            : totalReps // ignore: cast_nullable_to_non_nullable
                  as int,
        warmupReps: null == warmupReps
            ? _value.warmupReps
            : warmupReps // ignore: cast_nullable_to_non_nullable
                  as int,
        workingReps: null == workingReps
            ? _value.workingReps
            : workingReps // ignore: cast_nullable_to_non_nullable
                  as int,
        isJustLift: null == isJustLift
            ? _value.isJustLift
            : isJustLift // ignore: cast_nullable_to_non_nullable
                  as bool,
        stopAtTop: null == stopAtTop
            ? _value.stopAtTop
            : stopAtTop // ignore: cast_nullable_to_non_nullable
                  as bool,
        eccentricLoad: null == eccentricLoad
            ? _value.eccentricLoad
            : eccentricLoad // ignore: cast_nullable_to_non_nullable
                  as int,
        echoLevel: null == echoLevel
            ? _value.echoLevel
            : echoLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseId: freezed == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl({
    this.id = '',
    this.timestamp = 0,
    this.mode = 'OldSchool',
    this.reps = 10,
    this.weightPerCableKg = 10.0,
    this.progressionKg = 0.0,
    this.duration = 0,
    this.totalReps = 0,
    this.warmupReps = 0,
    this.workingReps = 0,
    this.isJustLift = false,
    this.stopAtTop = false,
    this.eccentricLoad = 100,
    this.echoLevel = 2,
    this.exerciseId,
  });

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String mode;
  @override
  @JsonKey()
  final int reps;
  @override
  @JsonKey()
  final double weightPerCableKg;
  @override
  @JsonKey()
  final double progressionKg;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey()
  final int totalReps;
  @override
  @JsonKey()
  final int warmupReps;
  @override
  @JsonKey()
  final int workingReps;
  @override
  @JsonKey()
  final bool isJustLift;
  @override
  @JsonKey()
  final bool stopAtTop;
  // Echo mode configuration
  @override
  @JsonKey()
  final int eccentricLoad;
  // Percentage (0, 50, 75, 100, 125, 150)
  @override
  @JsonKey()
  final int echoLevel;
  // 1=Hard, 2=Harder, 3=Hardest, 4=Epic
  // Exercise tracking
  @override
  final String? exerciseId;

  @override
  String toString() {
    return 'WorkoutSession(id: $id, timestamp: $timestamp, mode: $mode, reps: $reps, weightPerCableKg: $weightPerCableKg, progressionKg: $progressionKg, duration: $duration, totalReps: $totalReps, warmupReps: $warmupReps, workingReps: $workingReps, isJustLift: $isJustLift, stopAtTop: $stopAtTop, eccentricLoad: $eccentricLoad, echoLevel: $echoLevel, exerciseId: $exerciseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightPerCableKg, weightPerCableKg) ||
                other.weightPerCableKg == weightPerCableKg) &&
            (identical(other.progressionKg, progressionKg) ||
                other.progressionKg == progressionKg) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalReps, totalReps) ||
                other.totalReps == totalReps) &&
            (identical(other.warmupReps, warmupReps) ||
                other.warmupReps == warmupReps) &&
            (identical(other.workingReps, workingReps) ||
                other.workingReps == workingReps) &&
            (identical(other.isJustLift, isJustLift) ||
                other.isJustLift == isJustLift) &&
            (identical(other.stopAtTop, stopAtTop) ||
                other.stopAtTop == stopAtTop) &&
            (identical(other.eccentricLoad, eccentricLoad) ||
                other.eccentricLoad == eccentricLoad) &&
            (identical(other.echoLevel, echoLevel) ||
                other.echoLevel == echoLevel) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    timestamp,
    mode,
    reps,
    weightPerCableKg,
    progressionKg,
    duration,
    totalReps,
    warmupReps,
    workingReps,
    isJustLift,
    stopAtTop,
    eccentricLoad,
    echoLevel,
    exerciseId,
  );

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession({
    final String id,
    final int timestamp,
    final String mode,
    final int reps,
    final double weightPerCableKg,
    final double progressionKg,
    final int duration,
    final int totalReps,
    final int warmupReps,
    final int workingReps,
    final bool isJustLift,
    final bool stopAtTop,
    final int eccentricLoad,
    final int echoLevel,
    final String? exerciseId,
  }) = _$WorkoutSessionImpl;

  @override
  String get id;
  @override
  int get timestamp;
  @override
  String get mode;
  @override
  int get reps;
  @override
  double get weightPerCableKg;
  @override
  double get progressionKg;
  @override
  int get duration;
  @override
  int get totalReps;
  @override
  int get warmupReps;
  @override
  int get workingReps;
  @override
  bool get isJustLift;
  @override
  bool get stopAtTop; // Echo mode configuration
  @override
  int get eccentricLoad; // Percentage (0, 50, 75, 100, 125, 150)
  @override
  int get echoLevel; // 1=Hard, 2=Harder, 3=Hardest, 4=Epic
  // Exercise tracking
  @override
  String? get exerciseId;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
