// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgramMode mode) program,
    required TResult Function(EchoLevel level, EccentricLoad eccentricLoad)
    echo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgramMode mode)? program,
    TResult? Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgramMode mode)? program,
    TResult Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Program value) program,
    required TResult Function(Echo value) echo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Program value)? program,
    TResult? Function(Echo value)? echo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Program value)? program,
    TResult Function(Echo value)? echo,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutTypeCopyWith<$Res> {
  factory $WorkoutTypeCopyWith(
    WorkoutType value,
    $Res Function(WorkoutType) then,
  ) = _$WorkoutTypeCopyWithImpl<$Res, WorkoutType>;
}

/// @nodoc
class _$WorkoutTypeCopyWithImpl<$Res, $Val extends WorkoutType>
    implements $WorkoutTypeCopyWith<$Res> {
  _$WorkoutTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProgramImplCopyWith<$Res> {
  factory _$$ProgramImplCopyWith(
    _$ProgramImpl value,
    $Res Function(_$ProgramImpl) then,
  ) = __$$ProgramImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgramMode mode});

  $ProgramModeCopyWith<$Res> get mode;
}

/// @nodoc
class __$$ProgramImplCopyWithImpl<$Res>
    extends _$WorkoutTypeCopyWithImpl<$Res, _$ProgramImpl>
    implements _$$ProgramImplCopyWith<$Res> {
  __$$ProgramImplCopyWithImpl(
    _$ProgramImpl _value,
    $Res Function(_$ProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mode = null}) {
    return _then(
      _$ProgramImpl(
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as ProgramMode,
      ),
    );
  }

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgramModeCopyWith<$Res> get mode {
    return $ProgramModeCopyWith<$Res>(_value.mode, (value) {
      return _then(_value.copyWith(mode: value));
    });
  }
}

/// @nodoc

class _$ProgramImpl extends Program {
  const _$ProgramImpl({required this.mode}) : super._();

  @override
  final ProgramMode mode;

  @override
  String toString() {
    return 'WorkoutType.program(mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramImpl &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      __$$ProgramImplCopyWithImpl<_$ProgramImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgramMode mode) program,
    required TResult Function(EchoLevel level, EccentricLoad eccentricLoad)
    echo,
  }) {
    return program(mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgramMode mode)? program,
    TResult? Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
  }) {
    return program?.call(mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgramMode mode)? program,
    TResult Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
    required TResult orElse(),
  }) {
    if (program != null) {
      return program(mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Program value) program,
    required TResult Function(Echo value) echo,
  }) {
    return program(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Program value)? program,
    TResult? Function(Echo value)? echo,
  }) {
    return program?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Program value)? program,
    TResult Function(Echo value)? echo,
    required TResult orElse(),
  }) {
    if (program != null) {
      return program(this);
    }
    return orElse();
  }
}

abstract class Program extends WorkoutType {
  const factory Program({required final ProgramMode mode}) = _$ProgramImpl;
  const Program._() : super._();

  ProgramMode get mode;

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EchoImplCopyWith<$Res> {
  factory _$$EchoImplCopyWith(
    _$EchoImpl value,
    $Res Function(_$EchoImpl) then,
  ) = __$$EchoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EchoLevel level, EccentricLoad eccentricLoad});
}

/// @nodoc
class __$$EchoImplCopyWithImpl<$Res>
    extends _$WorkoutTypeCopyWithImpl<$Res, _$EchoImpl>
    implements _$$EchoImplCopyWith<$Res> {
  __$$EchoImplCopyWithImpl(_$EchoImpl _value, $Res Function(_$EchoImpl) _then)
    : super(_value, _then);

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? level = null, Object? eccentricLoad = null}) {
    return _then(
      _$EchoImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as EchoLevel,
        eccentricLoad: null == eccentricLoad
            ? _value.eccentricLoad
            : eccentricLoad // ignore: cast_nullable_to_non_nullable
                  as EccentricLoad,
      ),
    );
  }
}

/// @nodoc

class _$EchoImpl extends Echo {
  const _$EchoImpl({required this.level, required this.eccentricLoad})
    : super._();

  @override
  final EchoLevel level;
  @override
  final EccentricLoad eccentricLoad;

  @override
  String toString() {
    return 'WorkoutType.echo(level: $level, eccentricLoad: $eccentricLoad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EchoImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.eccentricLoad, eccentricLoad) ||
                other.eccentricLoad == eccentricLoad));
  }

  @override
  int get hashCode => Object.hash(runtimeType, level, eccentricLoad);

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EchoImplCopyWith<_$EchoImpl> get copyWith =>
      __$$EchoImplCopyWithImpl<_$EchoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgramMode mode) program,
    required TResult Function(EchoLevel level, EccentricLoad eccentricLoad)
    echo,
  }) {
    return echo(level, eccentricLoad);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgramMode mode)? program,
    TResult? Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
  }) {
    return echo?.call(level, eccentricLoad);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgramMode mode)? program,
    TResult Function(EchoLevel level, EccentricLoad eccentricLoad)? echo,
    required TResult orElse(),
  }) {
    if (echo != null) {
      return echo(level, eccentricLoad);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Program value) program,
    required TResult Function(Echo value) echo,
  }) {
    return echo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Program value)? program,
    TResult? Function(Echo value)? echo,
  }) {
    return echo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Program value)? program,
    TResult Function(Echo value)? echo,
    required TResult orElse(),
  }) {
    if (echo != null) {
      return echo(this);
    }
    return orElse();
  }
}

abstract class Echo extends WorkoutType {
  const factory Echo({
    required final EchoLevel level,
    required final EccentricLoad eccentricLoad,
  }) = _$EchoImpl;
  const Echo._() : super._();

  EchoLevel get level;
  EccentricLoad get eccentricLoad;

  /// Create a copy of WorkoutType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EchoImplCopyWith<_$EchoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
