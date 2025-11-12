// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProgramDay {
  int get id => throw _privateConstructorUsedError;
  String get programId => throw _privateConstructorUsedError;
  String get routineId => throw _privateConstructorUsedError;
  int get dayOfWeek => throw _privateConstructorUsedError;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramDayCopyWith<ProgramDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramDayCopyWith<$Res> {
  factory $ProgramDayCopyWith(
    ProgramDay value,
    $Res Function(ProgramDay) then,
  ) = _$ProgramDayCopyWithImpl<$Res, ProgramDay>;
  @useResult
  $Res call({int id, String programId, String routineId, int dayOfWeek});
}

/// @nodoc
class _$ProgramDayCopyWithImpl<$Res, $Val extends ProgramDay>
    implements $ProgramDayCopyWith<$Res> {
  _$ProgramDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programId = null,
    Object? routineId = null,
    Object? dayOfWeek = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            programId: null == programId
                ? _value.programId
                : programId // ignore: cast_nullable_to_non_nullable
                      as String,
            routineId: null == routineId
                ? _value.routineId
                : routineId // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramDayImplCopyWith<$Res>
    implements $ProgramDayCopyWith<$Res> {
  factory _$$ProgramDayImplCopyWith(
    _$ProgramDayImpl value,
    $Res Function(_$ProgramDayImpl) then,
  ) = __$$ProgramDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String programId, String routineId, int dayOfWeek});
}

/// @nodoc
class __$$ProgramDayImplCopyWithImpl<$Res>
    extends _$ProgramDayCopyWithImpl<$Res, _$ProgramDayImpl>
    implements _$$ProgramDayImplCopyWith<$Res> {
  __$$ProgramDayImplCopyWithImpl(
    _$ProgramDayImpl _value,
    $Res Function(_$ProgramDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? programId = null,
    Object? routineId = null,
    Object? dayOfWeek = null,
  }) {
    return _then(
      _$ProgramDayImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        programId: null == programId
            ? _value.programId
            : programId // ignore: cast_nullable_to_non_nullable
                  as String,
        routineId: null == routineId
            ? _value.routineId
            : routineId // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ProgramDayImpl implements _ProgramDay {
  const _$ProgramDayImpl({
    required this.id,
    required this.programId,
    required this.routineId,
    required this.dayOfWeek,
  });

  @override
  final int id;
  @override
  final String programId;
  @override
  final String routineId;
  @override
  final int dayOfWeek;

  @override
  String toString() {
    return 'ProgramDay(id: $id, programId: $programId, routineId: $routineId, dayOfWeek: $dayOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
            (identical(other.routineId, routineId) ||
                other.routineId == routineId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, programId, routineId, dayOfWeek);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      __$$ProgramDayImplCopyWithImpl<_$ProgramDayImpl>(this, _$identity);
}

abstract class _ProgramDay implements ProgramDay {
  const factory _ProgramDay({
    required final int id,
    required final String programId,
    required final String routineId,
    required final int dayOfWeek,
  }) = _$ProgramDayImpl;

  @override
  int get id;
  @override
  String get programId;
  @override
  String get routineId;
  @override
  int get dayOfWeek;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
