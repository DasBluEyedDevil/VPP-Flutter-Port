import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/eccentric_load.dart';

/// Eccentric load card widget for Echo mode
///
/// Displays a slider with 6 discrete values (0%, 50%, 75%, 100%, 125%, 150%)
/// for selecting eccentric load percentage in Echo mode.
///
/// Ported from Kotlin JustLiftScreen.kt EccentricLoadCard (lines 652-700)
class EccentricLoadCard extends StatelessWidget {
  /// Currently selected eccentric load
  final EccentricLoad eccentricLoad;

  /// Callback when eccentric load changes
  final ValueChanged<EccentricLoad> onChanged;

  const EccentricLoadCard({
    super.key,
    required this.eccentricLoad,
    required this.onChanged,
  });

  /// All available eccentric load values
  static const List<EccentricLoad> _values = [
    EccentricLoad.load0,
    EccentricLoad.load50,
    EccentricLoad.load75,
    EccentricLoad.load100,
    EccentricLoad.load125,
    EccentricLoad.load150,
  ];

  int _getIndex(EccentricLoad load) {
    return _values.indexOf(load);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final currentIndex = _getIndex(eccentricLoad);
    final sliderValue = currentIndex / (_values.length - 1);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eccentric Load: ${eccentricLoad.percentage}%',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Slider(
              value: sliderValue,
              min: 0.0,
              max: 1.0,
              divisions: _values.length - 1,
              label: '${eccentricLoad.percentage}%',
              onChanged: (value) {
                final index = (value * (_values.length - 1)).round();
                onChanged(_values[index.clamp(0, _values.length - 1)]);
              },
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Load percentage applied during eccentric (lowering) phase',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
