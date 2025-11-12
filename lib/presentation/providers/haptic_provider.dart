import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/haptic_event.dart';

/// Notifier for managing haptic feedback events
///
/// Ported from MainViewModel.kt _hapticEvents SharedFlow (lines 246-250)
class HapticNotifier extends StateNotifier<void> {
  HapticNotifier() : super(null);

  final _controller = StreamController<HapticEvent>.broadcast();

  /// Stream of haptic events
  Stream<HapticEvent> get events => _controller.stream;

  /// Emit a haptic feedback event
  ///
  /// Events are emitted to trigger device haptic feedback in the UI layer.
  /// The stream is broadcast so multiple listeners can receive events.
  ///
  /// Example from MainViewModel.kt (line 815):
  /// ```kotlin
  /// _hapticEvents.emit(HapticEvent.WORKOUT_START)
  /// ```
  void emitHaptic(HapticEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

/// Provider for haptic feedback event stream
///
/// Usage in UI:
/// ```dart
/// ref.listen(hapticEventsProvider, (previous, next) {
///   // Trigger platform haptic feedback based on event type
///   HapticFeedback.vibrate(); // or HapticFeedback.heavyImpact(), etc.
/// });
/// ```
final hapticNotifierProvider = StateNotifierProvider<HapticNotifier, void>((ref) {
  return HapticNotifier();
});

/// Stream provider for haptic events
final hapticEventsProvider = StreamProvider<HapticEvent>((ref) {
  final notifier = ref.watch(hapticNotifierProvider.notifier);
  return notifier.events;
});

/// Actions provider for emitting haptic events
final hapticActionsProvider = Provider<HapticActions>((ref) {
  final notifier = ref.watch(hapticNotifierProvider.notifier);
  return HapticActions(notifier);
});

/// Actions class for haptic feedback
///
/// Provides methods to emit haptic events from business logic
class HapticActions {
  final HapticNotifier _notifier;

  HapticActions(this._notifier);

  /// Emit a haptic feedback event
  void emitHaptic(HapticEvent event) {
    _notifier.emitHaptic(event);
  }

  /// Convenience methods for common haptic events

  void onWorkoutStart() => emitHaptic(HapticEvent.workoutStart);
  void onWorkoutComplete() => emitHaptic(HapticEvent.workoutComplete);
  void onWorkoutEnd() => emitHaptic(HapticEvent.workoutEnd);
  void onRepCompleted() => emitHaptic(HapticEvent.repCompleted);
  void onWarmupComplete() => emitHaptic(HapticEvent.warmupComplete);
  void onError() => emitHaptic(HapticEvent.error);
}
