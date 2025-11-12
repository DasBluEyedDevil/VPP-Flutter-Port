import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Shimmer effect for skeleton loading screens.
/// Creates an animated gradient that sweeps across placeholder content.
///
/// Ported from ShimmerEffect.kt (lines 24-62)
ui.Shader shimmerGradient({
  double targetValue = 1000.0,
  bool showShimmer = true,
  required double animationValue,
  required double width,
  required double height,
}) {
  if (!showShimmer) {
    return const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
    ).createShader(Rect.fromLTWH(0, 0, width, height));
  }

  final shimmerColors = [
    Colors.grey.withOpacity(0.6),
    Colors.grey.withOpacity(0.2),
    Colors.grey.withOpacity(0.6),
  ];

  // Calculate gradient offset based on animation
  final offset = animationValue % (targetValue * 2) - targetValue;

  return LinearGradient(
    colors: shimmerColors,
    begin: Alignment(-1.0 + (offset / targetValue), -1.0 + (offset / targetValue)),
    end: Alignment(1.0 + (offset / targetValue), 1.0 + (offset / targetValue)),
    stops: const [0.0, 0.5, 1.0],
  ).createShader(Rect.fromLTWH(0, 0, width, height));
}

/// Shimmer box placeholder - generic rectangular shimmer element.
///
/// Ported from ShimmerEffect.kt (lines 67-79)
class ShimmerBox extends StatefulWidget {
  final Widget? child;
  final bool enabled;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    this.child,
    this.enabled = true,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(
            widget.width ?? 100,
            widget.height ?? 100,
          ),
          painter: _ShimmerPainter(
            animationValue: _controller.value * 1000,
            enabled: widget.enabled,
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final double animationValue;
  final bool enabled;

  _ShimmerPainter({
    required this.animationValue,
    required this.enabled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!enabled) return;

    final shimmerColors = [
      Colors.grey.withOpacity(0.6),
      Colors.grey.withOpacity(0.2),
      Colors.grey.withOpacity(0.6),
    ];

    final offset = animationValue % 2000 - 1000;
    final gradient = LinearGradient(
      colors: shimmerColors,
      begin: Alignment(-1.0 + (offset / 1000), -1.0 + (offset / 1000)),
      end: Alignment(1.0 + (offset / 1000), 1.0 + (offset / 1000)),
      stops: const [0.0, 0.5, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.enabled != enabled;
  }
}

/// Wrapper widget that applies shimmer effect to its child.
///
/// Usage:
/// ```dart
/// ShimmerEffect(
///   enabled: isLoading,
///   child: YourWidget(),
/// )
/// ```
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return shimmerGradient(
              animationValue: _controller.value * 1000,
              showShimmer: widget.enabled,
              width: bounds.width,
              height: bounds.height,
            );
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
