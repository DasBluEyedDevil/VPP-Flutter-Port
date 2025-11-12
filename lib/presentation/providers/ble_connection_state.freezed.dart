// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BleConnectionState {
  List<ScannedDevice> get scannedDevices => throw _privateConstructorUsedError;
  bool get isAutoConnecting => throw _privateConstructorUsedError;
  String? get connectionError => throw _privateConstructorUsedError;
  bool get connectionLostDuringWorkout => throw _privateConstructorUsedError;

  /// Create a copy of BleConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BleConnectionStateCopyWith<BleConnectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleConnectionStateCopyWith<$Res> {
  factory $BleConnectionStateCopyWith(
    BleConnectionState value,
    $Res Function(BleConnectionState) then,
  ) = _$BleConnectionStateCopyWithImpl<$Res, BleConnectionState>;
  @useResult
  $Res call({
    List<ScannedDevice> scannedDevices,
    bool isAutoConnecting,
    String? connectionError,
    bool connectionLostDuringWorkout,
  });
}

/// @nodoc
class _$BleConnectionStateCopyWithImpl<$Res, $Val extends BleConnectionState>
    implements $BleConnectionStateCopyWith<$Res> {
  _$BleConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BleConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scannedDevices = null,
    Object? isAutoConnecting = null,
    Object? connectionError = freezed,
    Object? connectionLostDuringWorkout = null,
  }) {
    return _then(
      _value.copyWith(
            scannedDevices: null == scannedDevices
                ? _value.scannedDevices
                : scannedDevices // ignore: cast_nullable_to_non_nullable
                      as List<ScannedDevice>,
            isAutoConnecting: null == isAutoConnecting
                ? _value.isAutoConnecting
                : isAutoConnecting // ignore: cast_nullable_to_non_nullable
                      as bool,
            connectionError: freezed == connectionError
                ? _value.connectionError
                : connectionError // ignore: cast_nullable_to_non_nullable
                      as String?,
            connectionLostDuringWorkout: null == connectionLostDuringWorkout
                ? _value.connectionLostDuringWorkout
                : connectionLostDuringWorkout // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BleConnectionStateImplCopyWith<$Res>
    implements $BleConnectionStateCopyWith<$Res> {
  factory _$$BleConnectionStateImplCopyWith(
    _$BleConnectionStateImpl value,
    $Res Function(_$BleConnectionStateImpl) then,
  ) = __$$BleConnectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ScannedDevice> scannedDevices,
    bool isAutoConnecting,
    String? connectionError,
    bool connectionLostDuringWorkout,
  });
}

/// @nodoc
class __$$BleConnectionStateImplCopyWithImpl<$Res>
    extends _$BleConnectionStateCopyWithImpl<$Res, _$BleConnectionStateImpl>
    implements _$$BleConnectionStateImplCopyWith<$Res> {
  __$$BleConnectionStateImplCopyWithImpl(
    _$BleConnectionStateImpl _value,
    $Res Function(_$BleConnectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BleConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scannedDevices = null,
    Object? isAutoConnecting = null,
    Object? connectionError = freezed,
    Object? connectionLostDuringWorkout = null,
  }) {
    return _then(
      _$BleConnectionStateImpl(
        scannedDevices: null == scannedDevices
            ? _value._scannedDevices
            : scannedDevices // ignore: cast_nullable_to_non_nullable
                  as List<ScannedDevice>,
        isAutoConnecting: null == isAutoConnecting
            ? _value.isAutoConnecting
            : isAutoConnecting // ignore: cast_nullable_to_non_nullable
                  as bool,
        connectionError: freezed == connectionError
            ? _value.connectionError
            : connectionError // ignore: cast_nullable_to_non_nullable
                  as String?,
        connectionLostDuringWorkout: null == connectionLostDuringWorkout
            ? _value.connectionLostDuringWorkout
            : connectionLostDuringWorkout // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$BleConnectionStateImpl implements _BleConnectionState {
  const _$BleConnectionStateImpl({
    final List<ScannedDevice> scannedDevices = const [],
    this.isAutoConnecting = false,
    this.connectionError,
    this.connectionLostDuringWorkout = false,
  }) : _scannedDevices = scannedDevices;

  final List<ScannedDevice> _scannedDevices;
  @override
  @JsonKey()
  List<ScannedDevice> get scannedDevices {
    if (_scannedDevices is EqualUnmodifiableListView) return _scannedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scannedDevices);
  }

  @override
  @JsonKey()
  final bool isAutoConnecting;
  @override
  final String? connectionError;
  @override
  @JsonKey()
  final bool connectionLostDuringWorkout;

  @override
  String toString() {
    return 'BleConnectionState(scannedDevices: $scannedDevices, isAutoConnecting: $isAutoConnecting, connectionError: $connectionError, connectionLostDuringWorkout: $connectionLostDuringWorkout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BleConnectionStateImpl &&
            const DeepCollectionEquality().equals(
              other._scannedDevices,
              _scannedDevices,
            ) &&
            (identical(other.isAutoConnecting, isAutoConnecting) ||
                other.isAutoConnecting == isAutoConnecting) &&
            (identical(other.connectionError, connectionError) ||
                other.connectionError == connectionError) &&
            (identical(
                  other.connectionLostDuringWorkout,
                  connectionLostDuringWorkout,
                ) ||
                other.connectionLostDuringWorkout ==
                    connectionLostDuringWorkout));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_scannedDevices),
    isAutoConnecting,
    connectionError,
    connectionLostDuringWorkout,
  );

  /// Create a copy of BleConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BleConnectionStateImplCopyWith<_$BleConnectionStateImpl> get copyWith =>
      __$$BleConnectionStateImplCopyWithImpl<_$BleConnectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _BleConnectionState implements BleConnectionState {
  const factory _BleConnectionState({
    final List<ScannedDevice> scannedDevices,
    final bool isAutoConnecting,
    final String? connectionError,
    final bool connectionLostDuringWorkout,
  }) = _$BleConnectionStateImpl;

  @override
  List<ScannedDevice> get scannedDevices;
  @override
  bool get isAutoConnecting;
  @override
  String? get connectionError;
  @override
  bool get connectionLostDuringWorkout;

  /// Create a copy of BleConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BleConnectionStateImplCopyWith<_$BleConnectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
