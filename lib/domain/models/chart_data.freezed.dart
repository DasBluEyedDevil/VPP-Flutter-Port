// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChartDataPoint {
  int get timestamp => throw _privateConstructorUsedError;
  double get totalLoad => throw _privateConstructorUsedError;
  double get loadA => throw _privateConstructorUsedError;
  double get loadB => throw _privateConstructorUsedError;
  int get positionA => throw _privateConstructorUsedError;
  int get positionB => throw _privateConstructorUsedError;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartDataPointCopyWith<ChartDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataPointCopyWith<$Res> {
  factory $ChartDataPointCopyWith(
    ChartDataPoint value,
    $Res Function(ChartDataPoint) then,
  ) = _$ChartDataPointCopyWithImpl<$Res, ChartDataPoint>;
  @useResult
  $Res call({
    int timestamp,
    double totalLoad,
    double loadA,
    double loadB,
    int positionA,
    int positionB,
  });
}

/// @nodoc
class _$ChartDataPointCopyWithImpl<$Res, $Val extends ChartDataPoint>
    implements $ChartDataPointCopyWith<$Res> {
  _$ChartDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? totalLoad = null,
    Object? loadA = null,
    Object? loadB = null,
    Object? positionA = null,
    Object? positionB = null,
  }) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            totalLoad: null == totalLoad
                ? _value.totalLoad
                : totalLoad // ignore: cast_nullable_to_non_nullable
                      as double,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartDataPointImplCopyWith<$Res>
    implements $ChartDataPointCopyWith<$Res> {
  factory _$$ChartDataPointImplCopyWith(
    _$ChartDataPointImpl value,
    $Res Function(_$ChartDataPointImpl) then,
  ) = __$$ChartDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int timestamp,
    double totalLoad,
    double loadA,
    double loadB,
    int positionA,
    int positionB,
  });
}

/// @nodoc
class __$$ChartDataPointImplCopyWithImpl<$Res>
    extends _$ChartDataPointCopyWithImpl<$Res, _$ChartDataPointImpl>
    implements _$$ChartDataPointImplCopyWith<$Res> {
  __$$ChartDataPointImplCopyWithImpl(
    _$ChartDataPointImpl _value,
    $Res Function(_$ChartDataPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? totalLoad = null,
    Object? loadA = null,
    Object? loadB = null,
    Object? positionA = null,
    Object? positionB = null,
  }) {
    return _then(
      _$ChartDataPointImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        totalLoad: null == totalLoad
            ? _value.totalLoad
            : totalLoad // ignore: cast_nullable_to_non_nullable
                  as double,
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
      ),
    );
  }
}

/// @nodoc

class _$ChartDataPointImpl implements _ChartDataPoint {
  const _$ChartDataPointImpl({
    required this.timestamp,
    required this.totalLoad,
    required this.loadA,
    required this.loadB,
    required this.positionA,
    required this.positionB,
  });

  @override
  final int timestamp;
  @override
  final double totalLoad;
  @override
  final double loadA;
  @override
  final double loadB;
  @override
  final int positionA;
  @override
  final int positionB;

  @override
  String toString() {
    return 'ChartDataPoint(timestamp: $timestamp, totalLoad: $totalLoad, loadA: $loadA, loadB: $loadB, positionA: $positionA, positionB: $positionB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.totalLoad, totalLoad) ||
                other.totalLoad == totalLoad) &&
            (identical(other.loadA, loadA) || other.loadA == loadA) &&
            (identical(other.loadB, loadB) || other.loadB == loadB) &&
            (identical(other.positionA, positionA) ||
                other.positionA == positionA) &&
            (identical(other.positionB, positionB) ||
                other.positionB == positionB));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    timestamp,
    totalLoad,
    loadA,
    loadB,
    positionA,
    positionB,
  );

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataPointImplCopyWith<_$ChartDataPointImpl> get copyWith =>
      __$$ChartDataPointImplCopyWithImpl<_$ChartDataPointImpl>(
        this,
        _$identity,
      );
}

abstract class _ChartDataPoint implements ChartDataPoint {
  const factory _ChartDataPoint({
    required final int timestamp,
    required final double totalLoad,
    required final double loadA,
    required final double loadB,
    required final int positionA,
    required final int positionB,
  }) = _$ChartDataPointImpl;

