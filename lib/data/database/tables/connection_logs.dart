import 'package:drift/drift.dart';

/// Connection logs table - debug logging for BLE events
class ConnectionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  Int64Column get timestamp => int64()();
  TextColumn get eventType => text()(); // Event type (SCAN_STARTED, CONNECTION_SUCCESS, etc.)
  TextColumn get level => text()(); // Log level (DEBUG, INFO, WARNING, ERROR)
  TextColumn get message => text()();
  TextColumn get deviceAddress => text().nullable()(); // BLE device MAC address
  TextColumn get deviceName => text().nullable()(); // BLE device name
  TextColumn get details => text().nullable()(); // Additional details
  TextColumn get metadata => text().nullable()(); // JSON metadata

  Set<Index> get customIndexes => {
    Index('idx_connection_logs_timestamp', 'CREATE INDEX idx_connection_logs_timestamp ON connection_logs (timestamp)'),
  };
}
