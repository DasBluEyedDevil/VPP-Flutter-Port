import 'package:flutter/material.dart';

/// Delete confirmation dialog helper
///
/// Shows a confirmation dialog for destructive actions like deleting all workouts.
/// Ported from Kotlin SettingsScreen.kt delete confirmation dialog.
class DeleteConfirmationDialog {
  DeleteConfirmationDialog._(); // Private constructor

  /// Show the delete confirmation dialog
  ///
  /// Returns `true` if user confirmed, `false` if cancelled, `null` if dismissed
  static Future<bool?> show(
    BuildContext context, {
    String title = 'Delete All Workouts?',
    String message =
        'This will permanently delete all workout history. This cannot be undone.',
    String confirmText = 'Delete All',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
