import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/database/app_database.dart';
import 'presentation/app.dart';
import 'presentation/providers/preferences_provider.dart';
import 'presentation/providers/connection_log_provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Drift database
  final database = AppDatabase();

  // Run app with provider overrides
  runApp(
    ProviderScope(
      overrides: [
        // Override SharedPreferences provider with actual instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override AppDatabase provider with actual instance
        appDatabaseProvider.overrideWithValue(database),
      ],
      child: const VPPApp(),
    ),
  );
}
