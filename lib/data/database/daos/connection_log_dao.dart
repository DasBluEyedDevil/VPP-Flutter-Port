import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/connection_logs.dart';

part 'connection_log_dao.g.dart';

@DriftAccessor(tables: [ConnectionLogs])
class ConnectionLogDao extends DatabaseAccessor<AppDatabase> with _$ConnectionLogDaoMixin {
  final AppDatabase db;
  ConnectionLogDao(this.db) : super(db);

  // ========== Connection Logs ==========

  /// Insert a connection log entry
  Future<int> insertLog(ConnectionLogsCompanion log) {
    return into(connectionLogs).insert(log);
  }

  /// Insert multiple log entries (batch)
  Future<void> insertLogsBatch(List<ConnectionLogsCompanion> logs) {
    return batch((batch) {
      batch.insertAll(connectionLogs, logs);
    });
  }

  /// Delete a log entry
  Future<int> deleteLog(int logId) {
    return (delete(connectionLogs)..where((t) => t.id.equals(logId))).go();
  }

  /// Delete all logs
  Future<int> deleteAllLogs() {
    return delete(connectionLogs).go();
  }

  /// Delete logs older than specified timestamp
  Future<int> deleteLogsOlderThan(int timestamp) {
    return (delete(connectionLogs)..where((t) => t.timestamp.isSmallerThanValue(BigInt.from(timestamp)))).go();
  }

  /// Get a log by ID
  Future<ConnectionLog?> getLogById(int logId) {
    return (select(connectionLogs)..where((t) => t.id.equals(logId))).getSingleOrNull();
  }

  /// Watch all logs (reactive stream)
  Stream<List<ConnectionLog>> watchLogs({int? limit}) {
    final query = select(connectionLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.watch();
  }

  /// Get all logs
  Future<List<ConnectionLog>> getAllLogs({int? limit}) {
    final query = select(connectionLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    if (limit != null) {
      query.limit(limit);
    }
    return query.get();
  }

  /// Get logs in a time range
  Future<List<ConnectionLog>> getLogsInRange(int startTimestamp, int endTimestamp) {
    return (select(connectionLogs)
          ..where((t) => t.timestamp.isBetweenValues(BigInt.from(startTimestamp), BigInt.from(endTimestamp)))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Get logs for a specific device (by address or name)
  Future<List<ConnectionLog>> getLogsForDevice(String deviceId) {
    return (select(connectionLogs)
          ..where((t) => t.deviceAddress.equals(deviceId) | t.deviceName.equals(deviceId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Get logs by event type
  Future<List<ConnectionLog>> getLogsByEvent(String event) {
    return (select(connectionLogs)
          ..where((t) => t.eventType.equals(event))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// Get recent logs (limit)
  Future<List<ConnectionLog>> getRecentLogs({int limit = 100}) {
    return (select(connectionLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .get();
  }

  /// Delete all logs
  Future<int> deleteAll() {
    return delete(connectionLogs).go();
  }
}
