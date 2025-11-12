import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/spacing.dart';

/// A compact inline number picker widget with increment/decrement buttons.
///
/// Displays a number value with stepper buttons on either side.
/// Supports decimal steps (e.g., 0.5 kg increments), min/max bounds,
/// haptic feedback, and debouncing for rapid taps.
///
/// Example:
/// ```dart
/// CompactNumberPicker(
///   value: 10.5,
///   min: 0.0,
///   max: 100.0,
///   step: 0.5,
///   unit: 'kg',
///   onChange: (value) => print('Selected: $value'),
/// )
/// ```
class CompactNumberPicker extends StatefulWidget {
  /// Current value
  final double value;

  /// Minimum allowed value
  final double min;

  /// Maximum allowed value
  final double max;

  /// Step increment/decrement amount
  final double step;

  /// Unit label to display after the value (e.g., 'kg', 'lb', 'reps')
  final String? unit;

  /// Callback when value changes
  final ValueChanged<double> onChange;

  /// Whether the picker is enabled
  final bool enabled;

  /// Semantic label for accessibility
  final String? semanticLabel;

  const CompactNumberPicker({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    this.unit,
    required this.onChange,
    this.enabled = true,
    this.semanticLabel,
  }) : assert(min <= max, 'min must be <= max'),
       assert(step > 0, 'step must be > 0'),
       assert(value >= min && value <= max, 'value must be between min and max');

  @override
  State<CompactNumberPicker> createState() => _CompactNumberPickerState();
}

class _CompactNumberPickerState extends State<CompactNumberPicker> {
  Timer? _debounceTimer;
  bool _isDecrementing = false;
  bool _isIncrementing = false;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Clamp value to min/max bounds
  double _clampValue(double value) {
    return value.clamp(widget.min, widget.max);
  }

  /// Round value to nearest step
  double _roundToStep(double value) {
    return (value / widget.step).round() * widget.step;
  }

  /// Handle increment with debouncing
  void _increment() {
    if (!widget.enabled) return;
    if (widget.value >= widget.max) return;

    HapticFeedback.selectionClick();
    setState(() => _isIncrementing = true);

    final newValue = _clampValue(_roundToStep(widget.value + widget.step));
    widget.onChange(newValue);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => _isIncrementing = false);
      }
    });
  }

  /// Handle decrement with debouncing
  void _decrement() {
    if (!widget.enabled) return;
    if (widget.value <= widget.min) return;

    HapticFeedback.selectionClick();
    setState(() => _isDecrementing = true);

    final newValue = _clampValue(_roundToStep(widget.value - widget.step));
    widget.onChange(newValue);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => _isDecrementing = false);
      }
    });
  }

  /// Format value for display (remove trailing zeros for whole numbers)
  String _formatValue(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAtMin = widget.value <= widget.min;
    final isAtMax = widget.value >= widget.max;

    return Semantics(
      label: widget.semanticLabel ?? 'Number picker',
      value: '${_formatValue(widget.value)}${widget.unit != null ? ' ${widget.unit}' : ''}',
      button: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement button
          _StepperButton(
            icon: Icons.remove,
            onPressed: widget.enabled && !isAtMin ? _decrement : null,
            isPressed: _isDecrementing,
            tooltip: 'Decrease',
          ),
          
          // Value display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
            child: Text(
              '${_formatValue(widget.value)}${widget.unit != null ? ' ${widget.unit}' : ''}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: widget.enabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ),
          
          // Increment button
          _StepperButton(
            icon: Icons.add,
            onPressed: widget.enabled && !isAtMax ? _increment : null,
            isPressed: _isIncrementing,
            tooltip: 'Increase',
          ),
        ],
      ),
    );
  }
}

/// Internal button widget for the stepper
class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPressed;
  final String tooltip;

  const _StepperButton({
    required this.icon,
    this.onPressed,
    this.isPressed = false,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPressed
                  ? colorScheme.primaryContainer
                  : onPressed != null
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.surfaceContainerHighest.withValues(alpha: 0.38),
            ),
            child: Icon(
              icon,
              size: 20,
              color: onPressed != null
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.38),
            ),
          ),
        ),
      ),
    );
  }
}
