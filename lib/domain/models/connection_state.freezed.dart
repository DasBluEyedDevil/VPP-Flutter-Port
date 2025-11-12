// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConnectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionStateCopyWith<$Res> {
  factory $ConnectionStateCopyWith(
    ConnectionState value,
    $Res Function(ConnectionState) then,
  ) = _$ConnectionStateCopyWithImpl<$Res, ConnectionState>;
}

/// @nodoc
class _$ConnectionStateCopyWithImpl<$Res, $Val extends ConnectionState>
    implements $ConnectionStateCopyWith<$Res> {
  _$ConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DisconnectedImplCopyWith<$Res> {
  factory _$$DisconnectedImplCopyWith(
    _$DisconnectedImpl value,
    $Res Function(_$DisconnectedImpl) then,
  ) = __$$DisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectedImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
    _$DisconnectedImpl _value,
    $Res Function(_$DisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectedImpl implements Disconnected {
  const _$DisconnectedImpl();

  @override
  String toString() {
    return 'ConnectionState.disconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisconnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) {
    return disconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) {
    return disconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class Disconnected implements ConnectionState {
  const factory Disconnected() = _$DisconnectedImpl;
}

/// @nodoc
abstract class _$$ScanningImplCopyWith<$Res> {
  factory _$$ScanningImplCopyWith(
    _$ScanningImpl value,
    $Res Function(_$ScanningImpl) then,
  ) = __$$ScanningImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScanningImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ScanningImpl>
    implements _$$ScanningImplCopyWith<$Res> {
  __$$ScanningImplCopyWithImpl(
    _$ScanningImpl _value,
    $Res Function(_$ScanningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScanningImpl implements Scanning {
  const _$ScanningImpl();

  @override
  String toString() {
    return 'ConnectionState.scanning()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ScanningImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) {
    return scanning();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) {
    return scanning?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return scanning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return scanning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning(this);
    }
    return orElse();
  }
}

abstract class Scanning implements ConnectionState {
  const factory Scanning() = _$ScanningImpl;
}

/// @nodoc
abstract class _$$ConnectingImplCopyWith<$Res> {
  factory _$$ConnectingImplCopyWith(
    _$ConnectingImpl value,
    $Res Function(_$ConnectingImpl) then,
  ) = __$$ConnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectingImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectingImpl>
    implements _$$ConnectingImplCopyWith<$Res> {
  __$$ConnectingImplCopyWithImpl(
    _$ConnectingImpl _value,
    $Res Function(_$ConnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectingImpl implements Connecting {
  const _$ConnectingImpl();

  @override
  String toString() {
    return 'ConnectionState.connecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) {
    return connecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) {
    return connecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class Connecting implements ConnectionState {
  const factory Connecting() = _$ConnectingImpl;
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
    _$ConnectedImpl value,
    $Res Function(_$ConnectedImpl) then,
  ) = __$$ConnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String deviceName,
    String deviceAddress,
    VitruvianModel hardwareModel,
  });
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
    _$ConnectedImpl _value,
    $Res Function(_$ConnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceName = null,
    Object? deviceAddress = null,
    Object? hardwareModel = null,
  }) {
    return _then(
      _$ConnectedImpl(
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceAddress: null == deviceAddress
            ? _value.deviceAddress
            : deviceAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        hardwareModel: null == hardwareModel
            ? _value.hardwareModel
            : hardwareModel // ignore: cast_nullable_to_non_nullable
                  as VitruvianModel,
      ),
    );
  }
}

/// @nodoc

class _$ConnectedImpl implements Connected {
  const _$ConnectedImpl({
    required this.deviceName,
    required this.deviceAddress,
    required this.hardwareModel,
  });

  @override
  final String deviceName;
  @override
  final String deviceAddress;
  @override
  final VitruvianModel hardwareModel;

  @override
  String toString() {
    return 'ConnectionState.connected(deviceName: $deviceName, deviceAddress: $deviceAddress, hardwareModel: $hardwareModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedImpl &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceAddress, deviceAddress) ||
                other.deviceAddress == deviceAddress) &&
            (identical(other.hardwareModel, hardwareModel) ||
                other.hardwareModel == hardwareModel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, deviceName, deviceAddress, hardwareModel);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      __$$ConnectedImplCopyWithImpl<_$ConnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) {
    return connected(deviceName, deviceAddress, hardwareModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) {
    return connected?.call(deviceName, deviceAddress, hardwareModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(deviceName, deviceAddress, hardwareModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected implements ConnectionState {
  const factory Connected({
    required final String deviceName,
    required final String deviceAddress,
    required final VitruvianModel hardwareModel,
  }) = _$ConnectedImpl;

  String get deviceName;
  String get deviceAddress;
  VitruvianModel get hardwareModel;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<$Res> {
  factory _$$ConnectionErrorImplCopyWith(
    _$ConnectionErrorImpl value,
    $Res Function(_$ConnectionErrorImpl) then,
  ) = __$$ConnectionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, Object? throwable});
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionErrorImpl>
    implements _$$ConnectionErrorImplCopyWith<$Res> {
  __$$ConnectionErrorImplCopyWithImpl(
    _$ConnectionErrorImpl _value,
    $Res Function(_$ConnectionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? throwable = freezed}) {
    return _then(
      _$ConnectionErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        throwable: freezed == throwable ? _value.throwable : throwable,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionErrorImpl implements ConnectionError {
  const _$ConnectionErrorImpl({required this.message, this.throwable});

  @override
  final String message;
  @override
  final Object? throwable;

  @override
  String toString() {
    return 'ConnectionState.error(message: $message, throwable: $throwable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.throwable, throwable));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(throwable),
  );

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      __$$ConnectionErrorImplCopyWithImpl<_$ConnectionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() scanning,
    required TResult Function() connecting,
    required TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )
    connected,
    required TResult Function(String message, Object? throwable) error,
  }) {
    return error(message, throwable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? scanning,
    TResult? Function()? connecting,
    TResult? Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult? Function(String message, Object? throwable)? error,
  }) {
    return error?.call(message, throwable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? scanning,
    TResult Function()? connecting,
    TResult Function(
      String deviceName,
      String deviceAddress,
      VitruvianModel hardwareModel,
    )?
    connected,
    TResult Function(String message, Object? throwable)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, throwable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Scanning value) scanning,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Scanning value)? scanning,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Scanning value)? scanning,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConnectionError implements ConnectionState {
  const factory ConnectionError({
    required final String message,
    final Object? throwable,
  }) = _$ConnectionErrorImpl;

  String get message;
  Object? get throwable;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
