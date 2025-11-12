// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rep_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RepCount {
  int get warmupReps => throw _privateConstructorUsedError;
  int get workingReps => throw _privateConstructorUsedError;
  bool get isWarmupComplete => throw _privateConstructorUsedError;

  /// Create a copy of RepCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepCountCopyWith<RepCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepCountCopyWith<$Res> {
  factory $RepCountCopyWith(RepCount value, $Res Function(RepCount) then) =
      _$RepCountCopyWithImpl<$Res, RepCount>;
  @useResult
  $Res call({int warmupReps, int workingReps, bool isWarmupComplete});
}

/// @nodoc
class _$RepCountCopyWithImpl<$Res, $Val extends RepCount>
    implements $RepCountCopyWith<$Res> {
  _$RepCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warmupReps = null,
    Object? workingReps = null,
    Object? isWarmupComplete = null,
  }) {
    return _then(
      _value.copyWith(
            warmupReps: null == warmupReps
                ? _value.warmupReps
                : warmupReps // ignore: cast_nullable_to_non_nullable
                      as int,
            workingReps: null == workingReps
                ? _value.workingReps
                : workingReps // ignore: cast_nullable_to_non_nullable
                      as int,
            isWarmupComplete: null == isWarmupComplete
                ? _value.isWarmupComplete
                : isWarmupComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepCountImplCopyWith<$Res>
    implements $RepCountCopyWith<$Res> {
  factory _$$RepCountImplCopyWith(
    _$RepCountImpl value,
    $Res Function(_$RepCountImpl) then,
  ) = __$$RepCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int warmupReps, int workingReps, bool isWarmupComplete});
}

/// @nodoc
class __$$RepCountImplCopyWithImpl<$Res>
    extends _$RepCountCopyWithImpl<$Res, _$RepCountImpl>
    implements _$$RepCountImplCopyWith<$Res> {
  __$$RepCountImplCopyWithImpl(
    _$RepCountImpl _value,
    $Res Function(_$RepCountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? warmupReps = null,
    Object? workingReps = null,
    Object? isWarmupComplete = null,
  }) {
    return _then(
      _$RepCountImpl(
        warmupReps: null == warmupReps
            ? _value.warmupReps
            : warmupReps // ignore: cast_nullable_to_non_nullable
                  as int,
        workingReps: null == workingReps
            ? _value.workingReps
            : workingReps // ignore: cast_nullable_to_non_nullable
                  as int,
        isWarmupComplete: null == isWarmupComplete
            ? _value.isWarmupComplete
            : isWarmupComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RepCountImpl extends _RepCount {
  const _$RepCountImpl({
    this.warmupReps = 0,
    this.workingReps = 0,
    this.isWarmupComplete = false,
  }) : super._();

  @override
  @JsonKey()
  final int warmupReps;
  @override
  @JsonKey()
  final int workingReps;
  @override
  @JsonKey()
  final bool isWarmupComplete;

  @override
  String toString() {
    return 'RepCount(warmupReps: $warmupReps, workingReps: $workingReps, isWarmupComplete: $isWarmupComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepCountImpl &&
            (identical(other.warmupReps, warmupReps) ||
                other.warmupReps == warmupReps) &&
            (identical(other.workingReps, workingReps) ||
                other.workingReps == workingReps) &&
            (identical(other.isWarmupComplete, isWarmupComplete) ||
                other.isWarmupComplete == isWarmupComplete));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, warmupReps, workingReps, isWarmupComplete);

  /// Create a copy of RepCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepCountImplCopyWith<_$RepCountImpl> get copyWith =>
      __$$RepCountImplCopyWithImpl<_$RepCountImpl>(this, _$identity);
}

abstract class _RepCount extends RepCount {
  const factory _RepCount({
    final int warmupReps,
    final int workingReps,
    final bool isWarmupComplete,
  }) = _$RepCountImpl;
  const _RepCount._() : super._();

  @override
  int get warmupReps;
  @override
  int get workingReps;
  @override
  bool get isWarmupComplete;

  /// Create a copy of RepCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepCountImplCopyWith<_$RepCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RepEvent {
  RepType get type => throw _privateConstructorUsedError;
  int get warmupCount => throw _privateConstructorUsedError;
  int get workingCount => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of RepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepEventCopyWith<RepEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepEventCopyWith<$Res> {
  factory $RepEventCopyWith(RepEvent value, $Res Function(RepEvent) then) =
      _$RepEventCopyWithImpl<$Res, RepEvent>;
  @useResult
  $Res call({RepType type, int warmupCount, int workingCount, int timestamp});
}

/// @nodoc
class _$RepEventCopyWithImpl<$Res, $Val extends RepEvent>
    implements $RepEventCopyWith<$Res> {
  _$RepEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? warmupCount = null,
    Object? workingCount = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RepType,
            warmupCount: null == warmupCount
                ? _value.warmupCount
                : warmupCount // ignore: cast_nullable_to_non_nullable
                      as int,
            workingCount: null == workingCount
                ? _value.workingCount
                : workingCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$RepEventImplCopyWith<$Res>
    implements $RepEventCopyWith<$Res> {
  factory _$$RepEventImplCopyWith(
    _$RepEventImpl value,
    $Res Function(_$RepEventImpl) then,
  ) = __$$RepEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RepType type, int warmupCount, int workingCount, int timestamp});
}

/// @nodoc
class __$$RepEventImplCopyWithImpl<$Res>
    extends _$RepEventCopyWithImpl<$Res, _$RepEventImpl>
    implements _$$RepEventImplCopyWith<$Res> {
  __$$RepEventImplCopyWithImpl(
    _$RepEventImpl _value,
    $Res Function(_$RepEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? warmupCount = null,
    Object? workingCount = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$RepEventImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RepType,
        warmupCount: null == warmupCount
            ? _value.warmupCount
            : warmupCount // ignore: cast_nullable_to_non_nullable
                  as int,
        workingCount: null == workingCount
            ? _value.workingCount
            : workingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RepEventImpl implements _RepEvent {
  const _$RepEventImpl({
    required this.type,
    required this.warmupCount,
    required this.workingCount,
    this.timestamp = 0,
  });

  @override
  final RepType type;
  @override
  final int warmupCount;
  @override
  final int workingCount;
  @override
  @JsonKey()
  final int timestamp;

  @override
  String toString() {
    return 'RepEvent(type: $type, warmupCount: $warmupCount, workingCount: $workingCount, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.warmupCount, warmupCount) ||
                other.warmupCount == warmupCount) &&
            (identical(other.workingCount, workingCount) ||
                other.workingCount == workingCount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, type, warmupCount, workingCount, timestamp);

  /// Create a copy of RepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepEventImplCopyWith<_$RepEventImpl> get copyWith =>
      __$$RepEventImplCopyWithImpl<_$RepEventImpl>(this, _$identity);
}

abstract class _RepEvent implements RepEvent {
  const factory _RepEvent({
    required final RepType type,
    required final int warmupCount,
    required final int workingCount,
    final int timestamp,
  }) = _$RepEventImpl;

  @override
  RepType get type;
  @override
  int get warmupCount;
  @override
  int get workingCount;
  @override
  int get timestamp;

  /// Create a copy of RepEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepEventImplCopyWith<_$RepEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
