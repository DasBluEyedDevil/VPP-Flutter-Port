import 'package:flutter/material.dart';

/// Dialog shown when BLE connection is lost during an active workout.
/// (Matches Kotlin ConnectionLostDialog.kt)
///
/// Features:
/// - BluetoothDisabled icon (tint: error)
/// - "Connection Lost" title (headlineSmall, Bold)
/// - Primary message: "Bluetooth connection to the trainer was lost during your workout." (bodyLarge)
/// - 8dp spacer
/// - Secondary message: "Rep tracking may have been interrupted. Please reconnect to continue." (bodyMedium, onSurfaceVariant)
/// - Reconnect button (Bold)
/// - Dismiss button
///
/// Cannot be dismissed by tapping outside (barrierDismissible: false).
class ConnectionLostDialog extends StatelessWidget {
  /// Callback when user taps Reconnect
  final VoidCallback onReconnect;

  /// Callback when user taps Dismiss
  final VoidCallback onDismiss;

  const ConnectionLostDialog({
    super.key,
    required this.onReconnect,
    required this.onDismiss,
  });

  /// Show the dialog and return the user's choice
  ///
  /// Returns 'reconnect' if Reconnect was tapped, 'dismiss' if Dismiss was tapped.
  static Future<String?> show(
    BuildContext context, {
    required VoidCallback onReconnect,
    required VoidCallback onDismiss,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => ConnectionLostDialog(
        onReconnect: onReconnect,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: Icon(
        Icons.bluetooth_disabled,
        color: theme.colorScheme.error,
        size: 48,
      ),
      title: Text(
        'Connection Lost',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary message
          Text(
            'Bluetooth connection to the trainer was lost during your workout.',
            style: theme.textTheme.bodyLarge,
          ),

          const SizedBox(height: 8),

          // Secondary message
          Text(
            'Rep tracking may have been interrupted. Please reconnect to continue.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        // Dismiss button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop('dismiss');
            onDismiss();
          },
          child: const Text('Dismiss'),
        ),

        // Reconnect button (Bold)
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop('reconnect');
            onReconnect();
          },
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Reconnect'),
        ),
      ],
    );
  }
}

