import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';
import 'constants.dart';
import '../../domain/models/workout_metric.dart';
import '../../domain/models/connection_state.dart';
import 'hardware_detection.dart';
import '../../domain/models/handle_state.dart';
import '../../domain/models/rep_notification.dart';

/// Vitruvian BLE Manager - Core BLE communication layer
/// 
/// Manages connection, polling, and data parsing for Vitruvian resistance training devices.
/// 
/// CRITICAL: This is the foundation of all BLE communication. Every byte of data parsing
/// must match exactly. Polling timing must be precise (100Hz = 100ms).
/// 
/// Ported from VitruvianBleManager.kt (745 lines)
class VitruvianBleManager {
  // Logger for debugging and monitoring
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      printTime: true,
    ),
  );

  // Handle state detection thresholds (from Kotlin source)
  static const double handleGrabbedThreshold = 8.0;
  static const double handleRestThreshold = 2.5;
  static const double velocityThreshold = 100.0;
  static const int positionSpikeThreshold = 50000;
  
  // Polling intervals
  static const Duration monitorPollInterval = Duration(milliseconds: 100); // 100Hz
  static const Duration propertyPollInterval = Duration(milliseconds: 500);
  
  // MTU requirement (minimum 247 bytes for 96-byte frames)
  static const int requiredMtu = 247;
  
  // Connection timeout
  static const Duration connectionTimeout = Duration(milliseconds: BleConstants.connectionTimeoutMs);
  static const Duration gattOperationTimeout = Duration(milliseconds: BleConstants.gattOperationTimeoutMs);
  
  // Device and characteristics
  BluetoothDevice? _device;
  BluetoothCharacteristic? _nusRxCharacteristic;
  BluetoothCharacteristic? _monitorCharacteristic;
  BluetoothCharacteristic? _propertyCharacteristic;
  BluetoothCharacteristic? _repNotifyCharacteristic;
  
  // Polling timers
  Timer? _monitorPollTimer;
  Timer? _propertyPollTimer;
  
  // Stream controllers
  final _connectionStateController = StreamController<ConnectionState>.broadcast();
  final _monitorDataController = StreamController<WorkoutMetric>.broadcast();
  final _repEventsController = StreamController<RepNotification>.broadcast();
  final _handleStateController = StreamController<HandleState>.broadcast();
  
  // Handle state tracking
  HandleState _currentHandleState = HandleState.released;
  double _lastGoodPositionA = 0.0;
  double _lastGoodPositionB = 0.0;
  
  // Connection state
  ConnectionState _currentConnectionStatus = const ConnectionState.disconnected();
  bool _isInitialized = false;
  
  // Stream subscriptions
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;
  StreamSubscription<List<int>>? _repNotifySubscription;
  
  /// Stream of connection status changes
  Stream<ConnectionState> get connectionState => _connectionStateController.stream;
  
  /// Stream of workout metrics (100Hz polling)
  Stream<WorkoutMetric> get monitorData => _monitorDataController.stream;
  
  /// Stream of rep notification events
  Stream<RepNotification> get repEvents => _repEventsController.stream;
  
  /// Stream of handle state changes
  Stream<HandleState> get handleState => _handleStateController.stream;
  
  /// Current connection status
  ConnectionState get currentConnectionStatus => _currentConnectionStatus;
  
  /// Whether device is connected and initialized
  bool get isConnected => _device != null && _isInitialized;
  
  /// Current connected device
  BluetoothDevice? get device => _device;
  
  /// Scan for Vitruvian devices
  /// 
  /// Returns the first device found with name prefix matching BleConstants.deviceNamePrefix
  Future<BluetoothDevice?> scanForDevice({Duration timeout = const Duration(seconds: 30)}) async {
    try {
      _logger.d('Starting scan for devices...');
      _updateConnectionStatus(const ConnectionState.scanning());
      
      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: timeout,
        withServices: [],
      );
      
      // Listen for scan results
      await for (final result in FlutterBluePlus.scanResults) {
        for (final scanResult in result) {
          final device = scanResult.device;
          final name = scanResult.advertisementData.advName;

          _logger.d('Found device: $name (${device.remoteId})');
          
          if (name.startsWith(BleConstants.deviceNamePrefix)) {
            _logger.i('Found Vitruvian device: $name');
            await FlutterBluePlus.stopScan();
            return device;
          }
        }
      }
      
      await FlutterBluePlus.stopScan();
      return null;
    } catch (e) {
      _logger.e('Scan error: $e');
      await FlutterBluePlus.stopScan();
      return null;
    }
  }
  
  /// Connect to a Bluetooth device
  /// 
  /// Establishes connection, negotiates MTU, discovers services, and initializes characteristics.
  Future<bool> connect(BluetoothDevice device) async {
    if (_device != null && _device!.remoteId == device.remoteId && _isInitialized) {
      _logger.i('Already connected to ${device.remoteId}');
      return true;
    }
    
    try {
      _updateConnectionStatus(const ConnectionState.connecting());
      _device = device;
      
      _logger.i('Connecting to ${device.remoteId}...');
      
      // Connect with timeout
      await device.connect(
        timeout: connectionTimeout,
        autoConnect: false,
      );
      
      _logger.d('Connected, discovering services...');
      
      // Discover services
      final services = await device.discoverServices();
      _logger.d('Discovered ${services.length} services');
      
      // Find NUS service
      BluetoothService? nusService;
      for (final service in services) {
        if (service.uuid == BleConstants.nusServiceUuid) {
          nusService = service;
          break;
        }
      }
      
      if (nusService == null) {
        throw Exception('NUS service not found');
      }
      
      _logger.d('Found NUS service');
      
      // Find required characteristics
      _nusRxCharacteristic = _findCharacteristic(
        nusService,
        BleConstants.nusRxCharUuid,
        'NUS RX',
      );
      
      _monitorCharacteristic = _findCharacteristic(
        nusService,
        BleConstants.monitorCharUuid,
        'Monitor',
      );
      
      _propertyCharacteristic = _findCharacteristic(
        nusService,
        BleConstants.propertyCharUuid,
        'Property',
      );
      
      _repNotifyCharacteristic = _findCharacteristic(
        nusService,
        BleConstants.repNotifyCharUuid,
        'Rep Notify',
      );
      
      if (_nusRxCharacteristic == null ||
          _monitorCharacteristic == null ||
          _propertyCharacteristic == null ||
          _repNotifyCharacteristic == null) {
        throw Exception('Required characteristics not found');
      }
      
      _logger.d('All required characteristics found');
      
      // Request MTU (critical for 96-byte frames)
      _logger.d('Requesting MTU: $requiredMtu bytes');
      await device.requestMtu(requiredMtu);
      _logger.d('MTU negotiation complete');
      
      // Enable notifications for rep notify characteristic
      await _repNotifyCharacteristic!.setNotifyValue(true);
      _logger.d('Rep notify notifications enabled');
      
      // Subscribe to rep notify stream
      _repNotifySubscription?.cancel();
      _repNotifySubscription = _repNotifyCharacteristic!.lastValueStream.listen(
        _handleRepNotification,
        onError: (error) {
          _logger.e('Rep notify stream error: $error');
        },
      );
      
      // Subscribe to connection state changes
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = device.connectionState.listen(
        (state) {
          _logger.d('Connection state changed: $state');
          if (state == BluetoothConnectionState.disconnected) {
            _handleDisconnection();
          }
        },
      );
      
      // Check if required service is supported
      if (!await isRequiredServiceSupported()) {
        throw Exception('Required service not supported');
      }
      
      _isInitialized = true;
      // Get device info for connected state
      final deviceName = device.platformName.isNotEmpty 
          ? device.platformName 
          : device.remoteId.toString();
      final deviceAddress = device.remoteId.toString();
      final hardwareModel = HardwareDetection.detectModel(deviceName);
      _updateConnectionStatus(ConnectionState.connected(
        deviceName: deviceName,
        deviceAddress: deviceAddress,
        hardwareModel: hardwareModel,
      ));
      
      _logger.i('Connection initialized successfully');
      return true;
    } catch (e) {
      _logger.e('Connection error: $e');
      _updateConnectionStatus(ConnectionState.error(message: e.toString()));
      await disconnect();
      return false;
    }
  }
  
  /// Find a characteristic in a service
  BluetoothCharacteristic? _findCharacteristic(
    BluetoothService service,
    Guid uuid,
    String name,
  ) {
    try {
      final characteristic = service.characteristics.firstWhere(
        (c) => c.uuid == uuid,
        orElse: () => throw StateError('Characteristic not found'),
      );
      _logger.d('Found $name characteristic');
      return characteristic;
    } catch (e) {
      _logger.w('$name characteristic not found: $e');
      return null;
    }
  }
  
  /// Check if required service is supported
  Future<bool> isRequiredServiceSupported() async {
    if (_device == null) return false;
    
    try {
      final services = await _device!.discoverServices();
      return services.any((service) => service.uuid == BleConstants.nusServiceUuid);
    } catch (e) {
      _logger.e('Error checking service support: $e');
      return false;
    }
  }
  
  /// Initialize device communication
  /// 
  /// Enables notifications and starts polling.
  Future<bool> initialize() async {
    if (!_isInitialized) {
      _logger.w('Cannot initialize: not connected');
      return false;
    }
    
    try {
      _logger.i('Initializing...');
      
      // Start polling
      startMonitorPolling();
      startPropertyPolling();
      
      _logger.i('Initialization complete');
      return true;
    } catch (e) {
      _logger.e('Initialization error: $e');
      return false;
    }
  }
  
  /// Start monitor polling at 100Hz (every 100ms)
  void startMonitorPolling() {
    if (_monitorPollTimer != null && _monitorPollTimer!.isActive) {
      _logger.d('Monitor polling already active');
      return;
    }
    
    if (_monitorCharacteristic == null) {
      _logger.w('Cannot start monitor polling: characteristic not available');
      return;
    }
    
    _logger.i('Starting monitor polling @ 100Hz');
    
    _monitorPollTimer = Timer.periodic(monitorPollInterval, (timer) async {
      try {
        if (_monitorCharacteristic == null) {
          timer.cancel();
          return;
        }
        
        final data = await _monitorCharacteristic!.read()
          .timeout(gattOperationTimeout);
        
        if (data.isNotEmpty) {
          _handleMonitorData(data);
        }
      } catch (e) {
        _logger.w('Monitor poll error: $e');
        // Don't cancel timer on error, keep trying
      }
    });
  }
  
  /// Start property polling at 2Hz (every 500ms)
  void startPropertyPolling() {
    if (_propertyPollTimer != null && _propertyPollTimer!.isActive) {
      _logger.d('Property polling already active');
      return;
    }
    
    if (_propertyCharacteristic == null) {
      _logger.w('Cannot start property polling: characteristic not available');
      return;
    }
    
    _logger.i('Starting property polling @ 2Hz');
    
    _propertyPollTimer = Timer.periodic(propertyPollInterval, (timer) async {
      try {
        if (_propertyCharacteristic == null) {
          timer.cancel();
          return;
        }
        
        // Read property characteristic (keep-alive mechanism)
        await _propertyCharacteristic!.read()
          .timeout(gattOperationTimeout);
      } catch (e) {
        _logger.w('Property poll error: $e');
        // Don't cancel timer on error, keep trying
      }
    });
  }
  
  /// Stop all polling
  void stopPolling() {
    _logger.i('Stopping all polling');
    
    _monitorPollTimer?.cancel();
    _monitorPollTimer = null;
    
    _propertyPollTimer?.cancel();
    _propertyPollTimer = null;
  }
  
  /// Handle monitor data (96 bytes)
  /// 
  /// Parses ByteBuffer data into WorkoutMetric and emits to stream.
  void _handleMonitorData(List<int> data) {
    if (data.length < 96) {
      _logger.w('Monitor data too short: ${data.length} bytes');
      return;
    }
    
    try {
      final byteData = ByteData.view(Uint8List.fromList(data).buffer);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      // Parse data (little endian)
      // Position offsets from Kotlin source analysis
      final loadA = byteData.getFloat32(0x00, Endian.little);
      final loadB = byteData.getFloat32(0x04, Endian.little);
      final positionA = byteData.getInt32(0x08, Endian.little);
      final positionB = byteData.getInt32(0x0C, Endian.little);
      final ticks = byteData.getInt32(0x10, Endian.little);
      final velocityA = byteData.getFloat32(0x14, Endian.little);
      final velocityB = byteData.getFloat32(0x18, Endian.little);
      final power = byteData.getFloat32(0x1C, Endian.little);
      
      // Filter position spikes (> 50000)
      double filteredPositionA = positionA.toDouble();
      double filteredPositionB = positionB.toDouble();
      
      if (positionA.abs() > positionSpikeThreshold) {
        filteredPositionA = _lastGoodPositionA;
        _logger.d('Filtered positionA spike: $positionA -> $_lastGoodPositionA');
      } else {
        _lastGoodPositionA = filteredPositionA;
      }
      
      if (positionB.abs() > positionSpikeThreshold) {
        filteredPositionB = _lastGoodPositionB;
        _logger.d('Filtered positionB spike: $positionB -> $_lastGoodPositionB');
      } else {
        _lastGoodPositionB = filteredPositionB;
      }
      
      final metric = WorkoutMetric(
        timestamp: timestamp,
        loadA: loadA,
        loadB: loadB,
        positionA: filteredPositionA.toInt(),
        positionB: filteredPositionB.toInt(),
        ticks: ticks,
        velocityA: velocityA,
        velocityB: velocityB,
        power: power,
      );
      
      // Emit metric
      if (!_monitorDataController.isClosed) {
        _monitorDataController.add(metric);
      }
      
      // Analyze handle state
      _analyzeHandleState(metric);
    } catch (e) {
      _logger.e('Error parsing monitor data: $e');
    }
  }
  
  /// Handle rep notification data
  /// 
  /// Parses rep counter data from RepNotify characteristic.
  void _handleRepNotification(List<int> data) {
    if (data.length < 6) {
      _logger.w('Rep notification data too short: ${data.length} bytes');
      return;
    }
    
    try {
      final byteData = ByteData.view(Uint8List.fromList(data).buffer);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      // Parse rep counters (little endian u16 array)
      // Format: [topCounter, ?, completeCounter]
      final topCounter = byteData.getUint16(0x00, Endian.little);
      final completeCounter = byteData.getUint16(0x04, Endian.little);
      
      final notification = RepNotification(
        topCounter: topCounter,
        completeCounter: completeCounter,
        rawData: List.unmodifiable(data),
        timestamp: timestamp,
      );
      
      _logger.d('Rep notification: top=$topCounter, complete=$completeCounter');
      
      // Emit notification
      if (!_repEventsController.isClosed) {
        _repEventsController.add(notification);
      }
    } catch (e) {
      _logger.e('Error parsing rep notification: $e');
    }
  }
  
  /// Analyze handle state using hysteresis algorithm
  /// 
  /// Handles grabbed = position > 8.0 AND velocity > 100
  /// Handles released = position < 2.5
  void _analyzeHandleState(WorkoutMetric metric) {
    final avgPosition = metric.averagePosition;
    final avgVelocity = metric.averageVelocity.abs();
    
    HandleState newState = _currentHandleState;
    
    switch (_currentHandleState) {
      case HandleState.released:
        // Transition to grabbed: position > threshold AND velocity > threshold
        if (avgPosition > handleGrabbedThreshold && avgVelocity > velocityThreshold) {
          newState = HandleState.grabbed;
        }
        break;
        
      case HandleState.grabbed:
        // Transition to moving: velocity > threshold
        if (avgVelocity > velocityThreshold) {
          newState = HandleState.moving;
        }
        // Transition back to released: position < rest threshold
        else if (avgPosition < handleRestThreshold) {
          newState = HandleState.released;
        }
        break;
        
      case HandleState.moving:
        // Transition to released: position < rest threshold (priority)
        if (avgPosition < handleRestThreshold) {
          newState = HandleState.released;
        }
        // Transition to grabbed: velocity drops below threshold
        else if (avgVelocity <= velocityThreshold) {
          newState = HandleState.grabbed;
        }
        break;
    }
    
    if (newState != _currentHandleState) {
      _logger.i('Handle state changed: $_currentHandleState -> $newState '
          '(position=$avgPosition, velocity=$avgVelocity)');
      _currentHandleState = newState;
      
      if (!_handleStateController.isClosed) {
        _handleStateController.add(newState);
      }
    }
  }
  
  /// Enable Just Lift waiting mode
  /// 
  /// Resets handle state to released.
  void enableJustLiftWaitingMode() {
    _logger.i('Enabling Just Lift waiting mode');
    _currentHandleState = HandleState.released;
    if (!_handleStateController.isClosed) {
      _handleStateController.add(HandleState.released);
    }
  }
  
  /// Send command to device
  /// 
  /// Writes data to NUS RX characteristic.
  Future<bool> sendCommand(Uint8List data) async {
    if (_nusRxCharacteristic == null) {
      _logger.w('Cannot send command: NUS RX characteristic not available');
      return false;
    }
    
    if (!_isInitialized) {
      _logger.w('Cannot send command: not initialized');
      return false;
    }
    
    try {
      _logger.d('Sending command: ${data.length} bytes');
      
      await _nusRxCharacteristic!.write(
        data,
        withoutResponse: false,
      ).timeout(gattOperationTimeout);
      
      _logger.d('Command sent successfully');
      return true;
    } catch (e) {
      _logger.e('Error sending command: $e');
      return false;
    }
  }
  
  /// Update connection status and emit to stream
  void _updateConnectionStatus(ConnectionState status) {
    if (_currentConnectionStatus == status) return;
    
    _currentConnectionStatus = status;
    
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(status);
    }
  }
  
  /// Handle disconnection
  void _handleDisconnection() {
    _logger.i('Device disconnected');
    
    stopPolling();
    _isInitialized = false;
    _updateConnectionStatus(const ConnectionState.disconnected());
    
    // Reset handle state
    _currentHandleState = HandleState.released;
  }
  
  /// Disconnect from device
  Future<void> disconnect() async {
    _logger.i('Disconnecting...');
    
    stopPolling();
    
    _repNotifySubscription?.cancel();
    _repNotifySubscription = null;
    
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = null;
    
    if (_repNotifyCharacteristic != null) {
      try {
        await _repNotifyCharacteristic!.setNotifyValue(false);
      } catch (e) {
        _logger.w('Error disabling notifications: $e');
      }
    }
    
    if (_device != null) {
      try {
        await _device!.disconnect();
      } catch (e) {
        _logger.w('Error disconnecting: $e');
      }
    }
    
    _device = null;
    _nusRxCharacteristic = null;
    _monitorCharacteristic = null;
    _propertyCharacteristic = null;
    _repNotifyCharacteristic = null;
    _isInitialized = false;
    
    _updateConnectionStatus(const ConnectionState.disconnected());
    
    _logger.i('Disconnected');
  }
  
  /// Cleanup all resources
  /// 
  /// Cancels all timers and subscriptions, closes streams.
  Future<void> cleanup() async {
    _logger.i('Cleaning up...');
    
    await disconnect();
    
    await _connectionStateController.close();
    await _monitorDataController.close();
    await _repEventsController.close();
    await _handleStateController.close();
    
    _logger.i('Cleanup complete');
  }
}
