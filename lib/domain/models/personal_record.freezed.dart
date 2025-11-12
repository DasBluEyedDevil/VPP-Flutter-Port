// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PersonalRecord {
  int get id => throw _privateConstructorUsedError;
  String get exerciseId => throw _privateConstructorUsedError;
  double get weightPerCableKg => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get workoutMode => throw _privateConstructorUsedError;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalRecordCopyWith<PersonalRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalRecordCopyWith<$Res> {
  factory $PersonalRecordCopyWith(
    PersonalRecord value,
    $Res Function(PersonalRecord) then,
  ) = _$PersonalRecordCopyWithImpl<$Res, PersonalRecord>;
  @useResult
  $Res call({
    int id,
    String exerciseId,
    double weightPerCableKg,
    int reps,
    int timestamp,
    String workoutMode,
  });
}

/// @nodoc
class _$PersonalRecordCopyWithImpl<$Res, $Val extends PersonalRecord>
    implements $PersonalRecordCopyWith<$Res> {
  _$PersonalRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? weightPerCableKg = null,
    Object? reps = null,
    Object? timestamp = null,
    Object? workoutMode = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String,
            weightPerCableKg: null == weightPerCableKg
                ? _value.weightPerCableKg
                : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                      as double,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            workoutMode: null == workoutMode
                ? _value.workoutMode
                : workoutMode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PersonalRecordImplCopyWith<$Res>
    implements $PersonalRecordCopyWith<$Res> {
  factory _$$PersonalRecordImplCopyWith(
    _$PersonalRecordImpl value,
    $Res Function(_$PersonalRecordImpl) then,
  ) = __$$PersonalRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String exerciseId,
    double weightPerCableKg,
    int reps,
    int timestamp,
    String workoutMode,
  });
}

/// @nodoc
class __$$PersonalRecordImplCopyWithImpl<$Res>
    extends _$PersonalRecordCopyWithImpl<$Res, _$PersonalRecordImpl>
    implements _$$PersonalRecordImplCopyWith<$Res> {
  __$$PersonalRecordImplCopyWithImpl(
    _$PersonalRecordImpl _value,
    $Res Function(_$PersonalRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? weightPerCableKg = null,
    Object? reps = null,
    Object? timestamp = null,
    Object? workoutMode = null,
  }) {
    return _then(
      _$PersonalRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String,
        weightPerCableKg: null == weightPerCableKg
            ? _value.weightPerCableKg
            : weightPerCableKg // ignore: cast_nullable_to_non_nullable
                  as double,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        workoutMode: null == workoutMode
            ? _value.workoutMode
            : workoutMode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PersonalRecordImpl implements _PersonalRecord {
  const _$PersonalRecordImpl({
    this.id = 0,
    required this.exerciseId,
    required this.weightPerCableKg,
    required this.reps,
    required this.timestamp,
    required this.workoutMode,
  });

  @override
  @JsonKey()
  final int id;
  @override
  final String exerciseId;
  @override
  final double weightPerCableKg;
  @override
  final int reps;
  @override
  final int timestamp;
  @override
  final String workoutMode;

  @override
  String toString() {
    return 'PersonalRecord(id: $id, exerciseId: $exerciseId, weightPerCableKg: $weightPerCableKg, reps: $reps, timestamp: $timestamp, workoutMode: $workoutMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.weightPerCableKg, weightPerCableKg) ||
                other.weightPerCableKg == weightPerCableKg) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.workoutMode, workoutMode) ||
                other.workoutMode == workoutMode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    exerciseId,
    weightPerCableKg,
    reps,
    timestamp,
    workoutMode,
  );

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalRecordImplCopyWith<_$PersonalRecordImpl> get copyWith =>
      __$$PersonalRecordImplCopyWithImpl<_$PersonalRecordImpl>(
        this,
        _$identity,
      );
}

abstract class _PersonalRecord implements PersonalRecord {
  const factory _PersonalRecord({
    final int id,
    required final String exerciseId,
    required final double weightPerCableKg,
    required final int reps,
    required final int timestamp,
    required final String workoutMode,
  }) = _$PersonalRecordImpl;

  @override
  int get id;
  @override
  String get exerciseId;
  @override
  double get weightPerCableKg;
  @override
  int get reps;
  @override
  int get timestamp;
  @override
  String get workoutMode;

  /// Create a copy of PersonalRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalRecordImplCopyWith<_$PersonalRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
