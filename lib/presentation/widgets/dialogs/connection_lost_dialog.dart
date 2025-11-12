import 'package:flutter/material.dart';

/// Dialog shown when BLE connection is lost during an active workout
/// 
/// Displays a warning with Reconnect and End Workout actions.
/// Returns 'reconnect' if user taps Reconnect, 'end' if End Workout.
class ConnectionLostDialog extends StatelessWidget {
  /// Callback when user taps Reconnect
  final VoidCallback onReconnect;
  
  /// Callback when user taps End Workout
  final VoidCallback onEndWorkout;

  const ConnectionLostDialog({
    super.key,
    required this.onReconnect,
    required this.onEndWorkout,
  });

  /// Show the dialog and return the user's choice
  /// 
  /// Returns 'reconnect' if Reconnect was tapped, 'end' if End Workout was tapped.
  static Future<String?> show(
    BuildContext context, {
    required VoidCallback onReconnect,
    required VoidCallback onEndWorkout,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => ConnectionLostDialog(
        onReconnect: onReconnect,
        onEndWorkout: onEndWorkout,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return AlertDialog(
      icon: Icon(
        Icons.warning_rounded,
        color: colorScheme.error,
        size: 48,
      ),
      title: const Text('Connection Lost'),
      content: const Text(
        'The connection to your device was lost. Would you like to reconnect or end the workout?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop('end');
            onEndWorkout();
          },
          child: const Text('End Workout'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop('reconnect');
            onReconnect();
          },
          child: const Text('Reconnect'),
        ),
      ],
    );
  }
}
