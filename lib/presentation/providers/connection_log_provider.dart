import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/database/daos/connection_log_dao.dart';

/// Provider for AppDatabase instance (must be overridden in main.dart)
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider must be overridden with actual AppDatabase instance');
});

/// Provider for ConnectionLogDao instance
final connectionLogDaoProvider = Provider<ConnectionLogDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.connectionLogDao;
});

/// Stream provider for all connection logs
final connectionLogsStreamProvider = StreamProvider<List<ConnectionLog>>((ref) {
  final dao = ref.watch(connectionLogDaoProvider);
  return dao.watchLogs();
});
