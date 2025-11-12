import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanned_device.freezed.dart';

/// Scanned BLE device model
/// 
/// Represents a Bluetooth device discovered during scanning
@freezed
class ScannedDevice with _$ScannedDevice {
  const factory ScannedDevice({
    required String name,
    required String address,
    required int rssi,
  }) = _ScannedDevice;
}
