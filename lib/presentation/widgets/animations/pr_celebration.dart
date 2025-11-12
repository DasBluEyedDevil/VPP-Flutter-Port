import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../domain/models/pr_celebration_event.dart';

/// PR Celebration Dialog - Shows animated celebration when user achieves a new Personal Record
///
/// Features:
/// - Confetti explosion animation
/// - Pulsing "NEW PR!" text
/// - Star icons with scale animation
/// - Auto-dismisses after celebration
///
/// Ported from PRCelebrationAnimation.kt (lines 53-252)
///
/// Usage:
/// ```dart
/// PRCelebrationAnimation(
///   show: showCelebration,
///   prData: prCelebrationEvent,
///   onComplete: () => setState(() => showCelebration = false),
/// )
/// ```
class PRCelebrationAnimation extends StatefulWidget {
  final bool show;
  final PRCelebrationEvent? prData;
  final VoidCallback? onComplete;

  const PRCelebrationAnimation({
    super.key,
    required this.show,
    this.prData,
    this.onComplete,
  });

  @override
  State<PRCelebrationAnimation> createState() => _PRCelebrationAnimationState();
}

class _PRCelebrationAnimationState extends State<PRCelebrationAnimation>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _pulseController;
  late AnimationController _starRotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _starRotationAnimation;

  @override
  void initState() {
    super.initState();

    // Confetti controller
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Pulse animation for "NEW PR!" text
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _pulseController.repeat(reverse: true);

    // Star rotation animation
    _starRotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _starRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _starRotationController,
        curve: Curves.linear,
      ),
    );
    _starRotationController.repeat();
  }

  @override
  void didUpdateWidget(PRCelebrationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _confettiController.play();
      // Auto-dismiss after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && widget.show) {
          widget.onComplete?.call();
        }
      });
    } else if (!widget.show && oldWidget.show) {
      _confettiController.stop();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pulseController.dispose();
    _starRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show || widget.prData == null) {
      return const SizedBox.shrink();
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Confetti layer
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: math.pi / 2, // Downward
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              shouldLoop: false,
              colors: const [
                Color(0xFFFFD700), // Gold
                Color(0xFFFFA500), // Orange
                Color(0xFFFF69B4), // Pink
                Color(0xFF9333EA), // Purple
                Color(0xFF3B82F6), // Blue
                Color(0xFF10B981), // Green
              ],
            ),
          ),
          // Content
          _PRCelebrationContent(
            prData: widget.prData!,
            pulseAnimation: _pulseAnimation,
            starRotationAnimation: _starRotationAnimation,
            onDismiss: widget.onComplete,
          ),
        ],
      ),
    );
  }
}

class _PRCelebrationContent extends StatelessWidget {
  final PRCelebrationEvent prData;
  final Animation<double> pulseAnimation;
  final Animation<double> starRotationAnimation;
  final VoidCallback? onDismiss;

  const _PRCelebrationContent({
    required this.prData,
    required this.pulseAnimation,
    required this.starRotationAnimation,
    this.onDismiss,
  });

  String _formatWeight() {
    // Format weight similar to Kotlin implementation
    return '${prData.weightPerCableKg.toStringAsFixed(1)} kg';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spinning stars
            AnimatedBuilder(
              animation: starRotationAnimation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Transform.rotate(
                      angle: starRotationAnimation.value + (index * 0.5),
                      child: Transform.scale(
                        scale: pulseAnimation.value,
                        child: const Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                          size: 32,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),

            const SizedBox(height: 16),

            // "NEW PR!" text with pulse
            AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: pulseAnimation.value,
                  child: Text(
                    'NEW PR!',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Exercise name
            Text(
              prData.exerciseName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 16),

            // Weight achieved
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _formatWeight(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Tap to dismiss hint
            Text(
              'Tap to dismiss',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
