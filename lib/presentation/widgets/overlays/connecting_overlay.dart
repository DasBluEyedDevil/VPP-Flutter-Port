import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Full-screen BLE connecting overlay with progress indication.
/// 
/// Shows a semi-transparent overlay with a centered card displaying:
/// - Circular progress indicator
/// - Connection status text with device name
/// - Optional timeout message if connection takes >15 seconds
/// - Cancel button
/// 
/// Uses Stack with Positioned.fill for full-screen coverage.
class ConnectingOverlay extends StatefulWidget {
  /// Whether the connection is in progress
  final bool isConnecting;
  
  /// Name of the device being connected to
  final String? deviceName;
  
  /// Connection progress (0.0 to 1.0)
  final double progress;
  
  /// Callback when cancel is pressed
  final VoidCallback? onCancel;

  const ConnectingOverlay({
    super.key,
    required this.isConnecting,
    this.deviceName,
    this.progress = 0.0,
    this.onCancel,
  });

  @override
  State<ConnectingOverlay> createState() => _ConnectingOverlayState();
}

class _ConnectingOverlayState extends State<ConnectingOverlay> {
  DateTime? _connectionStartTime;
  bool _showTimeoutMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.isConnecting) {
      _connectionStartTime = DateTime.now();
      _checkTimeout();
    }
  }

  @override
  void didUpdateWidget(ConnectingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isConnecting && !oldWidget.isConnecting) {
      // Connection just started
      _connectionStartTime = DateTime.now();
      _showTimeoutMessage = false;
      _checkTimeout();
    } else if (!widget.isConnecting && oldWidget.isConnecting) {
      // Connection finished
      _connectionStartTime = null;
      _showTimeoutMessage = false;
    }
  }

  void _checkTimeout() {
    if (!widget.isConnecting) return;
    
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted && widget.isConnecting) {
        setState(() {
          _showTimeoutMessage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isConnecting) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final deviceName = widget.deviceName ?? 'Vitruvian Trainer';

    return Stack(
      children: [
        // Semi-transparent black background
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        
        // Centered card with content
        Center(
          child: Card(
            margin: const EdgeInsets.all(AppSpacing.extraLarge),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.extraLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular progress indicator
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      value: widget.progress > 0.0 ? widget.progress : null,
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppSpacing.medium),
                  
                  // Connection status text
                  Text(
                    'Connecting to $deviceName...',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppSpacing.small),
                  
                  // Subtitle text
                  Text(
                    'Scanning for Vitruvian Trainer',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  // Timeout message (if >15s)
                  if (_showTimeoutMessage) ...[
                    const SizedBox(height: AppSpacing.medium),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.small),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(AppSpacing.small),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 16,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: AppSpacing.small),
                          Text(
                            'Connection taking longer than expected',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  // Cancel button
                  if (widget.onCancel != null) ...[
                    const SizedBox(height: AppSpacing.medium),
                    TextButton(
                      onPressed: widget.onCancel,
                      child: Text(
                        'Cancel',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
