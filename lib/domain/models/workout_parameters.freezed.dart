// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutParameters {
  WorkoutType get workoutType => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double get weightPerCableKg =>
      throw _privateConstructorUsedError; // Only used for Program modes
  double get progressionRegressionKg =>
      throw _privateConstructorUsedError; // Only used for Program modes (not TUT/TUTBeast)
  bool get isJustLift => throw _privateConstructorUsedError;
  bool get useAutoStart =>
      throw _privateConstructorUsedError; // true for Just Lift, false for others
  bool get stopAtTop =>
      throw _privateConstructorUsedError; // false = stop at bottom (extended), true = stop at top (contracted)
  int get warmupReps => throw _privateConstructorUsedError;
  String? get selectedExerciseId => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutParametersCopyWith<WorkoutParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutParametersCopyWith<$Res> {
  factory $WorkoutParametersCopyWith(
    WorkoutParameters value,
    $Res Function(WorkoutParameters) then,
  ) = _$WorkoutParametersCopyWithImpl<$Res, WorkoutParameters>;
  @useResult
  $Res call({
    WorkoutType workoutType,
    int reps,
    double weightPerCableKg,
    double progressionRegressionKg,
    bool isJustLift,
    bool useAutoStart,
    bool stopAtTop,
    int warmupReps,
    String? selectedExerciseId,
  });

  $WorkoutTypeCopyWith<$Res> get workoutType;
}

