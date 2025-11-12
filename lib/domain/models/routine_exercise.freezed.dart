// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RoutineExercise {
  String get exerciseId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError; // Order within routine
  int get sets => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double get weightPerCableKg => throw _privateConstructorUsedError;
  ProgramMode get mode => throw _privateConstructorUsedError;
  EccentricLoad? get eccentricLoad =>
      throw _privateConstructorUsedError; // For Echo mode
  EchoLevel? get echoLevel =>
      throw _privateConstructorUsedError; // For Echo mode
  int get restSeconds => throw _privateConstructorUsedError;

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineExerciseCopyWith<RoutineExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineExerciseCopyWith<$Res> {
  factory $RoutineExerciseCopyWith(
    RoutineExercise value,
    $Res Function(RoutineExercise) then,
  ) = _$RoutineExerciseCopyWithImpl<$Res, RoutineExercise>;
  @useResult
  $Res call({
    String exerciseId,
    int order,
    int sets,
    int reps,
    double weightPerCableKg,
    ProgramMode mode,
    EccentricLoad? eccentricLoad,
    EchoLevel? echoLevel,
    int restSeconds,
  });

  $ProgramModeCopyWith<$Res> get mode;
}

/// @nodoc
class _$RoutineExerciseCopyWithImpl<$Res, $Val extends RoutineExercise>
    implements $RoutineExerciseCopyWith<$Res> {
  _$RoutineExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? order = null,
    Object? sets = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? mode = null,
    Object? eccentricLoad = freezed,
    Object? echoLevel = freezed,
    Object? restSeconds = null,
  }) {
    return _then(
      _value.copyWith(
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weightPerCableKg: null == weightPerCableKg
                ? _value.weightPerCableKg
                : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                      as double,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as ProgramMode,
            eccentricLoad: freezed == eccentricLoad
                ? _value.eccentricLoad
                : eccentricLoad // ignore: cast_nullable_to_non_nullable
                      as EccentricLoad?,
            echoLevel: freezed == echoLevel
                ? _value.echoLevel
                : echoLevel // ignore: cast_nullable_to_non_nullable
                      as EchoLevel?,
            restSeconds: null == restSeconds
                ? _value.restSeconds
                : restSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgramModeCopyWith<$Res> get mode {
    return $ProgramModeCopyWith<$Res>(_value.mode, (value) {
      return _then(_value.copyWith(mode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoutineExerciseImplCopyWith<$Res>
    implements $RoutineExerciseCopyWith<$Res> {
  factory _$$RoutineExerciseImplCopyWith(
    _$RoutineExerciseImpl value,
    $Res Function(_$RoutineExerciseImpl) then,
  ) = __$$RoutineExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String exerciseId,
    int order,
    int sets,
    int reps,
    double weightPerCableKg,
    ProgramMode mode,
    EccentricLoad? eccentricLoad,
    EchoLevel? echoLevel,
    int restSeconds,
  });

  @override
  $ProgramModeCopyWith<$Res> get mode;
}

/// @nodoc
class __$$RoutineExerciseImplCopyWithImpl<$Res>
    extends _$RoutineExerciseCopyWithImpl<$Res, _$RoutineExerciseImpl>
    implements _$$RoutineExerciseImplCopyWith<$Res> {
  __$$RoutineExerciseImplCopyWithImpl(
    _$RoutineExerciseImpl _value,
    $Res Function(_$RoutineExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? order = null,
    Object? sets = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? mode = null,
    Object? eccentricLoad = freezed,
    Object? echoLevel = freezed,
    Object? restSeconds = null,
  }) {
    return _then(
      _$RoutineExerciseImpl(
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weightPerCableKg: null == weightPerCableKg
            ? _value.weightPerCableKg
            : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                  as double,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as ProgramMode,
        eccentricLoad: freezed == eccentricLoad
            ? _value.eccentricLoad
            : eccentricLoad // ignore: cast_nullable_to_non_nullable
                  as EccentricLoad?,
        echoLevel: freezed == echoLevel
            ? _value.echoLevel
            : echoLevel // ignore: cast_nullable_to_non_nullable
                  as EchoLevel?,
        restSeconds: null == restSeconds
            ? _value.restSeconds
            : restSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RoutineExerciseImpl implements _RoutineExercise {
  const _$RoutineExerciseImpl({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.reps,
    required this.weightPerCableKg,
    required this.mode,
    this.eccentricLoad,
    this.echoLevel,
    this.restSeconds = 90,
  });

  @override
  final String exerciseId;
  @override
  final int order;
  // Order within routine
  @override
  final int sets;
  @override
  final int reps;
  @override
  final double weightPerCableKg;
  @override
  final ProgramMode mode;
  @override
  final EccentricLoad? eccentricLoad;
  // For Echo mode
  @override
  final EchoLevel? echoLevel;
  // For Echo mode
  @override
  @JsonKey()
  final int restSeconds;

  @override
  String toString() {
    return 'RoutineExercise(exerciseId: $exerciseId, order: $order, sets: $sets, reps: $reps, weightPerCableKg: $weightPerCableKg, mode: $mode, eccentricLoad: $eccentricLoad, echoLevel: $echoLevel, restSeconds: $restSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineExerciseImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightPerCableKg, weightPerCableKg) ||
                other.weightPerCableKg == weightPerCableKg) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.eccentricLoad, eccentricLoad) ||
                other.eccentricLoad == eccentricLoad) &&
            (identical(other.echoLevel, echoLevel) ||
                other.echoLevel == echoLevel) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    exerciseId,
    order,
    sets,
    reps,
    weightPerCableKg,
    mode,
    eccentricLoad,
    echoLevel,
    restSeconds,
  );

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineExerciseImplCopyWith<_$RoutineExerciseImpl> get copyWith =>
      __$$RoutineExerciseImplCopyWithImpl<_$RoutineExerciseImpl>(
        this,
        _$identity,
      );
}

abstract class _RoutineExercise implements RoutineExercise {
  const factory _RoutineExercise({
    required final String exerciseId,
    required final int order,
    required final int sets,
    required final int reps,
    required final double weightPerCableKg,
    required final ProgramMode mode,
    final EccentricLoad? eccentricLoad,
    final EchoLevel? echoLevel,
    final int restSeconds,
  }) = _$RoutineExerciseImpl;

  @override
  String get exerciseId;
  @override
  int get order; // Order within routine
  @override
  int get sets;
  @override
  int get reps;
  @override
  double get weightPerCableKg;
  @override
  ProgramMode get mode;
  @override
  EccentricLoad? get eccentricLoad; // For Echo mode
  @override
  EchoLevel? get echoLevel; // For Echo mode
  @override
  int get restSeconds;

  /// Create a copy of RoutineExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineExerciseImplCopyWith<_$RoutineExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
