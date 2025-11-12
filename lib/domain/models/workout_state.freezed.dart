// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutStateCopyWith<$Res> {
  factory $WorkoutStateCopyWith(
    WorkoutState value,
    $Res Function(WorkoutState) then,
  ) = _$WorkoutStateCopyWithImpl<$Res, WorkoutState>;
}

/// @nodoc
class _$WorkoutStateCopyWithImpl<$Res, $Val extends WorkoutState>
    implements $WorkoutStateCopyWith<$Res> {
  _$WorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
    _$IdleImpl value,
    $Res Function(_$IdleImpl) then,
  ) = __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
    : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'WorkoutState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements WorkoutState {
  const factory Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$InitializingImplCopyWith<$Res> {
  factory _$$InitializingImplCopyWith(
    _$InitializingImpl value,
    $Res Function(_$InitializingImpl) then,
  ) = __$$InitializingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializingImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$InitializingImpl>
    implements _$$InitializingImplCopyWith<$Res> {
  __$$InitializingImplCopyWithImpl(
    _$InitializingImpl _value,
    $Res Function(_$InitializingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializingImpl implements Initializing {
  const _$InitializingImpl();

  @override
  String toString() {
    return 'WorkoutState.initializing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitializingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class Initializing implements WorkoutState {
  const factory Initializing() = _$InitializingImpl;
}

/// @nodoc
abstract class _$$CountdownImplCopyWith<$Res> {
  factory _$$CountdownImplCopyWith(
    _$CountdownImpl value,
    $Res Function(_$CountdownImpl) then,
  ) = __$$CountdownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int secondsRemaining});
}

/// @nodoc
class __$$CountdownImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$CountdownImpl>
    implements _$$CountdownImplCopyWith<$Res> {
  __$$CountdownImplCopyWithImpl(
    _$CountdownImpl _value,
    $Res Function(_$CountdownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? secondsRemaining = null}) {
    return _then(
      _$CountdownImpl(
        secondsRemaining: null == secondsRemaining
            ? _value.secondsRemaining
            : secondsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CountdownImpl implements Countdown {
  const _$CountdownImpl({required this.secondsRemaining});

  @override
  final int secondsRemaining;

  @override
  String toString() {
    return 'WorkoutState.countdown(secondsRemaining: $secondsRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountdownImpl &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining));
  }

  @override
  int get hashCode => Object.hash(runtimeType, secondsRemaining);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountdownImplCopyWith<_$CountdownImpl> get copyWith =>
      __$$CountdownImplCopyWithImpl<_$CountdownImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return countdown(secondsRemaining);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return countdown?.call(secondsRemaining);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (countdown != null) {
      return countdown(secondsRemaining);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return countdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return countdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (countdown != null) {
      return countdown(this);
    }
    return orElse();
  }
}

abstract class Countdown implements WorkoutState {
  const factory Countdown({required final int secondsRemaining}) =
      _$CountdownImpl;

  int get secondsRemaining;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountdownImplCopyWith<_$CountdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveImplCopyWith<$Res> {
  factory _$$ActiveImplCopyWith(
    _$ActiveImpl value,
    $Res Function(_$ActiveImpl) then,
  ) = __$$ActiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$ActiveImpl>
    implements _$$ActiveImplCopyWith<$Res> {
  __$$ActiveImplCopyWithImpl(
    _$ActiveImpl _value,
    $Res Function(_$ActiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActiveImpl implements Active {
  const _$ActiveImpl();

  @override
  String toString() {
    return 'WorkoutState.active()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return active();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return active?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class Active implements WorkoutState {
  const factory Active() = _$ActiveImpl;
}

/// @nodoc
abstract class _$$SetSummaryImplCopyWith<$Res> {
  factory _$$SetSummaryImplCopyWith(
    _$SetSummaryImpl value,
    $Res Function(_$SetSummaryImpl) then,
  ) = __$$SetSummaryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<WorkoutMetric> metrics,
    double peakPower,
    double averagePower,
    int repCount,
  });
}

/// @nodoc
class __$$SetSummaryImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$SetSummaryImpl>
    implements _$$SetSummaryImplCopyWith<$Res> {
  __$$SetSummaryImplCopyWithImpl(
    _$SetSummaryImpl _value,
    $Res Function(_$SetSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metrics = null,
    Object? peakPower = null,
    Object? averagePower = null,
    Object? repCount = null,
  }) {
    return _then(
      _$SetSummaryImpl(
        metrics: null == metrics
            ? _value._metrics
            : metrics // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutMetric>,
        peakPower: null == peakPower
            ? _value.peakPower
            : peakPower // ignore: cast_nullable_to_non_nullable
                  as double,
        averagePower: null == averagePower
            ? _value.averagePower
            : averagePower // ignore: cast_nullable_to_non_nullable
                  as double,
        repCount: null == repCount
            ? _value.repCount
            : repCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SetSummaryImpl implements SetSummary {
  const _$SetSummaryImpl({
    required final List<WorkoutMetric> metrics,
    required this.peakPower,
    required this.averagePower,
    required this.repCount,
  }) : _metrics = metrics;

  final List<WorkoutMetric> _metrics;
  @override
  List<WorkoutMetric> get metrics {
    if (_metrics is EqualUnmodifiableListView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metrics);
  }

  @override
  final double peakPower;
  @override
  final double averagePower;
  @override
  final int repCount;

  @override
  String toString() {
    return 'WorkoutState.setSummary(metrics: $metrics, peakPower: $peakPower, averagePower: $averagePower, repCount: $repCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetSummaryImpl &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.peakPower, peakPower) ||
                other.peakPower == peakPower) &&
            (identical(other.averagePower, averagePower) ||
                other.averagePower == averagePower) &&
            (identical(other.repCount, repCount) ||
                other.repCount == repCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_metrics),
    peakPower,
    averagePower,
    repCount,
  );

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetSummaryImplCopyWith<_$SetSummaryImpl> get copyWith =>
      __$$SetSummaryImplCopyWithImpl<_$SetSummaryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return setSummary(metrics, peakPower, averagePower, repCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return setSummary?.call(metrics, peakPower, averagePower, repCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (setSummary != null) {
      return setSummary(metrics, peakPower, averagePower, repCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return setSummary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return setSummary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (setSummary != null) {
      return setSummary(this);
    }
    return orElse();
  }
}

abstract class SetSummary implements WorkoutState {
  const factory SetSummary({
    required final List<WorkoutMetric> metrics,
    required final double peakPower,
    required final double averagePower,
    required final int repCount,
  }) = _$SetSummaryImpl;

  List<WorkoutMetric> get metrics;
  double get peakPower;
  double get averagePower;
  int get repCount;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetSummaryImplCopyWith<_$SetSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
    _$PausedImpl value,
    $Res Function(_$PausedImpl) then,
  ) = __$$PausedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
    _$PausedImpl _value,
    $Res Function(_$PausedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PausedImpl implements Paused {
  const _$PausedImpl();

  @override
  String toString() {
    return 'WorkoutState.paused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PausedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return paused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return paused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class Paused implements WorkoutState {
  const factory Paused() = _$PausedImpl;
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
    _$CompletedImpl value,
    $Res Function(_$CompletedImpl) then,
  ) = __$$CompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
    _$CompletedImpl _value,
    $Res Function(_$CompletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompletedImpl implements Completed {
  const _$CompletedImpl();

  @override
  String toString() {
    return 'WorkoutState.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class Completed implements WorkoutState {
  const factory Completed() = _$CompletedImpl;
}

/// @nodoc
abstract class _$$WorkoutErrorImplCopyWith<$Res> {
  factory _$$WorkoutErrorImplCopyWith(
    _$WorkoutErrorImpl value,
    $Res Function(_$WorkoutErrorImpl) then,
  ) = __$$WorkoutErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$WorkoutErrorImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutErrorImpl>
    implements _$$WorkoutErrorImplCopyWith<$Res> {
  __$$WorkoutErrorImplCopyWithImpl(
    _$WorkoutErrorImpl _value,
    $Res Function(_$WorkoutErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$WorkoutErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutErrorImpl implements WorkoutError {
  const _$WorkoutErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'WorkoutState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutErrorImplCopyWith<_$WorkoutErrorImpl> get copyWith =>
      __$$WorkoutErrorImplCopyWithImpl<_$WorkoutErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WorkoutError implements WorkoutState {
  const factory WorkoutError({required final String message}) =
      _$WorkoutErrorImpl;

  String get message;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutErrorImplCopyWith<_$WorkoutErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RestingImplCopyWith<$Res> {
  factory _$$RestingImplCopyWith(
    _$RestingImpl value,
    $Res Function(_$RestingImpl) then,
  ) = __$$RestingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    int restSecondsRemaining,
    String nextExerciseName,
    bool isLastExercise,
    int currentSet,
    int totalSets,
  });
}

/// @nodoc
class __$$RestingImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$RestingImpl>
    implements _$$RestingImplCopyWith<$Res> {
  __$$RestingImplCopyWithImpl(
    _$RestingImpl _value,
    $Res Function(_$RestingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restSecondsRemaining = null,
    Object? nextExerciseName = null,
    Object? isLastExercise = null,
    Object? currentSet = null,
    Object? totalSets = null,
  }) {
    return _then(
      _$RestingImpl(
        restSecondsRemaining: null == restSecondsRemaining
            ? _value.restSecondsRemaining
            : restSecondsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        nextExerciseName: null == nextExerciseName
            ? _value.nextExerciseName
            : nextExerciseName // ignore: cast_nullable_to_non_nullable
                  as String,
        isLastExercise: null == isLastExercise
            ? _value.isLastExercise
            : isLastExercise // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentSet: null == currentSet
            ? _value.currentSet
            : currentSet // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSets: null == totalSets
            ? _value.totalSets
            : totalSets // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RestingImpl implements Resting {
  const _$RestingImpl({
    required this.restSecondsRemaining,
    required this.nextExerciseName,
    required this.isLastExercise,
    required this.currentSet,
    required this.totalSets,
  });

  @override
  final int restSecondsRemaining;
  @override
  final String nextExerciseName;
  @override
  final bool isLastExercise;
  @override
  final int currentSet;
  @override
  final int totalSets;

  @override
  String toString() {
    return 'WorkoutState.resting(restSecondsRemaining: $restSecondsRemaining, nextExerciseName: $nextExerciseName, isLastExercise: $isLastExercise, currentSet: $currentSet, totalSets: $totalSets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestingImpl &&
            (identical(other.restSecondsRemaining, restSecondsRemaining) ||
                other.restSecondsRemaining == restSecondsRemaining) &&
            (identical(other.nextExerciseName, nextExerciseName) ||
                other.nextExerciseName == nextExerciseName) &&
            (identical(other.isLastExercise, isLastExercise) ||
                other.isLastExercise == isLastExercise) &&
            (identical(other.currentSet, currentSet) ||
                other.currentSet == currentSet) &&
            (identical(other.totalSets, totalSets) ||
                other.totalSets == totalSets));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    restSecondsRemaining,
    nextExerciseName,
    isLastExercise,
    currentSet,
    totalSets,
  );

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      __$$RestingImplCopyWithImpl<_$RestingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() initializing,
    required TResult Function(int secondsRemaining) countdown,
    required TResult Function() active,
    required TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )
    setSummary,
    required TResult Function() paused,
    required TResult Function() completed,
    required TResult Function(String message) error,
    required TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )
    resting,
  }) {
    return resting(
      restSecondsRemaining,
      nextExerciseName,
      isLastExercise,
      currentSet,
      totalSets,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? initializing,
    TResult? Function(int secondsRemaining)? countdown,
    TResult? Function()? active,
    TResult? Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult? Function()? paused,
    TResult? Function()? completed,
    TResult? Function(String message)? error,
    TResult? Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
  }) {
    return resting?.call(
      restSecondsRemaining,
      nextExerciseName,
      isLastExercise,
      currentSet,
      totalSets,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? initializing,
    TResult Function(int secondsRemaining)? countdown,
    TResult Function()? active,
    TResult Function(
      List<WorkoutMetric> metrics,
      double peakPower,
      double averagePower,
      int repCount,
    )?
    setSummary,
    TResult Function()? paused,
    TResult Function()? completed,
    TResult Function(String message)? error,
    TResult Function(
      int restSecondsRemaining,
      String nextExerciseName,
      bool isLastExercise,
      int currentSet,
      int totalSets,
    )?
    resting,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(
        restSecondsRemaining,
        nextExerciseName,
        isLastExercise,
        currentSet,
        totalSets,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Initializing value) initializing,
    required TResult Function(Countdown value) countdown,
    required TResult Function(Active value) active,
    required TResult Function(SetSummary value) setSummary,
    required TResult Function(Paused value) paused,
    required TResult Function(Completed value) completed,
    required TResult Function(WorkoutError value) error,
    required TResult Function(Resting value) resting,
  }) {
    return resting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(Initializing value)? initializing,
    TResult? Function(Countdown value)? countdown,
    TResult? Function(Active value)? active,
    TResult? Function(SetSummary value)? setSummary,
    TResult? Function(Paused value)? paused,
    TResult? Function(Completed value)? completed,
    TResult? Function(WorkoutError value)? error,
    TResult? Function(Resting value)? resting,
  }) {
    return resting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Initializing value)? initializing,
    TResult Function(Countdown value)? countdown,
    TResult Function(Active value)? active,
    TResult Function(SetSummary value)? setSummary,
    TResult Function(Paused value)? paused,
    TResult Function(Completed value)? completed,
    TResult Function(WorkoutError value)? error,
    TResult Function(Resting value)? resting,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(this);
    }
    return orElse();
  }
}

abstract class Resting implements WorkoutState {
  const factory Resting({
    required final int restSecondsRemaining,
    required final String nextExerciseName,
    required final bool isLastExercise,
    required final int currentSet,
    required final int totalSets,
  }) = _$RestingImpl;

  int get restSecondsRemaining;
  String get nextExerciseName;
  bool get isLastExercise;
  int get currentSet;
  int get totalSets;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
