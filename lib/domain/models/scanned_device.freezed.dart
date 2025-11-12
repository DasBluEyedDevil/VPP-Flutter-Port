// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanned_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScannedDevice {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get rssi => throw _privateConstructorUsedError;

  /// Create a copy of ScannedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannedDeviceCopyWith<ScannedDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannedDeviceCopyWith<$Res> {
  factory $ScannedDeviceCopyWith(
    ScannedDevice value,
    $Res Function(ScannedDevice) then,
  ) = _$ScannedDeviceCopyWithImpl<$Res, ScannedDevice>;
  @useResult
  $Res call({String name, String address, int rssi});
}

/// @nodoc
class _$ScannedDeviceCopyWithImpl<$Res, $Val extends ScannedDevice>
    implements $ScannedDeviceCopyWith<$Res> {
  _$ScannedDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? rssi = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            rssi: null == rssi
                ? _value.rssi
                : rssi // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScannedDeviceImplCopyWith<$Res>
    implements $ScannedDeviceCopyWith<$Res> {
  factory _$$ScannedDeviceImplCopyWith(
    _$ScannedDeviceImpl value,
    $Res Function(_$ScannedDeviceImpl) then,
  ) = __$$ScannedDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String address, int rssi});
}

/// @nodoc
class __$$ScannedDeviceImplCopyWithImpl<$Res>
    extends _$ScannedDeviceCopyWithImpl<$Res, _$ScannedDeviceImpl>
    implements _$$ScannedDeviceImplCopyWith<$Res> {
  __$$ScannedDeviceImplCopyWithImpl(
    _$ScannedDeviceImpl _value,
    $Res Function(_$ScannedDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScannedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? rssi = null,
  }) {
    return _then(
      _$ScannedDeviceImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        rssi: null == rssi
            ? _value.rssi
            : rssi // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ScannedDeviceImpl implements _ScannedDevice {
  const _$ScannedDeviceImpl({
    required this.name,
    required this.address,
    required this.rssi,
  });

  @override
  final String name;
  @override
  final String address;
  @override
  final int rssi;

  @override
  String toString() {
    return 'ScannedDevice(name: $name, address: $address, rssi: $rssi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedDeviceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rssi, rssi) || other.rssi == rssi));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, address, rssi);

  /// Create a copy of ScannedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedDeviceImplCopyWith<_$ScannedDeviceImpl> get copyWith =>
      __$$ScannedDeviceImplCopyWithImpl<_$ScannedDeviceImpl>(this, _$identity);
}

abstract class _ScannedDevice implements ScannedDevice {
  const factory _ScannedDevice({
    required final String name,
    required final String address,
    required final int rssi,
  }) = _$ScannedDeviceImpl;

  @override
  String get name;
  @override
  String get address;
  @override
  int get rssi;

  /// Create a copy of ScannedDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannedDeviceImplCopyWith<_$ScannedDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