  @override
  int get timestamp;
  @override
  double get totalLoad;
  @override
  double get loadA;
  @override
  double get loadB;
  @override
  int get positionA;
  @override
  int get positionB;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataPointImplCopyWith<_$ChartDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChartEvent {
  int get timestamp => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, int repNumber) repStart,
    required TResult Function(int timestamp, int repNumber) repComplete,
    required TResult Function(int timestamp) warmupComplete,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int timestamp, int repNumber)? repStart,
    TResult? Function(int timestamp, int repNumber)? repComplete,
    TResult? Function(int timestamp)? warmupComplete,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, int repNumber)? repStart,
    TResult Function(int timestamp, int repNumber)? repComplete,
    TResult Function(int timestamp)? warmupComplete,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RepStart value) repStart,
    required TResult Function(RepComplete value) repComplete,
    required TResult Function(WarmupComplete value) warmupComplete,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RepStart value)? repStart,
    TResult? Function(RepComplete value)? repComplete,
    TResult? Function(WarmupComplete value)? warmupComplete,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RepStart value)? repStart,
    TResult Function(RepComplete value)? repComplete,
    TResult Function(WarmupComplete value)? warmupComplete,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartEventCopyWith<ChartEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartEventCopyWith<$Res> {
  factory $ChartEventCopyWith(
    ChartEvent value,
    $Res Function(ChartEvent) then,
  ) = _$ChartEventCopyWithImpl<$Res, ChartEvent>;
  @useResult
  $Res call({int timestamp});
}

/// @nodoc
class _$ChartEventCopyWithImpl<$Res, $Val extends ChartEvent>
    implements $ChartEventCopyWith<$Res> {
  _$ChartEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null}) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepStartImplCopyWith<$Res>
    implements $ChartEventCopyWith<$Res> {
  factory _$$RepStartImplCopyWith(
    _$RepStartImpl value,
    $Res Function(_$RepStartImpl) then,
  ) = __$$RepStartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timestamp, int repNumber});
}

/// @nodoc
class __$$RepStartImplCopyWithImpl<$Res>
    extends _$ChartEventCopyWithImpl<$Res, _$RepStartImpl>
    implements _$$RepStartImplCopyWith<$Res> {
  __$$RepStartImplCopyWithImpl(
    _$RepStartImpl _value,
    $Res Function(_$RepStartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null, Object? repNumber = null}) {
    return _then(
      _$RepStartImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        repNumber: null == repNumber
            ? _value.repNumber
            : repNumber // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RepStartImpl extends RepStart {
  const _$RepStartImpl({required this.timestamp, required this.repNumber})
    : super._();

  @override
  final int timestamp;
  @override
  final int repNumber;

  @override
  String toString() {
    return 'ChartEvent.repStart(timestamp: $timestamp, repNumber: $repNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepStartImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.repNumber, repNumber) ||
                other.repNumber == repNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, repNumber);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepStartImplCopyWith<_$RepStartImpl> get copyWith =>
      __$$RepStartImplCopyWithImpl<_$RepStartImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, int repNumber) repStart,
    required TResult Function(int timestamp, int repNumber) repComplete,
    required TResult Function(int timestamp) warmupComplete,
  }) {
    return repStart(timestamp, repNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int timestamp, int repNumber)? repStart,
    TResult? Function(int timestamp, int repNumber)? repComplete,
    TResult? Function(int timestamp)? warmupComplete,
  }) {
    return repStart?.call(timestamp, repNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, int repNumber)? repStart,
    TResult Function(int timestamp, int repNumber)? repComplete,
    TResult Function(int timestamp)? warmupComplete,
    required TResult orElse(),
  }) {
    if (repStart != null) {
      return repStart(timestamp, repNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RepStart value) repStart,
    required TResult Function(RepComplete value) repComplete,
    required TResult Function(WarmupComplete value) warmupComplete,
  }) {
    return repStart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RepStart value)? repStart,
    TResult? Function(RepComplete value)? repComplete,
    TResult? Function(WarmupComplete value)? warmupComplete,
  }) {
    return repStart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RepStart value)? repStart,
    TResult Function(RepComplete value)? repComplete,
    TResult Function(WarmupComplete value)? warmupComplete,
    required TResult orElse(),
  }) {
    if (repStart != null) {
      return repStart(this);
    }
    return orElse();
  }
}

abstract class RepStart extends ChartEvent {
  const factory RepStart({
    required final int timestamp,
    required final int repNumber,
  }) = _$RepStartImpl;
  const RepStart._() : super._();

  @override
  int get timestamp;
  int get repNumber;

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepStartImplCopyWith<_$RepStartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepCompleteImplCopyWith<$Res>
    implements $ChartEventCopyWith<$Res> {
  factory _$$RepCompleteImplCopyWith(
    _$RepCompleteImpl value,
    $Res Function(_$RepCompleteImpl) then,
  ) = __$$RepCompleteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timestamp, int repNumber});
}

