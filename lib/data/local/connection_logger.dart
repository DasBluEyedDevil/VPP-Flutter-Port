import 'dart:async';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/daos/connection_log_dao.dart';
import '../ble/device_info.dart';
import '../ble/hardware_detection.dart';

final logger = Logger();

/// Log levels matching standard logging practices
enum Level {
  debug,
  info,
  warning,
  error;

  String get name {
    switch (this) {
      case Level.debug:
        return 'DEBUG';
      case Level.info:
        return 'INFO';
      case Level.warning:
        return 'WARNING';
      case Level.error:
        return 'ERROR';
    }
  }
}

/// Standard BLE event types for categorization
class EventType {
    // System info
    static const String systemInfo = 'SYSTEM_INFO';
    static const String vitruvianDeviceInfo = 'VITRUVIAN_DEVICE_INFO';

    // Connection events
    static const String scanStarted = 'SCAN_STARTED';
    static const String scanStopped = 'SCAN_STOPPED';
    static const String deviceFound = 'DEVICE_FOUND';
    static const String connectionStarted = 'CONNECTION_STARTED';
    static const String connectionSuccess = 'CONNECTION_SUCCESS';
    static const String connectionFailed = 'CONNECTION_FAILED';
    static const String disconnectionStarted = 'DISCONNECTION_STARTED';
    static const String disconnected = 'DISCONNECTED';
    static const String connectionLost = 'CONNECTION_LOST';

    // Service discovery
    static const String servicesDiscovering = 'SERVICES_DISCOVERING';
    static const String servicesDiscovered = 'SERVICES_DISCOVERED';
    static const String servicesDiscoveryFailed = 'SERVICES_DISCOVERY_FAILED';

    // Initialization
    static const String initStarted = 'INIT_STARTED';
    static const String initSuccess = 'INIT_SUCCESS';
    static const String initFailed = 'INIT_FAILED';

    // Commands
    static const String commandSent = 'COMMAND_SENT';
    static const String commandSuccess = 'COMMAND_SUCCESS';
    static const String commandFailed = 'COMMAND_FAILED';

    // Data polling
    static const String pollingStarted = 'POLLING_STARTED';
    static const String pollingStopped = 'POLLING_STOPPED';
    static const String dataReceived = 'DATA_RECEIVED';
    static const String dataParseError = 'DATA_PARSE_ERROR';

    // Errors
    static const String timeout = 'TIMEOUT';
    static const String writeError = 'WRITE_ERROR';
    static const String readError = 'READ_ERROR';
    static const String unknownError = 'UNKNOWN_ERROR';
}

/// Centralized logging service for BLE connection debugging
///
/// Logs events to both:
/// - Logger (console output)
/// - Drift database (for persistent history and export)
///
/// Ported from ConnectionLogger.kt
class ConnectionLogger {
  final ConnectionLogDao _connectionLogDao;

  // Sample counter for monitor data logging (to avoid flooding)
  int _monitorDataSampleCounter = 0;

  ConnectionLogger(this._connectionLogDao) {
    // Log device info once at startup
    _logInitialDeviceInfo();
  }

  void _logInitialDeviceInfo() {
    log(
      EventType.systemInfo,
      Level.info,
      'App started',
      details: DeviceInfo.getFormattedInfo(),
      metadata: DeviceInfo.toJson(),
    );
  }

  /// Log a connection event
  void log(
    String eventType,
    Level level,
    String message, {
    String? deviceAddress,
    String? deviceName,
    String? details,
    String? metadata,
  }) {
    // Log to Logger for real-time debugging
    final logMessage = StringBuffer('[BLE] $eventType');
    if (deviceName != null) logMessage.write(' [$deviceName]');
    logMessage.write(': $message');
    if (details != null) logMessage.write(' | $details');

    switch (level) {
      case Level.debug:
        logger.d(logMessage.toString());
        break;
      case Level.info:
        logger.i(logMessage.toString());
        break;
      case Level.warning:
        logger.w(logMessage.toString());
        break;
      case Level.error:
        logger.e(logMessage.toString());
        break;
    }

    // Persist to database asynchronously
    Future(() async {
      try {
        final logCompanion = ConnectionLogsCompanion.insert(
          timestamp: BigInt.from(DateTime.now().millisecondsSinceEpoch),
          eventType: eventType,
          level: level.name,
          deviceAddress: Value(deviceAddress),
          deviceName: Value(deviceName),
          message: message,
          details: Value(details),
          metadata: Value(metadata),
        );
        await _connectionLogDao.insertLog(logCompanion);
      } catch (e) {
        // Don't let logging errors crash the app
        logger.e('Failed to persist connection log', error: e);
      }
    });
  }

