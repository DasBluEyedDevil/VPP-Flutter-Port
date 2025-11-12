import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../data/repositories/ble_repository.dart';
import '../../domain/models/connection_state.dart';
import '../../domain/models/scanned_device.dart';
import 'ble_connection_state.dart';

final logger = Logger();

/// Provider for BLE repository instance
/// 
/// Must be overridden in main.dart with actual BleRepositoryImpl
final bleRepositoryProvider = Provider<BleRepository>((ref) {
  throw UnimplementedError('bleRepositoryProvider must be overridden');
});

/// Stream provider for connection state from repository
/// 
/// Directly exposes ConnectionState stream from BleRepository
final connectionStateProvider = StreamProvider<ConnectionState>((ref) {
  final bleRepo = ref.watch(bleRepositoryProvider);
  return bleRepo.connectionState;
});

/// StateNotifier for BLE connection management
/// 
/// Manages scanning, connection, and auto-connect state
/// Ported from MainViewModel.kt BLE connection methods (lines 542-689)
class BleConnectionNotifier extends StateNotifier<BleConnectionState> {
  final BleRepository _bleRepository;

  StreamSubscription<ScanResult>? _scanSubscription;

  BleConnectionNotifier(this._bleRepository)
      : super(const BleConnectionState());

  /// Start scanning for BLE devices
  /// 
  /// Ported from MainViewModel.kt startScanning() (lines 542-555)
  Future<void> startScanning() async {
    state = state.copyWith(scannedDevices: []);

    final result = await _bleRepository.startScanning();
    result.fold(
      (error) => logger.e('Failed to start BLE scan: $error'),
      (_) {
        logger.d('BLE scan started successfully');
        // Subscribe to scanned devices stream
        // Convert ScanResult to ScannedDevice
        _scanSubscription?.cancel();
        _scanSubscription = _bleRepository.scannedDevices.listen((scanResult) {
          final device = ScannedDevice(
            name: scanResult.device.platformName.isNotEmpty
                ? scanResult.device.platformName
                : 'Unknown Device',
            address: scanResult.device.remoteId.str,
            rssi: scanResult.rssi,
          );

          // Add to list if not already present (by address)
          final currentDevices = List<ScannedDevice>.from(state.scannedDevices);
          final existingIndex = currentDevices.indexWhere(
            (d) => d.address == device.address,
          );

          if (existingIndex >= 0) {
            // Update existing device (RSSI may have changed)
            currentDevices[existingIndex] = device;
          } else {
            // Add new device
            currentDevices.add(device);
          }

          state = state.copyWith(scannedDevices: currentDevices);
        });
      },
    );
  }

  /// Stop scanning for BLE devices
  /// 
  /// Ported from MainViewModel.kt stopScanning() (lines 556-561)
  Future<void> stopScanning() async {
    await _bleRepository.stopScanning();
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    logger.d('BLE scan stopped');
  }

  /// Connect to a specific device by address
  /// 
  /// Ported from MainViewModel.kt connectToDevice() (lines 562-585)
  Future<void> connectToDevice(String deviceAddress) async {
    await stopScanning();
    state = state.copyWith(connectionError: null);

    final result = await _bleRepository.connectToDevice(deviceAddress);
    result.fold(
      (error) {
        final errorMsg = error.toString();
        state = state.copyWith(connectionError: errorMsg);
        logger.e('Connection failed: $errorMsg');
      },
      (_) => logger.d('Connection initiated for $deviceAddress'),
    );
  }

  /// Ensure connection with auto-connect logic
  /// 
  /// Ported from MainViewModel.kt ensureConnection() (lines 586-675)
  /// 
  /// Starts scanning, waits for first device, connects, and waits for connection.
  /// Times out after 30 seconds if no device found or connection fails.
  Future<void> ensureConnection({
    required VoidCallback onConnected,
    required VoidCallback onFailed,
  }) async {
    // Check if already connected
    final connectionStateStream = _bleRepository.connectionState;
    final currentState = await connectionStateStream.first;
    if (currentState is Connected) {
      onConnected();
      return;
    }

    state = state.copyWith(
      isAutoConnecting: true,
      connectionError: null,
    );

    // Start scanning
    await startScanning();

    // Wait for device with 30s timeout
    try {
      await Future.any([
        _waitForDeviceAndConnect(onConnected),
        Future.delayed(const Duration(seconds: 30)).then(
          (_) => throw TimeoutException('Auto-connect timeout: No devices found'),
        ),
      ]);
    } on TimeoutException catch (e) {
      state = state.copyWith(
        isAutoConnecting: false,
        connectionError: e.toString(),
      );
      await stopScanning();
      onFailed();
    } catch (e) {
      state = state.copyWith(
        isAutoConnecting: false,
        connectionError: e.toString(),
      );
      await stopScanning();
      onFailed();
    }
  }

