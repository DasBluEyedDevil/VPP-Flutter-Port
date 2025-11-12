import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Pre-workout countdown display widget (5-4-3-2-1-GO!)
///
/// Displays a large animated countdown number with pulsing animation.
/// Used before starting a workout to prepare the user.
class CountdownCard extends StatefulWidget {
  /// Seconds remaining in countdown (5, 4, 3, 2, 1, 0)
  final int secondsRemaining;

  const CountdownCard({
    super.key,
    required this.secondsRemaining,
  });

  @override
  State<CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.background,
            colorScheme.surface,
            colorScheme.surfaceVariant,
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get Ready!',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.small + 4),
          // Huge gradient number with pulsing animation
          ScaleTransition(
            scale: _pulseAnimation,
            child: Text(
              '${widget.secondsRemaining}',
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 96,
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.small + 4),
          Text(
            'Starting in...',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