/// @nodoc
class _$WorkoutParametersCopyWithImpl<$Res, $Val extends WorkoutParameters>
    implements $WorkoutParametersCopyWith<$Res> {
  _$WorkoutParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? progressionRegressionKg = null,
    Object? isJustLift = null,
    Object? useAutoStart = null,
    Object? stopAtTop = null,
    Object? warmupReps = null,
    Object? selectedExerciseId = freezed,
  }) {
    return _then(
      _value.copyWith(
            workoutType: null == workoutType
                ? _value.workoutType
                : workoutType // ignore: cast_nullable_to_non_nullable
                      as WorkoutType,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weightPerCableKg: null == weightPerCableKg
                ? _value.weightPerCableKg
                : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                      as double,
            progressionRegressionKg: null == progressionRegressionKg
                ? _value.progressionRegressionKg
                : progressionRegressionKg // ignore: cast_nullable_to_non_nullable
                      as double,
            isJustLift: null == isJustLift
                ? _value.isJustLift
                : isJustLift // ignore: cast_nullable_to_non_nullable
                      as bool,
            useAutoStart: null == useAutoStart
                ? _value.useAutoStart
                : useAutoStart // ignore: cast_nullable_to_non_nullable
                      as bool,
            stopAtTop: null == stopAtTop
                ? _value.stopAtTop
                : stopAtTop // ignore: cast_nullable_to_non_nullable
                      as bool,
            warmupReps: null == warmupReps
                ? _value.warmupReps
                : warmupReps // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedExerciseId: freezed == selectedExerciseId
                ? _value.selectedExerciseId
                : selectedExerciseId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutTypeCopyWith<$Res> get workoutType {
    return $WorkoutTypeCopyWith<$Res>(_value.workoutType, (value) {
      return _then(_value.copyWith(workoutType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutParametersImplCopyWith<$Res>
    implements $WorkoutParametersCopyWith<$Res> {
  factory _$$WorkoutParametersImplCopyWith(
    _$WorkoutParametersImpl value,
    $Res Function(_$WorkoutParametersImpl) then,
  ) = __$$WorkoutParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutType workoutType,
    int reps,
    double weightPerCableKg,
    double progressionRegressionKg,
    bool isJustLift,
    bool useAutoStart,
    bool stopAtTop,
    int warmupReps,
    String? selectedExerciseId,
  });

  @override
  $WorkoutTypeCopyWith<$Res> get workoutType;
}

/// @nodoc
class __$$WorkoutParametersImplCopyWithImpl<$Res>
    extends _$WorkoutParametersCopyWithImpl<$Res, _$WorkoutParametersImpl>
    implements _$$WorkoutParametersImplCopyWith<$Res> {
  __$$WorkoutParametersImplCopyWithImpl(
    _$WorkoutParametersImpl _value,
    $Res Function(_$WorkoutParametersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workoutType = null,
    Object? reps = null,
    Object? weightPerCableKg = null,
    Object? progressionRegressionKg = null,
    Object? isJustLift = null,
    Object? useAutoStart = null,
    Object? stopAtTop = null,
    Object? warmupReps = null,
    Object? selectedExerciseId = freezed,
  }) {
    return _then(
      _$WorkoutParametersImpl(
        workoutType: null == workoutType
            ? _value.workoutType
            : workoutType // ignore: cast_nullable_to_non_nullable
                  as WorkoutType,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weightPerCableKg: null == weightPerCableKg
            ? _value.weightPerCableKg
            : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                  as double,
        progressionRegressionKg: null == progressionRegressionKg
            ? _value.progressionRegressionKg
            : progressionRegressionKg // ignore: cast_nullable_to_non_nullable
                  as double,
        isJustLift: null == isJustLift
            ? _value.isJustLift
            : isJustLift // ignore: cast_nullable_to_non_nullable
                  as bool,
        useAutoStart: null == useAutoStart
            ? _value.useAutoStart
            : useAutoStart // ignore: cast_nullable_to_non_nullable
                  as bool,
        stopAtTop: null == stopAtTop
            ? _value.stopAtTop
            : stopAtTop // ignore: cast_nullable_to_non_nullable
                  as bool,
        warmupReps: null == warmupReps
            ? _value.warmupReps
            : warmupReps // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedExerciseId: freezed == selectedExerciseId
            ? _value.selectedExerciseId
            : selectedExerciseId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutParametersImpl implements _WorkoutParameters {
  const _$WorkoutParametersImpl({
    required this.workoutType,
    required this.reps,
    this.weightPerCableKg = 0.0,
    this.progressionRegressionKg = 0.0,
    this.isJustLift = false,
    this.useAutoStart = false,
    this.stopAtTop = false,
    this.warmupReps = 3,
    this.selectedExerciseId,
  });

  @override
  final WorkoutType workoutType;
  @override
  final int reps;
  @override
  @JsonKey()
  final double weightPerCableKg;
  // Only used for Program modes
  @override
  @JsonKey()
  final double progressionRegressionKg;
  // Only used for Program modes (not TUT/TUTBeast)
  @override
  @JsonKey()
  final bool isJustLift;
  @override
  @JsonKey()
  final bool useAutoStart;
  // true for Just Lift, false for others
  @override
  @JsonKey()
  final bool stopAtTop;
  // false = stop at bottom (extended), true = stop at top (contracted)
  @override
  @JsonKey()
  final int warmupReps;
  @override
  final String? selectedExerciseId;

  @override
  String toString() {
    return 'WorkoutParameters(workoutType: $workoutType, reps: $reps, weightPerCableKg: $weightPerCableKg, progressionRegressionKg: $progressionRegressionKg, isJustLift: $isJustLift, useAutoStart: $useAutoStart, stopAtTop: $stopAtTop, warmupReps: $warmupReps, selectedExerciseId: $selectedExerciseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutParametersImpl &&
            (identical(other.workoutType, workoutType) ||
                other.workoutType == workoutType) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightPerCableKg, weightPerCableKg) ||
                other.weightPerCableKg == weightPerCableKg) &&
            (identical(
                  other.progressionRegressionKg,
                  progressionRegressionKg,
                ) ||
                other.progressionRegressionKg == progressionRegressionKg) &&
            (identical(other.isJustLift, isJustLift) ||
                other.isJustLift == isJustLift) &&
            (identical(other.useAutoStart, useAutoStart) ||
                other.useAutoStart == useAutoStart) &&
            (identical(other.stopAtTop, stopAtTop) ||
                other.stopAtTop == stopAtTop) &&
            (identical(other.warmupReps, warmupReps) ||
                other.warmupReps == warmupReps) &&
            (identical(other.selectedExerciseId, selectedExerciseId) ||
                other.selectedExerciseId == selectedExerciseId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    workoutType,
    reps,
    weightPerCableKg,
    progressionRegressionKg,
    isJustLift,
    useAutoStart,
    stopAtTop,
    warmupReps,
    selectedExerciseId,
  );

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutParametersImplCopyWith<_$WorkoutParametersImpl> get copyWith =>
      __$$WorkoutParametersImplCopyWithImpl<_$WorkoutParametersImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutParameters implements WorkoutParameters {
  const factory _WorkoutParameters({
    required final WorkoutType workoutType,
    required final int reps,
    final double weightPerCableKg,
    final double progressionRegressionKg,
    final bool isJustLift,
    final bool useAutoStart,
    final bool stopAtTop,
    final int warmupReps,
    final String? selectedExerciseId,
  }) = _$WorkoutParametersImpl;

  @override
  WorkoutType get workoutType;
  @override
  int get reps;
  @override
  double get weightPerCableKg; // Only used for Program modes
  @override
  double get progressionRegressionKg; // Only used for Program modes (not TUT/TUTBeast)
  @override
  bool get isJustLift;
  @override
  bool get useAutoStart; // true for Just Lift, false for others
  @override
  bool get stopAtTop; // false = stop at bottom (extended), true = stop at top (contracted)
  @override
  int get warmupReps;
  @override
  String? get selectedExerciseId;

  /// Create a copy of WorkoutParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutParametersImplCopyWith<_$WorkoutParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
