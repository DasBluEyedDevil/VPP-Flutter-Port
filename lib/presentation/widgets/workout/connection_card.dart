import 'package:flutter/material.dart';
import '../../../domain/models/connection_state.dart' as ble;

/// Connection status card displayed at top of workout screen
///
/// Shows connection state with color-coded status and action button
class ConnectionCard extends StatelessWidget {
  final ble.ConnectionState connectionState;
  final VoidCallback onScan;
  final VoidCallback onDisconnect;

  const ConnectionCard({
    super.key,
    required this.connectionState,
    required this.onScan,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connection',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildStatusIcon(colorScheme),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatusText(theme),
                      ),
                    ],
                  ),
                ),
                _buildActionButton(context, colorScheme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme) {
    final (icon, color) = connectionState.when(
      disconnected: () => (
        Icons.bluetooth_disabled,
        Colors.red,
      ),
      scanning: () => (
        Icons.bluetooth_searching,
        Colors.orange,
      ),
      connecting: () => (
        Icons.bluetooth_searching,
        Colors.orange,
      ),
      connected: (_, __, ___) => (
        Icons.bluetooth_connected,
        Colors.green,
      ),
      error: (_, __) => (
        Icons.error_outline,
        Colors.red,
      ),
    );

    return Icon(
      icon,
      color: color,
      size: 24,
    );
  }

  Widget _buildStatusText(ThemeData theme) {
    final text = connectionState.when(
      disconnected: () => 'Not connected',
      scanning: () => 'Scanning...',
      connecting: () => 'Connecting...',
      connected: (name, address, model) => 'Connected to $name',
      error: (message, _) => 'Error: $message',
    );

    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, ColorScheme colorScheme) {
    return connectionState.maybeWhen(
      disconnected: () => FilledButton.icon(
        onPressed: onScan,
        icon: const Icon(Icons.search, size: 18),
        label: const Text('Scan'),
      ),
      connected: (_, __, ___) => OutlinedButton.icon(
        onPressed: onDisconnect,
        icon: const Icon(Icons.close, size: 18),
        label: const Text('Disconnect'),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
