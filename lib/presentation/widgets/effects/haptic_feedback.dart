import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Haptic feedback utility for triggering platform haptic feedback.
///
/// Ported from HapticFeedbackEffect.kt (lines 72-103)
/// Provides methods for different haptic feedback types.
///
/// Note: Haptic feedback is only available on iOS and Android.
/// On other platforms, these methods will do nothing.
class HapticFeedbackUtil {
  /// Light haptic feedback (equivalent to TextHandleMove in Compose)
  ///
  /// Used for: rep completed, workout start/end
  static Future<void> light() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.lightImpact();
    }
  }

  /// Medium haptic feedback
  ///
  /// Used for: general interactions
  static Future<void> medium() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.mediumImpact();
    }
  }

  /// Heavy haptic feedback (equivalent to LongPress in Compose)
  ///
  /// Used for: warmup complete, workout complete, errors
  static Future<void> heavy() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.heavyImpact();
    }
  }

  /// Success haptic feedback
  ///
  /// Used for: successful operations, achievements
  static Future<void> success() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.mediumImpact();
      // Add a slight delay and second impact for success feel
      await Future.delayed(const Duration(milliseconds: 50));
      await HapticFeedback.lightImpact();
    }
  }

  /// Error haptic feedback
  ///
  /// Used for: errors, failures
  static Future<void> error() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.heavyImpact();
      // Add a second impact for error feel
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.heavyImpact();
    }
  }

  /// Selection click feedback
  ///
  /// Used for: UI selections, button presses
  static Future<void> selectionClick() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await HapticFeedback.selectionClick();
    }
  }
}

/// Widget wrapper for haptic feedback.
///
/// Triggers haptic feedback when tapped.
///
/// Usage:
/// ```dart
/// HapticFeedbackWidget(
///   onTap: () => HapticFeedbackUtil.light(),
///   child: YourWidget(),
/// )
/// ```
class HapticFeedbackWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final HapticFeedbackType feedbackType;

  const HapticFeedbackWidget({
    super.key,
    required this.child,
    this.onTap,
    this.feedbackType = HapticFeedbackType.light,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _triggerHaptic();
        onTap?.call();
      },
      child: child,
    );
  }

  void _triggerHaptic() {
    switch (feedbackType) {
      case HapticFeedbackType.light:
        HapticFeedbackUtil.light();
        break;
      case HapticFeedbackType.medium:
        HapticFeedbackUtil.medium();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedbackUtil.heavy();
        break;
      case HapticFeedbackType.success:
        HapticFeedbackUtil.success();
        break;
      case HapticFeedbackType.error:
        HapticFeedbackUtil.error();
        break;
      case HapticFeedbackType.selectionClick:
        HapticFeedbackUtil.selectionClick();
        break;
    }
  }
}

/// Haptic feedback type enum
enum HapticFeedbackType {
  light,
  medium,
  heavy,
  success,
  error,
  selectionClick,
}
