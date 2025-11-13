import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/weight_unit.dart';

/// Weight unit selector widget with optimistic UI
///
/// Displays KG/LB choice chips side-by-side with immediate visual feedback.
/// Ported from Kotlin SettingsScreen.kt FilterChip implementation.
class WeightUnitSelector extends StatefulWidget {
  /// Currently selected weight unit
  final WeightUnit selectedUnit;

  /// Callback when unit is changed
  final ValueChanged<WeightUnit> onChanged;

  const WeightUnitSelector({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  State<WeightUnitSelector> createState() => _WeightUnitSelectorState();
}

class _WeightUnitSelectorState extends State<WeightUnitSelector> {
  late WeightUnit _localUnit;

  @override
  void initState() {
    super.initState();
    _localUnit = widget.selectedUnit;
  }

  @override
  void didUpdateWidget(WeightUnitSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedUnit != oldWidget.selectedUnit) {
      _localUnit = widget.selectedUnit;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('kg'),
            selected: _localUnit == WeightUnit.kg,
            onSelected: (selected) {
              if (selected) {
                setState(() => _localUnit = WeightUnit.kg);
                widget.onChanged(WeightUnit.kg);
              }
            },
            selectedColor: colorScheme.primary,
            labelStyle: TextStyle(
              color: _localUnit == WeightUnit.kg
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
        ),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: ChoiceChip(
            label: const Text('lbs'),
            selected: _localUnit == WeightUnit.lb,
            onSelected: (selected) {
              if (selected) {
                setState(() => _localUnit = WeightUnit.lb);
                widget.onChanged(WeightUnit.lb);
              }
            },
            selectedColor: colorScheme.primary,
            labelStyle: TextStyle(
              color: _localUnit == WeightUnit.lb
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
