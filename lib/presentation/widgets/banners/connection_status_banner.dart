import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/spacing.dart';
import '../../providers/ble_connection_provider.dart';
import '../../../domain/models/connection_state.dart';

/// Connection status banner that displays when not connected to the machine.
/// Shows a warning message and a Connect button for easy manual connection.
/// 
/// Uses Material Design 3 styling with theme-aware colors.
/// Dismissible when connected.
class ConnectionStatusBanner extends ConsumerWidget {
  final VoidCallback? onConnect;

  const ConnectionStatusBanner({
    super.key,
    this.onConnect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final connectionStateAsync = ref.watch(connectionStateProvider);

    return connectionStateAsync.when(
      data: (connectionState) {
        // Only show banner when not connected
        if (connectionState is Connected) {
          return const SizedBox.shrink();
        }

        // Determine status text and color based on connection state
        String statusText;
        Color statusColor;
        
        if (connectionState is Scanning) {
          statusText = "Scanning for machine...";
          statusColor = theme.colorScheme.primary;
        } else if (connectionState is Connecting) {
          statusText = "Connecting to machine...";
          statusColor = theme.colorScheme.primary;
        } else if (connectionState is ConnectionError) {
          statusText = "Connection error: ${connectionState.message}";
          statusColor = theme.colorScheme.error;
        } else {
          // Disconnected
          statusText = "Not connected to machine";
          statusColor = theme.colorScheme.error;
        }

        return Card(
          color: theme.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.medium),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Row(
              children: [
                // Status icon and message
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.bluetooth,
                        color: statusColor,
                        size: 24,
                      ),
                      const SizedBox(width: AppSpacing.small),
                      Flexible(
                        child: Text(
                          statusText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Connect button (only show when disconnected or error)
                if ((connectionState is Disconnected || connectionState is ConnectionError) &&
                    onConnect != null)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.medium),
                    child: TextButton(
                      onPressed: onConnect,
                      child: Text(
                        "Connect",
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