/// @nodoc
class __$$RepCompleteImplCopyWithImpl<$Res>
    extends _$ChartEventCopyWithImpl<$Res, _$RepCompleteImpl>
    implements _$$RepCompleteImplCopyWith<$Res> {
  __$$RepCompleteImplCopyWithImpl(
    _$RepCompleteImpl _value,
    $Res Function(_$RepCompleteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null, Object? repNumber = null}) {
    return _then(
      _$RepCompleteImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        repNumber: null == repNumber
            ? _value.repNumber
            : repNumber // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RepCompleteImpl extends RepComplete {
  const _$RepCompleteImpl({required this.timestamp, required this.repNumber})
    : super._();

  @override
  final int timestamp;
  @override
  final int repNumber;

  @override
  String toString() {
    return 'ChartEvent.repComplete(timestamp: $timestamp, repNumber: $repNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepCompleteImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.repNumber, repNumber) ||
                other.repNumber == repNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, repNumber);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepCompleteImplCopyWith<_$RepCompleteImpl> get copyWith =>
      __$$RepCompleteImplCopyWithImpl<_$RepCompleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, int repNumber) repStart,
    required TResult Function(int timestamp, int repNumber) repComplete,
    required TResult Function(int timestamp) warmupComplete,
  }) {
    return repComplete(timestamp, repNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int timestamp, int repNumber)? repStart,
    TResult? Function(int timestamp, int repNumber)? repComplete,
    TResult? Function(int timestamp)? warmupComplete,
  }) {
    return repComplete?.call(timestamp, repNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, int repNumber)? repStart,
    TResult Function(int timestamp, int repNumber)? repComplete,
    TResult Function(int timestamp)? warmupComplete,
    required TResult orElse(),
  }) {
    if (repComplete != null) {
      return repComplete(timestamp, repNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RepStart value) repStart,
    required TResult Function(RepComplete value) repComplete,
    required TResult Function(WarmupComplete value) warmupComplete,
  }) {
    return repComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RepStart value)? repStart,
    TResult? Function(RepComplete value)? repComplete,
    TResult? Function(WarmupComplete value)? warmupComplete,
  }) {
    return repComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RepStart value)? repStart,
    TResult Function(RepComplete value)? repComplete,
    TResult Function(WarmupComplete value)? warmupComplete,
    required TResult orElse(),
  }) {
    if (repComplete != null) {
      return repComplete(this);
    }
    return orElse();
  }
}

abstract class RepComplete extends ChartEvent {
  const factory RepComplete({
    required final int timestamp,
    required final int repNumber,
  }) = _$RepCompleteImpl;
  const RepComplete._() : super._();

  @override
  int get timestamp;
  int get repNumber;

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepCompleteImplCopyWith<_$RepCompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WarmupCompleteImplCopyWith<$Res>
    implements $ChartEventCopyWith<$Res> {
  factory _$$WarmupCompleteImplCopyWith(
    _$WarmupCompleteImpl value,
    $Res Function(_$WarmupCompleteImpl) then,
  ) = __$$WarmupCompleteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timestamp});
}

/// @nodoc
class __$$WarmupCompleteImplCopyWithImpl<$Res>
    extends _$ChartEventCopyWithImpl<$Res, _$WarmupCompleteImpl>
    implements _$$WarmupCompleteImplCopyWith<$Res> {
  __$$WarmupCompleteImplCopyWithImpl(
    _$WarmupCompleteImpl _value,
    $Res Function(_$WarmupCompleteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null}) {
    return _then(
      _$WarmupCompleteImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$WarmupCompleteImpl extends WarmupComplete {
  const _$WarmupCompleteImpl({required this.timestamp}) : super._();

  @override
  final int timestamp;

  @override
  String toString() {
    return 'ChartEvent.warmupComplete(timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarmupCompleteImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp);

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WarmupCompleteImplCopyWith<_$WarmupCompleteImpl> get copyWith =>
      __$$WarmupCompleteImplCopyWithImpl<_$WarmupCompleteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int timestamp, int repNumber) repStart,
    required TResult Function(int timestamp, int repNumber) repComplete,
    required TResult Function(int timestamp) warmupComplete,
  }) {
    return warmupComplete(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int timestamp, int repNumber)? repStart,
    TResult? Function(int timestamp, int repNumber)? repComplete,
    TResult? Function(int timestamp)? warmupComplete,
  }) {
    return warmupComplete?.call(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int timestamp, int repNumber)? repStart,
    TResult Function(int timestamp, int repNumber)? repComplete,
    TResult Function(int timestamp)? warmupComplete,
    required TResult orElse(),
  }) {
    if (warmupComplete != null) {
      return warmupComplete(timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RepStart value) repStart,
    required TResult Function(RepComplete value) repComplete,
    required TResult Function(WarmupComplete value) warmupComplete,
  }) {
    return warmupComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RepStart value)? repStart,
    TResult? Function(RepComplete value)? repComplete,
    TResult? Function(WarmupComplete value)? warmupComplete,
  }) {
    return warmupComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RepStart value)? repStart,
    TResult Function(RepComplete value)? repComplete,
    TResult Function(WarmupComplete value)? warmupComplete,
    required TResult orElse(),
  }) {
    if (warmupComplete != null) {
      return warmupComplete(this);
    }
    return orElse();
  }
}

abstract class WarmupComplete extends ChartEvent {
  const factory WarmupComplete({required final int timestamp}) =
      _$WarmupCompleteImpl;
  const WarmupComplete._() : super._();

  @override
  int get timestamp;

  /// Create a copy of ChartEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WarmupCompleteImplCopyWith<_$WarmupCompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
