import 'package:flutter/material.dart';

/// Dialog shown when BLE connection fails (matches Kotlin ConnectionErrorDialog.kt).
///
/// Features:
/// - Warning icon
/// - "Connection Failed" title
/// - Error message (bodyMedium)
/// - Divider with 4dp padding
/// - Troubleshooting tips header (labelLarge, Bold, primary color)
/// - 4 bullet point tips (bodySmall)
/// - Retry button (if onRetry provided)
/// - OK/Dismiss button
class ConnectionErrorDialog extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Optional callback when user taps Retry
  final VoidCallback? onRetry;

  /// Callback when user dismisses dialog
  final VoidCallback onDismiss;

  const ConnectionErrorDialog({
    super.key,
    required this.message,
    this.onRetry,
    required this.onDismiss,
  });

  /// Show the dialog and return the user's choice
  static Future<bool?> show(
    BuildContext context, {
    required String message,
    VoidCallback? onRetry,
    required VoidCallback onDismiss,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConnectionErrorDialog(
        message: message,
        onRetry: onRetry,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.warning_rounded, size: 48),
      title: const Text('Connection Failed'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Error message
          Text(
            message,
            style: theme.textTheme.bodyMedium,
          ),

          // Divider with 4dp vertical padding
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Divider(),
          ),

          // Troubleshooting header
          Text(
            'Troubleshooting tips:',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 6),

          // Troubleshooting tips (4 bullets)
          Text(
            '• Ensure the machine is powered on',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '• Try turning Bluetooth off and on',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '• Move closer to the machine',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '• Check that no other device is connected',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        // Dismiss button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            onDismiss();
          },
          child: const Text('OK'),
        ),

        // Retry button (only if onRetry provided)
        if (onRetry != null)
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onDismiss();
              onRetry!();
            },
            child: const Text('Retry'),
          ),
      ],
    );
  }
}
