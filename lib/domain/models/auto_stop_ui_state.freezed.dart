// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_stop_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AutoStopUiState {
  bool get isActive => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError; // 0.0 to 1.0
  int get secondsRemaining => throw _privateConstructorUsedError;

  /// Create a copy of AutoStopUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AutoStopUiStateCopyWith<AutoStopUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoStopUiStateCopyWith<$Res> {
  factory $AutoStopUiStateCopyWith(
    AutoStopUiState value,
    $Res Function(AutoStopUiState) then,
  ) = _$AutoStopUiStateCopyWithImpl<$Res, AutoStopUiState>;
  @useResult
  $Res call({bool isActive, double progress, int secondsRemaining});
}

/// @nodoc
class _$AutoStopUiStateCopyWithImpl<$Res, $Val extends AutoStopUiState>
    implements $AutoStopUiStateCopyWith<$Res> {
  _$AutoStopUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AutoStopUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? progress = null,
    Object? secondsRemaining = null,
  }) {
    return _then(
      _value.copyWith(
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            secondsRemaining: null == secondsRemaining
                ? _value.secondsRemaining
                : secondsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AutoStopUiStateImplCopyWith<$Res>
    implements $AutoStopUiStateCopyWith<$Res> {
  factory _$$AutoStopUiStateImplCopyWith(
    _$AutoStopUiStateImpl value,
    $Res Function(_$AutoStopUiStateImpl) then,
  ) = __$$AutoStopUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isActive, double progress, int secondsRemaining});
}

/// @nodoc
class __$$AutoStopUiStateImplCopyWithImpl<$Res>
    extends _$AutoStopUiStateCopyWithImpl<$Res, _$AutoStopUiStateImpl>
    implements _$$AutoStopUiStateImplCopyWith<$Res> {
  __$$AutoStopUiStateImplCopyWithImpl(
    _$AutoStopUiStateImpl _value,
    $Res Function(_$AutoStopUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AutoStopUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? progress = null,
    Object? secondsRemaining = null,
  }) {
    return _then(
      _$AutoStopUiStateImpl(
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        secondsRemaining: null == secondsRemaining
            ? _value.secondsRemaining
            : secondsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AutoStopUiStateImpl implements _AutoStopUiState {
  const _$AutoStopUiStateImpl({
    this.isActive = false,
    this.progress = 0.0,
    this.secondsRemaining = 0,
  });

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final double progress;
  // 0.0 to 1.0
  @override
  @JsonKey()
  final int secondsRemaining;

  @override
  String toString() {
    return 'AutoStopUiState(isActive: $isActive, progress: $progress, secondsRemaining: $secondsRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoStopUiStateImpl &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isActive, progress, secondsRemaining);

  /// Create a copy of AutoStopUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoStopUiStateImplCopyWith<_$AutoStopUiStateImpl> get copyWith =>
      __$$AutoStopUiStateImplCopyWithImpl<_$AutoStopUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AutoStopUiState implements AutoStopUiState {
  const factory _AutoStopUiState({
    final bool isActive,
    final double progress,
    final int secondsRemaining,
  }) = _$AutoStopUiStateImpl;

  @override
  bool get isActive;
  @override
  double get progress; // 0.0 to 1.0
  @override
  int get secondsRemaining;

  /// Create a copy of AutoStopUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AutoStopUiStateImplCopyWith<_$AutoStopUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
