import 'package:flutter/material.dart';

/// Dialog shown when BLE connection fails
/// 
/// Displays an error message with Retry and Cancel actions.
/// Returns true if user taps Retry, false if Cancel.
class ConnectionErrorDialog extends StatelessWidget {
  /// Error message to display
  final String errorMessage;
  
  /// Callback when user taps Retry
  final VoidCallback onRetry;
  
  /// Callback when user taps Cancel
  final VoidCallback onCancel;

  const ConnectionErrorDialog({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    required this.onCancel,
  });

  /// Show the dialog and return the user's choice
  /// 
  /// Returns true if Retry was tapped, false if Cancel was tapped.
  static Future<bool?> show(
    BuildContext context, {
    required String errorMessage,
    required VoidCallback onRetry,
    required VoidCallback onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConnectionErrorDialog(
        errorMessage: errorMessage,
        onRetry: onRetry,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Connection Failed'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Unable to connect to device.'),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            onCancel();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onRetry();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
