import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/echo_level.dart';

/// Echo level card widget for Echo mode
///
/// Displays 4 FilterChips for echo level selection: Hard, Harder, Hardest, Epic
///
/// Ported from Kotlin JustLiftScreen.kt EchoLevelCard (lines 702-750)
class EchoLevelCard extends StatelessWidget {
  /// Currently selected echo level
  final EchoLevel selectedLevel;

  /// Callback when echo level changes
  final ValueChanged<EchoLevel> onChanged;

  const EchoLevelCard({
    super.key,
    required this.selectedLevel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Echo Level',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Row(
              children: [
                Expanded(
                  child: _buildLevelChip(context, EchoLevel.hard, 'Hard'),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: _buildLevelChip(context, EchoLevel.harder, 'Harder'),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: _buildLevelChip(context, EchoLevel.hardest, 'Hardest'),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: _buildLevelChip(context, EchoLevel.epic, 'Epic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelChip(
    BuildContext context,
    EchoLevel level,
    String label,
  ) {
    final theme = Theme.of(context);
    final isSelected = selectedLevel == level;

    return FilterChip(
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      selected: isSelected,
      showCheckmark: true,
      onSelected: (selected) {
        if (selected) {
          onChanged(level);
        }
      },
      labelStyle: theme.textTheme.bodySmall,
    );
  }
}
