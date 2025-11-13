import 'dart:async';
import 'package:flutter/material.dart';
import '../../../domain/models/pr_celebration_event.dart';
import '../../theme/spacing.dart';
import 'confetti_painter.dart';

/// PR Celebration Dialog - Full-screen celebration with confetti animation.
/// 
/// Displays when user achieves a new Personal Record during workout.
/// Auto-dismisses after 3 seconds.
class PRCelebrationDialog extends StatefulWidget {
  final PRCelebrationEvent event;
  final VoidCallback onDismiss;

  const PRCelebrationDialog({
    super.key,
    required this.event,
    required this.onDismiss,
  });

  @override
  State<PRCelebrationDialog> createState() => _PRCelebrationDialogState();
}

class _PRCelebrationDialogState extends State<PRCelebrationDialog>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late List<ConfettiParticle> _particles;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();

    // Confetti animation (3 seconds, loops)
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Pulse animation (500ms, reverse infinite)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    // Generate 30 confetti particles (will be initialized in build when we have width)
    _particles = [];

    // Auto-dismiss after 3 seconds
    _autoDismissTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pulseController.dispose();
    _autoDismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Initialize particles once we have width
          if (_particles.isEmpty) {
            _particles = List.generate(
              30,
              (_) => ConfettiParticle.random(constraints.maxWidth),
            );
          }

          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Stack(
              children: [
                // Confetti layer (behind content)
                AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ConfettiPainter(
                        particles: _particles,
                        progress: _confettiController.value,
                        width: constraints.maxWidth,
                      ),
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                    );
                  },
                ),

                // Content layer
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.extraLarge), // 32dp
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Three gold stars (pulsing)
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index > 0 ? AppSpacing.small : 0,
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    size: 32,
                                    color: const Color(0xFFFFD700), // Gold
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: AppSpacing.medium), // 16dp

                      // "NEW PR!" text (pulsing)
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Text(
                              'NEW PR!',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),

                      SizedBox(height: AppSpacing.medium), // 16dp

                      // Exercise name
                      Text(
                        widget.event.exerciseName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: AppSpacing.medium), // 16dp

                      // Weight badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.large, // 24dp
                          vertical: AppSpacing.medium, // 12dp
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          '${widget.event.weightPerCableKg.toStringAsFixed(1)} kg/cable × ${widget.event.reps} reps',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: AppSpacing.small), // 8dp

                      // "Tap to dismiss" hint
                      Text(
                        'Tap to dismiss',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0x99, // 0.6 alpha
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
