import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A scrollable wheel-style number picker widget.
///
/// Displays a ListWheelScrollView with selectable values.
/// Supports decimal steps (e.g., 0.5 kg increments), min/max bounds,
/// and snaps to valid values.
///
/// Example:
/// ```dart
/// CustomNumberPicker(
///   value: 10.5,
///   min: 0.0,
///   max: 100.0,
///   step: 0.5,
///   unit: 'kg',
///   itemHeight: 50,
///   visibleItems: 5,
///   onChange: (value) => print('Selected: $value'),
/// )
/// ```
class CustomNumberPicker extends StatefulWidget {
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

  /// Height of each item in the wheel
  final double itemHeight;

  /// Number of visible items in the wheel
  final int visibleItems;

  /// Callback when value changes
  final ValueChanged<double> onChange;

  /// Whether the picker is enabled
  final bool enabled;

  /// Semantic label for accessibility
  final String? semanticLabel;

  const CustomNumberPicker({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    this.unit,
    this.itemHeight = 50.0,
    this.visibleItems = 5,
    required this.onChange,
    this.enabled = true,
    this.semanticLabel,
  }) : assert(min <= max, 'min must be <= max'),
       assert(step > 0, 'step must be > 0'),
       assert(value >= min && value <= max, 'value must be between min and max'),
       assert(itemHeight > 0, 'itemHeight must be > 0'),
       assert(visibleItems > 0, 'visibleItems must be > 0');

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  late FixedExtentScrollController _scrollController;
  late List<double> _values;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateValues();
    _selectedIndex = _values.indexOf(widget.value);
    if (_selectedIndex == -1) {
      // Find closest value
      final index = _values.indexWhere((v) => v >= widget.value);
      _selectedIndex = index == -1 ? _values.length - 1 : index;
    }
    _scrollController = FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void didUpdateWidget(CustomNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.min != widget.min ||
        oldWidget.max != widget.max ||
        oldWidget.step != widget.step) {
      _generateValues();
      _updateSelectedIndex();
    } else if (oldWidget.value != widget.value) {
      _updateSelectedIndex();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Generate list of valid values based on min, max, and step
  void _generateValues() {
    _values = [];
    double current = widget.min;
    while (current <= widget.max) {
      _values.add(_roundToStep(current));
      current += widget.step;
    }
    // Ensure max is included even if it doesn't align with step
    if (_values.isEmpty || _values.last < widget.max) {
      _values.add(widget.max);
    }
  }

  /// Round value to nearest step
  double _roundToStep(double value) {
    return (value / widget.step).round() * widget.step;
  }

  /// Update selected index based on current value
  void _updateSelectedIndex() {
    final newIndex = _values.indexWhere(
      (v) => (v - widget.value).abs() < widget.step / 2,
    );
    if (newIndex != -1 && newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
      if (_scrollController.hasClients) {
        _scrollController.animateToItem(
          _selectedIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }
  }

  /// Handle scroll change
  void _onSelectedItemChanged(int index) {
    if (index < 0 || index >= _values.length) return;
    if (!widget.enabled) return;

    setState(() {
      _selectedIndex = index;
    });

    final newValue = _values[index];
    if (newValue != widget.value) {
      HapticFeedback.selectionClick();
      widget.onChange(newValue);
    }
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

    return Semantics(
      label: widget.semanticLabel ?? 'Number picker wheel',
      value: '${_formatValue(widget.value)}${widget.unit != null ? ' ${widget.unit}' : ''}',
      child: SizedBox(
        height: widget.itemHeight * widget.visibleItems,
        child: Stack(
          children: [
            // Wheel scroll view
            ListWheelScrollView.useDelegate(
              controller: _scrollController,
              itemExtent: widget.itemHeight,
              physics: widget.enabled
                  ? const FixedExtentScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              onSelectedItemChanged: _onSelectedItemChanged,
              diameterRatio: 1.5,
              perspective: 0.003,
              offAxisFraction: 0.0,
              useMagnifier: false,
              magnification: 1.0,
              squeeze: 1.0,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _values.length) {
                    return const SizedBox.shrink();
                  }

                  final value = _values[index];
                  final isSelected = index == _selectedIndex;

                  return Center(
                    child: Text(
                      '${_formatValue(value)}${widget.unit != null ? ' ${widget.unit}' : ''}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: widget.enabled
                            ? (isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.6))
                            : colorScheme.onSurface.withValues(alpha: 0.38),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: isSelected ? 24 : 18,
                      ),
                    ),
                  );
                },
                childCount: _values.length,
              ),
            ),

            // Highlight overlay for selected item
            IgnorePointer(
              child: Center(
                child: Container(
                  height: widget.itemHeight,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
