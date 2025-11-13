import 'package:flutter/material.dart';

/// Refresh button widget with rotation animation.
///
/// Ported from Kotlin HistoryTab refresh IconButton (lines 66-87).
/// Rotates 360° when tapped, with 1-second delay before reset.
class RefreshButton extends StatefulWidget {
  /// Callback when refresh button is tapped
  final VoidCallback? onRefresh;

  const RefreshButton({
    super.key,
    this.onRefresh,
  });

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);
    _rotationController.forward(from: 0.0);

    // Call the refresh callback
    widget.onRefresh?.call();

    // Reset after 1 second (cosmetic delay)
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isRefreshing = false);
      _rotationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RotationTransition(
      turns: _rotationController,
      child: IconButton(
        icon: Icon(
          Icons.refresh,
          color: theme.colorScheme.primary,
        ),
        onPressed: _handleRefresh,
        tooltip: 'Refresh',
      ),
    );
  }
}
