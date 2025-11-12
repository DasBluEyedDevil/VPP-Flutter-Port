import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Splash screen shown on app launch
///
/// Displays Vitruvian Phoenix logo on solid orange background.
/// Visibility is controlled externally via the `visible` parameter.
/// Navigation should be handled by the parent widget.
class SplashScreen extends StatelessWidget {
  /// Controls the visibility of the splash screen with fade animation
  final bool visible;

  const SplashScreen({
    super.key,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Scale logo to ~55% of the smallest screen dimension for prominent display
    final minDimension = math.min(size.width, size.height);
    final logoSize = minDimension * 0.55;

    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFF5722), // Deep Orange 500 - solid background
        child: Center(
          child: Image.asset(
            'assets/images/vitphoe_logo.png',
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
