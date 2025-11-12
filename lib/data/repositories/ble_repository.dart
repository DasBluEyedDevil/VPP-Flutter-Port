import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../ble/vitruvian_ble_manager.dart';
import '../ble/protocol_builder.dart';
import '../ble/constants.dart';
import '../ble/hardware_detection.dart';
import '../local/connection_logger.dart';
import '../../domain/models/connection_state.dart';
import '../../domain/models/workout_metric.dart';
import '../../domain/models/workout_parameters.dart';
import '../../domain/models/rep_notification.dart';
import '../../domain/models/handle_state.dart';

final logger = Logger();

/// BLE Repository - Manages Bluetooth communication with Vitruvian device
/// 
/// Ported from BleRepositoryImpl.kt
abstract class BleRepository {
  Stream<ConnectionState> get connectionState;
  Stream<WorkoutMetric> get monitorData;
  Stream<RepNotification> get repEvents;
  Stream<ScanResult> get scannedDevices;
  Stream<HandleState> get handleState;

  Future<Either<Exception, void>> startScanning();
  Future<void> stopScanning();
  Future<Either<Exception, void>> connectToDevice(String deviceAddress);
  Future<void> disconnect();
  Future<Either<Exception, void>> sendInitSequence();
  Future<Either<Exception, void>> startWorkout(WorkoutParameters params);
  Future<Either<Exception, void>> stopWorkout();
  Future<Either<Exception, void>> setColorScheme(int schemeIndex);
  Future<Either<Exception, void>> testOfficialAppProtocol();
  void enableHandleDetection(); // Start monitor polling for auto-start detection
  void enableJustLiftWaitingMode(); // Enable position-based handle detection for next exercise
}

/// Implementation of BleRepository
class BleRepositoryImpl implements BleRepository {
  final ConnectionLogger _connectionLogger;
  VitruvianBleManager? _bleManager;
  bool _isScanning = false;
  StreamSubscription<ConnectionState>? _connectionStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;

  // StateFlow equivalents using BehaviorSubject
  final _connectionStateSubject = BehaviorSubject<ConnectionState>.seeded(
    const ConnectionState.disconnected(),
  );
  final _handleStateSubject = BehaviorSubject<HandleState>.seeded(
    HandleState.released,
  );

  // SharedFlow equivalents using StreamController.broadcast()
  final _monitorDataController = StreamController<WorkoutMetric>.broadcast();
  final _repEventsController = StreamController<RepNotification>.broadcast();
  final _scannedDevicesController = StreamController<ScanResult>.broadcast();

  BleRepositoryImpl(this._connectionLogger);

  @override
  Stream<ConnectionState> get connectionState => _connectionStateSubject.stream;

  @override
  Stream<WorkoutMetric> get monitorData => _monitorDataController.stream;

  @override
  Stream<RepNotification> get repEvents => _repEventsController.stream;

  @override
  Stream<ScanResult> get scannedDevices => _scannedDevicesController.stream;

  @override
  Stream<HandleState> get handleState => _handleStateSubject.stream;

  @override
  Future<Either<Exception, void>> startScanning() async {
    try {
      logger.d("startScanning() called");
      _connectionLogger.logScanStarted();

      // Check if Bluetooth is available
      if (!await FlutterBluePlus.isSupported) {
        logger.e("Bluetooth not supported");
        _connectionLogger.logError("startScanning", null, null, "Bluetooth not supported");
        return left(Exception("Bluetooth not supported"));
      }

      if (!await FlutterBluePlus.adapterState.first.then((state) => state == BluetoothAdapterState.on)) {
        logger.e("Bluetooth is disabled");
        _connectionLogger.logError("startScanning", null, null, "Bluetooth is disabled");
        return left(Exception("Bluetooth is disabled"));
      }

      if (_isScanning) {
        logger.d("Already scanning, returning");
        return right(null);
      }

      _connectionStateSubject.add(const ConnectionState.scanning());
      logger.d("Set connection state to Scanning");

      // Start scanning
      _isScanning = true;
      await FlutterBluePlus.startScan(
        timeout: Duration(milliseconds: BleConstants.scanTimeoutMs),
      );

      // Listen for scan results
      _scanResultsSubscription?.cancel();
      _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
        for (final result in results) {
          final device = result.device;
          final name = result.advertisementData.advName;

          logger.d("BLE device found: name='$name', address=${device.remoteId}, rssi=${result.rssi}");

          // Only emit devices that match our filter
          if (name.startsWith(BleConstants.deviceNamePrefix)) {
            _connectionLogger.logDeviceFound(name, device.remoteId.toString());
            logger.d("Device matches filter, adding to list");
            _scannedDevicesController.add(result);
          }
        }
      });

