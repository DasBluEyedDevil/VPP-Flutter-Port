// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutMetric {
  int get timestamp => throw _privateConstructorUsedError;
  double get loadA => throw _privateConstructorUsedError;
  double get loadB => throw _privateConstructorUsedError;
  int get positionA => throw _privateConstructorUsedError;
  int get positionB => throw _privateConstructorUsedError;
  int get ticks => throw _privateConstructorUsedError;
  double get velocityA =>
      throw _privateConstructorUsedError; // Velocity for handle detection (official app protocol)
  double get velocityB => throw _privateConstructorUsedError;
  double get power => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutMetricCopyWith<WorkoutMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutMetricCopyWith<$Res> {
  factory $WorkoutMetricCopyWith(
    WorkoutMetric value,
    $Res Function(WorkoutMetric) then,
  ) = _$WorkoutMetricCopyWithImpl<$Res, WorkoutMetric>;
  @useResult
  $Res call({
    int timestamp,
    double loadA,
    double loadB,
    int positionA,
    int positionB,
    int ticks,
    double velocityA,
    double velocityB,
    double power,
  });
}

/// @nodoc
class _$WorkoutMetricCopyWithImpl<$Res, $Val extends WorkoutMetric>
    implements $WorkoutMetricCopyWith<$Res> {
  _$WorkoutMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? loadA = null,
    Object? loadB = null,
    Object? positionA = null,
    Object? positionB = null,
    Object? ticks = null,
    Object? velocityA = null,
    Object? velocityB = null,
    Object? power = null,
  }) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            loadA: null == loadA
                ? _value.loadA
                : loadA // ignore: cast_nullable_to_non_nullable
                      as double,
            loadB: null == loadB
                ? _value.loadB
                : loadB // ignore: cast_nullable_to_non_nullable
                      as double,
            positionA: null == positionA
                ? _value.positionA
                : positionA // ignore: cast_nullable_to_non_nullable
                      as int,
            positionB: null == positionB
                ? _value.positionB
                : positionB // ignore: cast_nullable_to_non_nullable
                      as int,
            ticks: null == ticks
                ? _value.ticks
                : ticks // ignore: cast_nullable_to_non_nullable
                      as int,
            velocityA: null == velocityA
                ? _value.velocityA
                : velocityA // ignore: cast_nullable_to_non_nullable
                      as double,
            velocityB: null == velocityB
                ? _value.velocityB
                : velocityB // ignore: cast_nullable_to_non_nullable
                      as double,
            power: null == power
                ? _value.power
                : power // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutMetricImplCopyWith<$Res>
    implements $WorkoutMetricCopyWith<$Res> {
  factory _$$WorkoutMetricImplCopyWith(
    _$WorkoutMetricImpl value,
    $Res Function(_$WorkoutMetricImpl) then,
  ) = __$$WorkoutMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int timestamp,
    double loadA,
    double loadB,
    int positionA,
    int positionB,
    int ticks,
    double velocityA,
    double velocityB,
    double power,
  });
}

/// @nodoc
class __$$WorkoutMetricImplCopyWithImpl<$Res>
    extends _$WorkoutMetricCopyWithImpl<$Res, _$WorkoutMetricImpl>
    implements _$$WorkoutMetricImplCopyWith<$Res> {
  __$$WorkoutMetricImplCopyWithImpl(
    _$WorkoutMetricImpl _value,
    $Res Function(_$WorkoutMetricImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? loadA = null,
    Object? loadB = null,
    Object? positionA = null,
    Object? positionB = null,
    Object? ticks = null,
    Object? velocityA = null,
    Object? velocityB = null,
    Object? power = null,
  }) {
    return _then(
      _$WorkoutMetricImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        loadA: null == loadA
            ? _value.loadA
            : loadA // ignore: cast_nullable_to_non_nullable
                  as double,
        loadB: null == loadB
            ? _value.loadB
            : loadB // ignore: cast_nullable_to_non_nullable
                  as double,
        positionA: null == positionA
            ? _value.positionA
            : positionA // ignore: cast_nullable_to_non_nullable
                  as int,
        positionB: null == positionB
            ? _value.positionB
            : positionB // ignore: cast_nullable_to_non_nullable
                  as int,
        ticks: null == ticks
            ? _value.ticks
            : ticks // ignore: cast_nullable_to_non_nullable
                  as int,
        velocityA: null == velocityA
            ? _value.velocityA
            : velocityA // ignore: cast_nullable_to_non_nullable
                  as double,
        velocityB: null == velocityB
            ? _value.velocityB
            : velocityB // ignore: cast_nullable_to_non_nullable
                  as double,
        power: null == power
            ? _value.power
            : power // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutMetricImpl extends _WorkoutMetric {
  const _$WorkoutMetricImpl({
    this.timestamp = 0,
    required this.loadA,
    required this.loadB,
    required this.positionA,
    required this.positionB,
    this.ticks = 0,
    this.velocityA = 0.0,
    this.velocityB = 0.0,
    this.power = 0.0,
  }) : super._();

  @override
  @JsonKey()
  final int timestamp;
  @override
  final double loadA;
  @override
  final double loadB;
  @override
  final int positionA;
  @override
  final int positionB;
  @override
  @JsonKey()
  final int ticks;
  @override
  @JsonKey()
  final double velocityA;
  // Velocity for handle detection (official app protocol)
  @override
  @JsonKey()
  final double velocityB;
  @override
  @JsonKey()
  final double power;

  @override
  String toString() {
    return 'WorkoutMetric(timestamp: $timestamp, loadA: $loadA, loadB: $loadB, positionA: $positionA, positionB: $positionB, ticks: $ticks, velocityA: $velocityA, velocityB: $velocityB, power: $power)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutMetricImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.loadA, loadA) || other.loadA == loadA) &&
            (identical(other.loadB, loadB) || other.loadB == loadB) &&
            (identical(other.positionA, positionA) ||
                other.positionA == positionA) &&
            (identical(other.positionB, positionB) ||
                other.positionB == positionB) &&
            (identical(other.ticks, ticks) || other.ticks == ticks) &&
            (identical(other.velocityA, velocityA) ||
                other.velocityA == velocityA) &&
            (identical(other.velocityB, velocityB) ||
                other.velocityB == velocityB) &&
            (identical(other.power, power) || other.power == power));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    timestamp,
    loadA,
    loadB,
    positionA,
    positionB,
    ticks,
    velocityA,
    velocityB,
    power,
  );

  /// Create a copy of WorkoutMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutMetricImplCopyWith<_$WorkoutMetricImpl> get copyWith =>
      __$$WorkoutMetricImplCopyWithImpl<_$WorkoutMetricImpl>(this, _$identity);
}

abstract class _WorkoutMetric extends WorkoutMetric {
  const factory _WorkoutMetric({
    final int timestamp,
    required final double loadA,
    required final double loadB,
    required final int positionA,
    required final int positionB,
    final int ticks,
    final double velocityA,
    final double velocityB,
    final double power,
  }) = _$WorkoutMetricImpl;
  const _WorkoutMetric._() : super._();

  @override
  int get timestamp;
  @override
  double get loadA;
  @override
  double get loadB;
  @override
  int get positionA;
  @override
  int get positionB;
  @override
  int get ticks;
  @override
  double get velocityA; // Velocity for handle detection (official app protocol)
  @override
  double get velocityB;
  @override
  double get power;

  /// Create a copy of WorkoutMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutMetricImplCopyWith<_$WorkoutMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
