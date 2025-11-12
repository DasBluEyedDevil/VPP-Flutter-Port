import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/database/app_database.dart';
import 'data/repositories/ble_repository.dart';
import 'data/repositories/workout_repository.dart';
import 'data/repositories/personal_record_repository.dart';
import 'data/local/connection_logger.dart';
import 'presentation/app.dart';
import 'presentation/providers/preferences_provider.dart';
import 'presentation/providers/connection_log_provider.dart';
import 'presentation/providers/ble_connection_provider.dart' as ble;
import 'presentation/providers/workout_session_provider.dart';
import 'presentation/providers/personal_record_provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Drift database
  final database = AppDatabase();

  // Initialize connection logger
  final connectionLogger = ConnectionLogger(database.connectionLogDao);

  // Initialize repositories
  final bleRepository = BleRepositoryImpl(connectionLogger);
  final workoutRepository = WorkoutRepository(database.workoutDao, database.prDao);
  final personalRecordRepository = PersonalRecordRepository(database.prDao);

  // Run app with provider overrides
  runApp(
    ProviderScope(
      overrides: [
        // Override SharedPreferences provider with actual instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override AppDatabase provider with actual instance
        appDatabaseProvider.overrideWithValue(database),

        // Override BLE repository provider with actual instance (using prefix to avoid ambiguity)
        ble.bleRepositoryProvider.overrideWithValue(bleRepository),

        // Override workout repository provider with actual instance
        workoutRepositoryProvider.overrideWithValue(workoutRepository),

        // Override personal record repository provider with actual instance
        personalRecordRepositoryProvider.overrideWithValue(personalRecordRepository),
      ],
      child: const VPPApp(),
    ),
  );
}
