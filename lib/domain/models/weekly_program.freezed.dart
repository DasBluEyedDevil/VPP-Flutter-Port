// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeeklyProgram {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastUsed => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyProgramCopyWith<WeeklyProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyProgramCopyWith<$Res> {
  factory $WeeklyProgramCopyWith(
    WeeklyProgram value,
    $Res Function(WeeklyProgram) then,
  ) = _$WeeklyProgramCopyWithImpl<$Res, WeeklyProgram>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    DateTime lastUsed,
    bool isActive,
  });
}

/// @nodoc
class _$WeeklyProgramCopyWithImpl<$Res, $Val extends WeeklyProgram>
    implements $WeeklyProgramCopyWith<$Res> {
  _$WeeklyProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? lastUsed = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastUsed: null == lastUsed
                ? _value.lastUsed
                : lastUsed // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklyProgramImplCopyWith<$Res>
    implements $WeeklyProgramCopyWith<$Res> {
  factory _$$WeeklyProgramImplCopyWith(
    _$WeeklyProgramImpl value,
    $Res Function(_$WeeklyProgramImpl) then,
  ) = __$$WeeklyProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    DateTime lastUsed,
    bool isActive,
  });
}

/// @nodoc
class __$$WeeklyProgramImplCopyWithImpl<$Res>
    extends _$WeeklyProgramCopyWithImpl<$Res, _$WeeklyProgramImpl>
    implements _$$WeeklyProgramImplCopyWith<$Res> {
  __$$WeeklyProgramImplCopyWithImpl(
    _$WeeklyProgramImpl _value,
    $Res Function(_$WeeklyProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? lastUsed = null,
    Object? isActive = null,
  }) {
    return _then(
      _$WeeklyProgramImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastUsed: null == lastUsed
            ? _value.lastUsed
            : lastUsed // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WeeklyProgramImpl implements _WeeklyProgram {
  const _$WeeklyProgramImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lastUsed,
    required this.isActive,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastUsed;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'WeeklyProgram(id: $id, name: $name, createdAt: $createdAt, lastUsed: $lastUsed, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, createdAt, lastUsed, isActive);

  /// Create a copy of WeeklyProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyProgramImplCopyWith<_$WeeklyProgramImpl> get copyWith =>
      __$$WeeklyProgramImplCopyWithImpl<_$WeeklyProgramImpl>(this, _$identity);
}

abstract class _WeeklyProgram implements WeeklyProgram {
  const factory _WeeklyProgram({
    required final String id,
    required final String name,
    required final DateTime createdAt,
    required final DateTime lastUsed,
    required final bool isActive,
  }) = _$WeeklyProgramImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastUsed;
  @override
  bool get isActive;

  /// Create a copy of WeeklyProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyProgramImplCopyWith<_$WeeklyProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