      logger.d("BLE scan started successfully - looking for devices starting with '${BleConstants.deviceNamePrefix}'");

      // Auto-stop scanning after timeout
      Timer(Duration(milliseconds: BleConstants.scanTimeoutMs), () {
        if (_isScanning) {
          logger.d("Scan timeout reached (${BleConstants.scanTimeoutMs}ms), stopping scan");
          stopScanning();
        }
      });

      return right(null);
    } catch (e) {
      logger.e("Failed to start scanning", error: e);
      _connectionStateSubject.add(ConnectionState.error(message: "Failed to start scanning: ${e.toString()}"));
      return left(e as Exception);
    }
  }

  @override
  Future<void> stopScanning() async {
    try {
      if (!_isScanning) return;

      await FlutterBluePlus.stopScan();
      _isScanning = false;
      _scanResultsSubscription?.cancel();
      _scanResultsSubscription = null;

      if (_connectionStateSubject.value is Scanning) {
        _connectionStateSubject.add(const ConnectionState.disconnected());
      }

      logger.d("Stopped BLE scanning");
      _connectionLogger.logScanStopped();
    } catch (e) {
      logger.e("Error stopping scan", error: e);
      _connectionLogger.logError("stopScanning", null, null, e.toString());
    }
  }

  @override
  Future<Either<Exception, void>> connectToDevice(String deviceAddress) async {
    try {
      logger.d("connectToDevice() called for address: $deviceAddress");
      await stopScanning();

      // Find device from scanned devices or by address
      BluetoothDevice? device;
      await for (final results in FlutterBluePlus.scanResults) {
        for (final result in results) {
          if (result.device.remoteId.toString() == deviceAddress) {
            device = result.device;
            break;
          }
        }
        if (device != null) break;
      }

      // If not found in scan results, try to get by ID
      if (device == null) {
        try {
          device = BluetoothDevice.fromId(deviceAddress);
        } catch (e) {
          logger.e("Failed to get remote device for address: $deviceAddress");
          _connectionLogger.logConnectionFailed("Unknown", deviceAddress, "Device not found");
          return left(Exception("Device not found"));
        }
      }

      final deviceName = device.platformName.isNotEmpty ? device.platformName : "Vitruvian";
      logger.d("Got remote device: $deviceName ($deviceAddress)");
      _connectionLogger.logConnectionStarted(deviceName, deviceAddress);
      _connectionStateSubject.add(const ConnectionState.connecting());
      logger.d("Connection state set to Connecting");

      // Create BLE manager
      _bleManager = VitruvianBleManager();
      logger.d("Created VitruvianBleManager");

      // Set up connection observer
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = _bleManager!.connectionState.listen((status) {
        logger.d("BLE Manager connection status changed: $status");
        status.when(
          disconnected: () {
            logger.d("Device disconnected");
            _connectionLogger.logDisconnected(deviceName, deviceAddress);
            _connectionStateSubject.add(const ConnectionState.disconnected());
          },
          scanning: () {
            // Should not happen from BLE manager
          },
          connecting: () {
            // Already set above
          },
          connected: (name, address, hardwareModel) {
            logger.d("Device ready! Setting state to Connected");
            _connectionLogger.logConnectionSuccess(name, address);
            _connectionStateSubject.add(ConnectionState.connected(
              deviceName: name,
              deviceAddress: address,
              hardwareModel: hardwareModel,
            ));
          },
          error: (message, throwable) {
            logger.e("Connection error: $message");
            _connectionLogger.logConnectionFailed(deviceName, deviceAddress, message);
            _connectionStateSubject.add(ConnectionState.error(message: message, throwable: throwable));
          },
        );
      });

      // Collect monitor data and forward to repository stream
      _bleManager!.monitorData.listen((metric) {
        logger.d("BleRepository forwarding monitor metric: pos=(${metric.positionA},${metric.positionB})");
        _monitorDataController.add(metric);
      });

      // Collect rep events and forward to repository stream
      _bleManager!.repEvents.listen((repNotification) {
        logger.d("BleRepository forwarding rep event: top=${repNotification.topCounter}, complete=${repNotification.completeCounter}");
        _repEventsController.add(repNotification);
      });

      // Collect handle state and forward to repository stream
      _bleManager!.handleState.listen((state) {
        _handleStateSubject.add(state);
      });

      // Connect to device
      logger.d("Initiating connection to device...");
      final connected = await _bleManager!.connect(device);
      if (!connected) {
        throw Exception("Connection failed");
      }

      // Send INIT sequence after connection (LEDs acknowledge connection)
      logger.d("Device connected! Waiting 2 seconds before sending INIT...");
      Timer(const Duration(seconds: 2), () async {
        logger.d("Now sending INIT sequence...");
        final initResult = await sendInitSequence();
        if (initResult.isRight()) {
          logger.d("Device fully initialized and ready!");
        } else {
          logger.e("INIT sequence failed after connection: ${initResult.fold((l) => l.toString(), (r) => '')}");
        }
      });

      logger.d("Connecting to device: $deviceName ($deviceAddress)");
      return right(null);
    } catch (e) {
      logger.e("Failed to connect to device", error: e);
      _connectionStateSubject.add(ConnectionState.error(message: "Connection failed: ${e.toString()}"));
      return left(e as Exception);
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      logger.d("Disconnecting from device...");
      _bleManager?.stopPolling();
      await _bleManager?.disconnect();
      _bleManager = null;
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = null;
      _connectionStateSubject.add(const ConnectionState.disconnected());
      logger.d("Disconnected from device");
    } catch (e) {
      logger.e("Error disconnecting", error: e);
    }
  }

  @override
  Future<Either<Exception, void>> sendInitSequence() async {
    try {
      final currentState = _connectionStateSubject.value;
      String deviceName = "Unknown";
      String deviceAddress = "";
      currentState.when(
        disconnected: () {},
        scanning: () {},
        connecting: () {},
        connected: (name, address, hardwareModel) {
          deviceName = name;
          deviceAddress = address;
        },
        error: (message, throwable) {},
      );

      logger.d("=== Starting INIT sequence ===");
      _connectionLogger.logInitStarted(deviceName, deviceAddress);

      // Send initial command
      logger.d("Sending init command (4 bytes)...");
      final initCommand = ProtocolBuilder.buildInitCommand();
      _connectionLogger.logCommandSent("INIT_COMMAND", deviceName, deviceAddress, commandData: initCommand);
      await _bleManager?.sendCommand(initCommand);
      await Future.delayed(const Duration(milliseconds: 200));

      logger.d("Init command sent, waiting before preset...");

      // Send init preset
      logger.d("Sending init preset (34 bytes)...");
      final initPreset = ProtocolBuilder.buildInitPreset();
      _connectionLogger.logCommandSent("INIT_PRESET", deviceName, deviceAddress, commandData: initPreset);
      await _bleManager?.sendCommand(initPreset);
      await Future.delayed(const Duration(milliseconds: 200));

      logger.d("=== INIT sequence completed successfully ===");
      _connectionLogger.logInitSuccess(deviceName, deviceAddress);
      return right(null);
    } catch (e) {
      final currentState = _connectionStateSubject.value;
      String deviceName = "Unknown";
      String deviceAddress = "";
      currentState.when(
        disconnected: () {},
        scanning: () {},
        connecting: () {},
        connected: (name, address, hardwareModel) {
          deviceName = name;
          deviceAddress = address;
        },
        error: (message, throwable) {},
      );
      logger.e("Failed to send init sequence", error: e);
      _connectionLogger.logInitFailed(deviceName, deviceAddress, e.toString());
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, void>> startWorkout(WorkoutParameters params) async {
    try {
      final currentState = _connectionStateSubject.value;
      String? deviceName;
      String? deviceAddress;
      VitruvianModel? hardwareModel;
      currentState.when(
        disconnected: () {},
        scanning: () {},
        connecting: () {},
        connected: (name, address, model) {
          deviceName = name;
          deviceAddress = address;
          hardwareModel = model;
        },
        error: (message, throwable) {},
      );

      logger.d("Starting workout with type: ${params.workoutType}");
      logger.d("Hardware: ${hardwareModel?.displayName ?? "Unknown"}");

      // MATCH WEB APP EXACTLY:
      // - Program modes (Old School, Pump, TUT): Send ONLY program params (96 bytes)
      // - Echo mode: Send ONLY echo control (40 bytes)
      final workoutType = params.workoutType;
      workoutType.when(
        program: (mode) {
          logger.d("Program mode: sending ONLY program params (96 bytes)");
          final programFrame = ProtocolBuilder.buildProgramParams(params);

          final additionalInfo = "Mode=${mode.displayName}, "
              "Weight=${params.weightPerCableKg}kg, "
              "Reps=${params.reps}, "
              "JustLift=${params.isJustLift}, "
              "Progression=${params.progressionRegressionKg}kg"
              "${hardwareModel != null ? ", Hardware=${hardwareModel?.displayName}" : ""}";

          _connectionLogger.logCommandSent(
            "START_WORKOUT_PROGRAM",
            deviceName,
            deviceAddress,
            commandData: programFrame,
            additionalInfo: additionalInfo,
          );
          _bleManager?.sendCommand(programFrame);
        },
        echo: (level, eccentricLoad) {
          logger.d("Echo mode: sending ONLY echo control frame (40 bytes)");
          final echoFrame = ProtocolBuilder.buildEchoControl(
            level: level,
            warmupReps: params.warmupReps,
            targetReps: params.reps,
            isJustLift: params.isJustLift,
            eccentricPct: eccentricLoad.percentage,
          );
          _connectionLogger.logCommandSent(
            "START_WORKOUT_ECHO",
            deviceName,
            deviceAddress,
            commandData: echoFrame,
            additionalInfo: "Mode=Echo, Level=${level.levelValue}, Eccentric=${eccentricLoad.percentage}%, Reps=${params.reps}, JustLift=${params.isJustLift}",
          );
          _bleManager?.sendCommand(echoFrame);
        },
      );

      await Future.delayed(const Duration(milliseconds: 100));

      logger.d("Workout command sent successfully!");
      _connectionLogger.logCommandSuccess("START_WORKOUT", deviceName, deviceAddress);

      // Start monitor polling for workout data (100ms interval)
      logger.d("Starting monitor polling for workout...");
      _connectionLogger.logPollingStarted("MONITOR", deviceName, deviceAddress);
      _bleManager?.startMonitorPolling();

      return right(null);
    } catch (e) {
      final currentState = _connectionStateSubject.value;
      final deviceName = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => name,
        orElse: () => null,
      );
      final deviceAddress = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => address,
        orElse: () => null,
      );
      logger.e("Failed to start workout", error: e);
      _connectionLogger.logCommandFailed("START_WORKOUT", deviceName, deviceAddress, e.toString());
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, void>> stopWorkout() async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final currentState = _connectionStateSubject.value;
      final deviceName = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => name,
        orElse: () => null,
      );
      final deviceAddress = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => address,
        orElse: () => null,
      );

      logger.d("STOP_DEBUG: ============================================");
      logger.d("STOP_DEBUG: stopWorkout() called at timestamp: $timestamp");
      logger.d("STOP_DEBUG: ============================================");

      // CRITICAL SAFETY: Stop all polling BEFORE sending INIT command
      final beforePollingStop = DateTime.now().millisecondsSinceEpoch;
      logger.d("STOP_DEBUG: [$beforePollingStop] BEFORE stopping polling jobs");
      logger.d("STOP_DEBUG: Cancelling polling jobs...");
      _connectionLogger.logPollingStopped("ALL", deviceName, deviceAddress);
      _bleManager?.stopPolling();
      final afterPollingStop = DateTime.now().millisecondsSinceEpoch;
      logger.d("STOP_DEBUG: [$afterPollingStop] AFTER stopping polling jobs (took ${afterPollingStop - beforePollingStop}ms)");

      // Send INIT command to stop workout and release resistance
      final initCommand = ProtocolBuilder.buildInitCommand();
      final beforeInitSend = DateTime.now().millisecondsSinceEpoch;
      logger.d("STOP_DEBUG: [$beforeInitSend] BEFORE sending INIT command");
      logger.d("STOP_DEBUG: INIT command bytes: ${initCommand.map((b) => "0x${b.toRadixString(16).padLeft(2, '0')}").join(" ")}");
      logger.d("STOP_DEBUG: INIT command size: ${initCommand.length} bytes");
      logger.d("STOP_DEBUG: Sending INIT command to release tension...");
      _connectionLogger.logCommandSent("STOP_WORKOUT", deviceName, deviceAddress, commandData: initCommand);
      await _bleManager?.sendCommand(initCommand);
      final afterInitSend = DateTime.now().millisecondsSinceEpoch;
      logger.d("STOP_DEBUG: [$afterInitSend] AFTER sending INIT command (took ${afterInitSend - beforeInitSend}ms)");
      logger.d("STOP_DEBUG: INIT command sent successfully");

      final finalTimestamp = DateTime.now().millisecondsSinceEpoch;
      logger.d("STOP_DEBUG: [$finalTimestamp] Workout stopped - Total stopWorkout() time: ${finalTimestamp - timestamp}ms");
      logger.d("STOP_DEBUG: ============================================");
      _connectionLogger.logCommandSuccess("STOP_WORKOUT", deviceName, deviceAddress);
      return right(null);
    } catch (e) {
      final currentState = _connectionStateSubject.value;
      final deviceName = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => name,
        orElse: () => null,
      );
      final deviceAddress = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => address,
        orElse: () => null,
      );
      logger.e("STOP_DEBUG: FAILED to stop workout", error: e);
      _connectionLogger.logCommandFailed("STOP_WORKOUT", deviceName, deviceAddress, e.toString());
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, void>> setColorScheme(int schemeIndex) async {
    try {
      final currentState = _connectionStateSubject.value;
      final deviceName = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => name,
        orElse: () => null,
      );
      final deviceAddress = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => address,
        orElse: () => null,
      );

      final colorFrame = ProtocolBuilder.buildColorSchemeCommand(schemeIndex);
      _connectionLogger.logCommandSent(
        "SET_LED_COLOR",
        deviceName,
        deviceAddress,
        commandData: colorFrame,
        additionalInfo: "Scheme=$schemeIndex",
      );
      await _bleManager?.sendCommand(colorFrame);

      logger.d("Color scheme set to: $schemeIndex");
      _connectionLogger.logCommandSuccess("SET_LED_COLOR", deviceName, deviceAddress);
      return right(null);
    } catch (e) {
      final currentState = _connectionStateSubject.value;
      final deviceName = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => name,
        orElse: () => null,
      );
      final deviceAddress = currentState.maybeWhen(
        connected: (name, address, hardwareModel) => address,
        orElse: () => null,
      );
      logger.e("Failed to set color scheme", error: e);
      _connectionLogger.logCommandFailed("SET_LED_COLOR", deviceName, deviceAddress, e.toString());
      return left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, void>> testOfficialAppProtocol() async {
    try {
      logger.d("Repository: Starting official app protocol test");
      // TODO: Implement testOfficialAppProtocol in VitruvianBleManager
      // await _bleManager?.testOfficialAppProtocol();
      return right(null);
    } catch (e) {
      logger.e("Failed to test official app protocol", error: e);
      return left(e as Exception);
    }
  }

  @override
  void enableHandleDetection() {
    logger.d("Enabling handle detection - starting monitor polling for auto-start");
    _bleManager?.startMonitorPolling();
  }

  @override
  void enableJustLiftWaitingMode() {
    logger.d("Enabling Just Lift waiting mode - position-based handle detection");
    // TODO: Implement enableJustLiftWaitingMode in VitruvianBleManager
    // _bleManager?.enableJustLiftWaitingMode();
  }

  void dispose() {
    _connectionStateSubject.close();
    _handleStateSubject.close();
    _monitorDataController.close();
    _repEventsController.close();
    _scannedDevicesController.close();
    _connectionStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
  }
}
