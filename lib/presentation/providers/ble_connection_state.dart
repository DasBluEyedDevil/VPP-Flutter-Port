import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/scanned_device.dart';

part 'ble_connection_state.freezed.dart';

/// BLE connection state for UI management
/// 
/// Holds state related to BLE device scanning and connection management
@freezed
class BleConnectionState with _$BleConnectionState {
  const factory BleConnectionState({
    @Default([]) List<ScannedDevice> scannedDevices,
    @Default(false) bool isAutoConnecting,
    String? connectionError,
    @Default(false) bool connectionLostDuringWorkout,
  }) = _BleConnectionState;
}
