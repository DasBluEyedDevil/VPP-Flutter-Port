import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Rank badge widget for Personal Record cards.
/// 
/// Displays "#{rank}" with color coding:
/// - Rank #1: tertiary color
/// - Rank #2-3: secondary color
/// - Rank #4+: purple (#9333EA)
class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({
    super.key,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine colors based on rank
    final Color backgroundColor;
    final Color textColor;

    if (rank == 1) {
      backgroundColor = colorScheme.tertiary;
      textColor = colorScheme.onTertiary;
    } else if (rank <= 3) {
      backgroundColor = colorScheme.secondary;
      textColor = colorScheme.onSecondary;
    } else {
      backgroundColor = const Color(0xFFF5F3FF);
      textColor = const Color(0xFF9333EA);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.small, // 8dp
        vertical: AppSpacing.extraSmall, // 4dp
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        '#$rank',
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
