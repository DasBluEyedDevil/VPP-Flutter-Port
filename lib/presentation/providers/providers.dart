// Riverpod Provider Composition
// This file will contain all Riverpod providers for dependency injection
// Replaces Hilt AppModule.kt

// TODO: Add providers as we port ViewModels and repositories
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// Example structure:
//
// // Repository Providers
// final bleRepositoryProvider = Provider<BleRepository>((ref) {
//   return BleRepositoryImpl(ref.watch(bleManagerProvider));
// });
//
// // State Providers (ViewModels)
// final connectionProvider = StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
//   return ConnectionNotifier(ref.watch(bleRepositoryProvider));
// });
//
// // Stream Providers (BLE data streams)
// final monitorDataStreamProvider = StreamProvider<WorkoutMetric>((ref) {
//   return ref.watch(bleRepositoryProvider).monitorDataStream;
// });