  // ========== Convenience methods for common scenarios ==========

  void logScanStarted() {
    log(EventType.scanStarted, Level.info, 'BLE scan started');
  }

  void logScanStopped() {
    log(EventType.scanStopped, Level.info, 'BLE scan stopped');
  }

  void logDeviceFound(String deviceName, String deviceAddress) {
    log(
      EventType.deviceFound,
      Level.info,
      'Device discovered',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logConnectionStarted(String deviceName, String deviceAddress) {
    log(
      EventType.connectionStarted,
      Level.info,
      'Attempting to connect',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logConnectionSuccess(String deviceName, String deviceAddress) {
    final details = StringBuffer()
      ..writeln('Vitruvian Device: $deviceName')
      ..writeln('MAC Address: $deviceAddress')
      ..writeln()
      ..write('Device: ${DeviceInfo.getCompactInfo()}');

    log(
      EventType.connectionSuccess,
      Level.info,
      'Successfully connected',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: details.toString(),
    );

    // Also log Vitruvian device info separately for easy filtering
    final vitruvianModel = _extractVitruvianModel(deviceName);
    final vitruvianDetails = StringBuffer()
      ..writeln('Device Name: $deviceName')
      ..writeln('MAC Address: $deviceAddress')
      ..writeln('Model: $vitruvianModel')
      ..writeln()
      ..writeln('Note: Firmware version not available via BLE')
      ..write('To check firmware: Settings → About on Vitruvian touchscreen');

    log(
      EventType.vitruvianDeviceInfo,
      Level.info,
      'Connected to Vitruvian device',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: vitruvianDetails.toString(),
      metadata: '{"deviceName":"$deviceName","address":"$deviceAddress","model":"$vitruvianModel"}',
    );
  }

  /// Extract Vitruvian model from device name using hardware detection
  /// Device names typically follow pattern "Vee123" or "Vitruvian-XXX"
  String _extractVitruvianModel(String deviceName) {
    final model = HardwareDetection.detectModel(deviceName);
    final capabilities = model.capabilities;

    final result = StringBuffer()
      ..writeln('${model.displayName} [${model.modelNumber}]')
      ..write('  • Eccentric Mode: ${capabilities.supportsEccentricMode ? "Supported" : "Not Supported"}')
      ..writeln()
      ..write('  • Max Resistance: ${capabilities.maxResistanceKg} kg');

    if (capabilities.notes.isNotEmpty) {
      result.writeln();
      result.write('  • Note: ${capabilities.notes}');
    }

    return result.toString();
  }

  void logConnectionFailed(String deviceName, String deviceAddress, String error) {
    log(
      EventType.connectionFailed,
      Level.error,
      'Connection failed',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: error,
    );
  }

  void logDisconnected(String? deviceName, String? deviceAddress, {String? reason}) {
    log(
      EventType.disconnected,
      Level.warning,
      'Device disconnected',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: reason,
    );
  }

  void logConnectionLost(String? deviceName, String? deviceAddress) {
    log(
      EventType.connectionLost,
      Level.error,
      'Connection lost unexpectedly',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logInitStarted(String deviceName, String deviceAddress) {
    log(
      EventType.initStarted,
      Level.info,
      'Starting initialization sequence',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logInitSuccess(String deviceName, String deviceAddress) {
    log(
      EventType.initSuccess,
      Level.info,
      'Initialization completed successfully',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logInitFailed(String deviceName, String deviceAddress, String error) {
    log(
      EventType.initFailed,
      Level.error,
      'Initialization failed',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: error,
    );
  }

  void logCommandSent(
    String commandName,
    String? deviceName,
    String? deviceAddress, {
    Uint8List? commandData,
    String? additionalInfo,
  }) {
    String? hexDump;
    if (commandData != null) {
      final buffer = StringBuffer()
        ..writeln('Size: ${commandData.length} bytes')
        ..write('Hex: ${commandData.toHexString()}');
      if (additionalInfo != null) {
        buffer.writeln();
        buffer.write('Info: $additionalInfo');
      }
      hexDump = buffer.toString();
    }

    log(
      EventType.commandSent,
      Level.info,
      'Command sent: $commandName',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: hexDump,
    );
  }

  void logCommandSuccess(String commandName, String? deviceName, String? deviceAddress) {
    log(
      EventType.commandSuccess,
      Level.debug,
      'Command successful: $commandName',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logCommandFailed(String commandName, String? deviceName, String? deviceAddress, String error) {
    log(
      EventType.commandFailed,
      Level.error,
      'Command failed: $commandName',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: error,
    );
  }

  void logPollingStarted(String pollingType, String? deviceName, String? deviceAddress) {
    log(
      EventType.pollingStarted,
      Level.debug,
      'Started polling: $pollingType',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logPollingStopped(String pollingType, String? deviceName, String? deviceAddress) {
    log(
      EventType.pollingStopped,
      Level.debug,
      'Stopped polling: $pollingType',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logDataReceived(String dataType, String? deviceName, String? deviceAddress, {String? summary}) {
    log(
      EventType.dataReceived,
      Level.debug,
      'Data received: $dataType',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: summary,
    );
  }

  void logDataParseError(String dataType, String? deviceName, String? deviceAddress, String error) {
    log(
      EventType.dataParseError,
      Level.error,
      'Failed to parse $dataType',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: error,
    );
  }

  void logTimeout(String operation, String? deviceName, String? deviceAddress) {
    log(
      EventType.timeout,
      Level.error,
      'Operation timed out: $operation',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
    );
  }

  void logError(String operation, String? deviceName, String? deviceAddress, String error) {
    log(
      EventType.unknownError,
      Level.error,
      'Error during $operation',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: error,
    );
  }

  void logMonitorDataReceived(
    String? deviceName,
    String? deviceAddress,
    int positionA,
    int positionB,
    double loadA,
    double loadB,
  ) {
    // Only log every 10th sample to avoid flooding (100ms polling = log every 1 second)
    if (_monitorDataSampleCounter++ % 10 == 0) {
      log(
        EventType.dataReceived,
        Level.debug,
        'Monitor data',
        deviceAddress: deviceAddress,
        deviceName: deviceName,
        details: 'PosA=$positionA, PosB=$positionB, LoadA=${loadA}kg, LoadB=${loadB}kg',
      );
    }
  }

  void logCharacteristicWrite(
    String characteristicUuid,
    String? deviceName,
    String? deviceAddress,
    Uint8List data, {
    required bool success,
  }) {
    final details = StringBuffer()
      ..writeln('UUID: $characteristicUuid')
      ..writeln('Data: ${data.toHexString()}')
      ..write('Size: ${data.length} bytes');

    log(
      success ? EventType.commandSuccess : EventType.writeError,
      success ? Level.info : Level.error,
      '${success ? "Successfully wrote" : "Failed to write"} to characteristic',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: details.toString(),
    );
  }

  void logCharacteristicRead(
    String characteristicUuid,
    String? deviceName,
    String? deviceAddress,
    Uint8List? data,
  ) {
    final details = StringBuffer()
      ..writeln('UUID: $characteristicUuid');

    if (data != null) {
      details.writeln('Data: ${data.toHexString()}');
      details.write('Size: ${data.length} bytes');
    } else {
      details.write('Data: null');
    }

    log(
      EventType.dataReceived,
      Level.debug,
      'Read characteristic',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: details.toString(),
    );
  }

  void logHandleDetection(
    String? deviceName,
    String? deviceAddress, {
    required int? baselineA,
    required int? baselineB,
    required int currentA,
    required int currentB,
    required int deltaA,
    required int deltaB,
    required int threshold,
    required bool grabbed,
  }) {
    final details = StringBuffer()
      ..writeln('BaselineA=$baselineA, BaselineB=$baselineB')
      ..writeln('CurrentA=$currentA, CurrentB=$currentB')
      ..writeln('DeltaA=$deltaA, DeltaB=$deltaB')
      ..writeln('Threshold=$threshold')
      ..write('Status: ${grabbed ? "GRABBED" : "RELEASED"}');

    log(
      EventType.dataReceived,
      Level.debug,
      'Handle detection: ${grabbed ? "GRABBED" : "RELEASED"}',
      deviceAddress: deviceAddress,
      deviceName: deviceName,
      details: details.toString(),
    );
  }

  /// Clean up old logs (e.g., older than 7 days)
  Future<void> cleanupOldLogs({int daysToKeep = 7}) async {
    final cutoffTime = DateTime.now().millisecondsSinceEpoch - (daysToKeep * 24 * 60 * 60 * 1000);
    final deletedCount = await _connectionLogDao.deleteLogsOlderThan(cutoffTime);
    logger.i('Cleaned up $deletedCount old connection logs');
  }

  /// Clear all logs
  Future<void> clearAllLogs() async {
    await _connectionLogDao.deleteAll();
    logger.i('Cleared all connection logs');
  }
}

/// Extension to convert byte array to hex string for logging
extension Uint8ListHex on Uint8List {
  String toHexString() {
    return map((byte) => byte.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
  }
}
