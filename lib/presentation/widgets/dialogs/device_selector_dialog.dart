import 'package:flutter/material.dart';
import '../../../domain/models/scanned_device.dart';
import '../../theme/spacing.dart';

/// Manual device selection dialog for BLE connections.
///
/// Displays a list of discovered Vitruvian devices with their MAC addresses.
/// User can select a device to connect to, or rescan for more devices.
///
/// Features:
/// - Empty state with scanning indicator or "No devices found"
/// - Device list with name + MAC address (RSSI not displayed)
/// - Rescan button (only visible when not scanning)
/// - Cancel button
///
/// Matches Kotlin VitruvianRedux DeviceSelectorDialog exactly.
class DeviceSelectorDialog extends StatelessWidget {
  /// List of discovered BLE devices
  final List<ScannedDevice> devices;

  /// Whether scanning is currently in progress
  final bool isScanning;

  /// Callback when user selects a device
  final ValueChanged<ScannedDevice> onDeviceSelected;

  /// Callback when user taps Rescan button
  final VoidCallback onRescan;

  /// Callback when user taps Cancel or dismisses dialog
  final VoidCallback onDismiss;

  const DeviceSelectorDialog({
    super.key,
    required this.devices,
    required this.isScanning,
    required this.onDeviceSelected,
    required this.onRescan,
    required this.onDismiss,
  });

  /// Show the dialog and return the selected device
  static Future<ScannedDevice?> show(
    BuildContext context, {
    required List<ScannedDevice> devices,
    required bool isScanning,
    required ValueChanged<ScannedDevice> onDeviceSelected,
    required VoidCallback onRescan,
  }) {
    return showDialog<ScannedDevice>(
      context: context,
      builder: (context) => DeviceSelectorDialog(
        devices: devices,
        isScanning: isScanning,
        onDeviceSelected: onDeviceSelected,
        onRescan: onRescan,
        onDismiss: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Select Vitruvian Device'),
      content: SizedBox(
        width: double.maxFinite,
        child: devices.isEmpty ? _buildEmptyState(theme) : _buildDeviceList(theme),
      ),
      actions: [
        // Rescan button (only visible when not scanning)
        if (!isScanning)
          TextButton(
            onPressed: onRescan,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.extraSmall),
                Text(
                  'Rescan',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),

        // Cancel button
        TextButton(
          onPressed: onDismiss,
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }

  /// Build empty state (scanning or no devices found)
  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isScanning) ...[
            // Scanning indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: AppSpacing.small),
                const Text('Scanning...'),
              ],
            ),
          ] else ...[
            // No devices found
            Text(
              'No devices found. Try scanning again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  /// Build device list
  Widget _buildDeviceList(ThemeData theme) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: devices.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.extraSmall),
      itemBuilder: (context, index) {
        final device = devices[index];
        return _buildDeviceCard(context, theme, device);
      },
    );
  }

  /// Build device card
  Widget _buildDeviceCard(BuildContext context, ThemeData theme, ScannedDevice device) {
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => onDeviceSelected(device),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              // Device info (name + MAC address)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Device name
                    Text(
                      device.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    // MAC address
                    Text(
                      device.address,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.keyboard_arrow_right,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
