import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Full-screen BLE connecting overlay (matches Kotlin ConnectingOverlay.kt).
///
/// Shows a non-dismissible full-screen modal with:
/// - Semi-transparent scrim background (60% opacity)
/// - Centered card with 32dp padding
/// - 48dp circular progress indicator
/// - "Connecting to device..." title (titleMedium)
/// - "Scanning for Vitruvian Trainer" subtitle (bodySmall, onSurfaceVariant)
/// - Cancel button with 8dp top padding
///
/// Cannot be dismissed by tapping outside or back button.
class ConnectingOverlay extends StatelessWidget {
  /// Callback when cancel is pressed
  final VoidCallback onCancel;

  const ConnectingOverlay({
    super.key,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: PopScope(
        canPop: false, // Prevent back button dismiss
        child: GestureDetector(
          onTap: () {}, // Prevent tap-outside dismiss
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.colorScheme.scrim.withValues(alpha: 0.6),
            child: Center(
              child: Card(
                margin: const EdgeInsets.all(AppSpacing.extraLarge),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.extraLarge),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 48dp circular progress indicator
                      const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(),
                      ),

                      const SizedBox(height: AppSpacing.medium),

                      // Title
                      Text(
                        'Connecting to device...',
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.small),

                      // Subtitle
                      Text(
                        'Scanning for Vitruvian Trainer',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.small),

                      // Cancel button
                      TextButton(
                        onPressed: onCancel,
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
