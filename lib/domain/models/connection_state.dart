import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/ble/hardware_detection.dart';

part 'connection_state.freezed.dart';

/// Connection state sealed class representing BLE connection states
@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState.disconnected() = Disconnected;
  const factory ConnectionState.scanning() = Scanning;
  const factory ConnectionState.connecting() = Connecting;
  const factory ConnectionState.connected({
    required String deviceName,
    required String deviceAddress,
    required VitruvianModel hardwareModel,
  }) = Connected;
  const factory ConnectionState.error({
    required String message,
    Object? throwable,
  }) = ConnectionError;
}