  /// Helper method to wait for device and connect
  /// 
  /// Waits for first scanned device, connects, then waits for connection state
  Future<void> _waitForDeviceAndConnect(VoidCallback onConnected) async {
    // Wait for first scanned device to appear in state
    // The _scanSubscription set up by startScanning() will update state
    // Poll state until we have at least one device (with timeout)
    const pollInterval = Duration(milliseconds: 200);
    const maxWaitTime = Duration(seconds: 25);
    final startTime = DateTime.now();

    while (state.scannedDevices.isEmpty) {
      if (DateTime.now().difference(startTime) > maxWaitTime) {
        throw TimeoutException('No devices found');
      }
      await Future.delayed(pollInterval);
    }

    final device = state.scannedDevices.first;
    await connectToDevice(device.address);

    // Wait for connection state to become Connected
    final connectionCompleter = Completer<void>();
    late StreamSubscription<ConnectionState> connectionSubscription;

    connectionSubscription = _bleRepository.connectionState.listen((connState) {
      if (connState is Connected && !connectionCompleter.isCompleted) {
        state = state.copyWith(isAutoConnecting: false);
        connectionCompleter.complete();
        onConnected();
      }
    });

    try {
      await connectionCompleter.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('Connection timeout'),
      );
    } finally {
      await connectionSubscription.cancel();
    }
  }

  /// Cancel auto-connecting process
  /// 
  /// Ported from MainViewModel.kt cancelAutoConnecting() (lines 676-682)
  Future<void> cancelAutoConnecting() async {
    state = state.copyWith(isAutoConnecting: false);
    await stopScanning();
    await disconnect();
    logger.d('Auto-connect cancelled');
  }

  /// Dismiss connection lost alert
  /// 
  /// Ported from MainViewModel.kt dismissConnectionLostAlert() (lines 683-688)
  void dismissConnectionLostAlert() {
    state = state.copyWith(connectionLostDuringWorkout: false);
  }

  /// Disconnect from current device
  /// 
  /// Ported from MainViewModel.kt disconnect() (line 689)
  Future<void> disconnect() async {
    await _bleRepository.disconnect();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }
}

/// Provider for BLE connection notifier
final bleConnectionProvider = StateNotifierProvider<BleConnectionNotifier, BleConnectionState>((ref) {
  final bleRepo = ref.watch(bleRepositoryProvider);
  return BleConnectionNotifier(bleRepo);
});

/// Actions provider for BLE operations
/// 
/// Provides convenient access to BLE connection methods
final bleConnectionActionsProvider = Provider<BleConnectionActions>((ref) {
  final notifier = ref.watch(bleConnectionProvider.notifier);
  return BleConnectionActions(notifier);
});

/// Actions class for BLE connection operations
/// 
/// Exposes all BLE connection methods for use in UI
class BleConnectionActions {
  final BleConnectionNotifier _notifier;

  BleConnectionActions(this._notifier);

  Future<void> startScanning() => _notifier.startScanning();
  Future<void> stopScanning() => _notifier.stopScanning();
  Future<void> connectToDevice(String address) => _notifier.connectToDevice(address);
  Future<void> ensureConnection({
    required VoidCallback onConnected,
    required VoidCallback onFailed,
  }) =>
      _notifier.ensureConnection(
        onConnected: onConnected,
        onFailed: onFailed,
      );
  Future<void> cancelAutoConnecting() => _notifier.cancelAutoConnecting();
  void dismissConnectionLostAlert() => _notifier.dismissConnectionLostAlert();
  Future<void> disconnect() => _notifier.disconnect();
}
