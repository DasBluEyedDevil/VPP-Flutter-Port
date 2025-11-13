import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Confetti particle data for animation
class ConfettiParticle {
  final double startX;
  final double startY;
  final Color color;
  final double size;
  final double rotationSpeed;
  final double velocityX;
  final double velocityY;

  ConfettiParticle({
    required this.startX,
    required this.startY,
    required this.color,
    required this.size,
    required this.rotationSpeed,
    required this.velocityX,
    required this.velocityY,
  });

  /// Create a random confetti particle
  factory ConfettiParticle.random(double width) {
    final random = math.Random();
    
    // Confetti colors: Gold, Orange, Pink, Purple, Blue, Green
    final colors = [
      const Color(0xFFFFD700), // Gold
      const Color(0xFFFFA500), // Orange
      const Color(0xFFFF69B4), // Pink
      const Color(0xFF9333EA), // Purple
      const Color(0xFF3B82F6), // Blue
      const Color(0xFF10B981), // Green
    ];

    return ConfettiParticle(
      startX: random.nextDouble() * width, // Random X position across width
      startY: 0, // Start at top
      color: colors[random.nextInt(colors.length)],
      size: random.nextDouble() * 8 + 4, // Random 4-12 dp
      rotationSpeed: (random.nextDouble() * 10 - 5) * math.pi / 180, // Random -5 to +5 degrees/sec in radians
      velocityX: random.nextDouble() * 400 - 200, // Random -200 to +200 pixels
      velocityY: random.nextDouble() * -400 - 800, // Random -800 to -1200 pixels (upward)
    );
  }

  /// Calculate position at given progress (0.0 to 1.0)
  Offset position(double progress, double width) {
    // X position: startX + velocityX * progress (normalized to screen width)
    final x = startX + (velocityX * progress) / width;
    
    // Y position: startY + velocityY * progress + gravity (0.5 * 980 * t²)
    // Convert progress to seconds (3 second animation)
    final t = progress * 3.0;
    final y = startY + (velocityY * progress) / width + (0.5 * 980 * t * t) / width;
    
    return Offset(x, y);
  }

  /// Calculate rotation angle at given progress
  double rotation(double progress) {
    final t = progress * 3.0; // Convert to seconds
    return rotationSpeed * t * 360; // Convert to degrees
  }

  /// Calculate opacity at given progress (fades from 1.0 to 0.5)
  double opacity(double progress) {
    return 1.0 - (progress * 0.5);
  }
}

/// Custom painter for confetti animation.
/// 
/// Draws 30 confetti particles with physics simulation (gravity, velocity, rotation).
class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;
  final double width;

  ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final position = particle.position(progress, width);
      final rotation = particle.rotation(progress);
      final opacity = particle.opacity(progress);

      // Skip if particle is off-screen
      if (position.dx < 0 || position.dx > size.width ||
          position.dy < 0 || position.dy > size.height) {
        continue;
      }

      // Save canvas state
      canvas.save();

      // Translate to particle position
      canvas.translate(
        position.dx * size.width,
        position.dy * size.height,
      );

      // Rotate
      canvas.rotate(rotation * math.pi / 180);

      // Draw particle as a rectangle
      final paint = Paint()
        ..color = particle.color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: particle.size,
          height: particle.size,
        ),
        paint,
      );

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.particles != particles;
  }
}
