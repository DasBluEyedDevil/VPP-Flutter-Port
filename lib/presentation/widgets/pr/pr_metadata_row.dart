import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/spacing.dart';

/// Metadata row widget for Personal Record cards.
/// 
/// Displays: "{reps} reps • {mode} • {date}"
/// Uses bodySmall typography with onSurfaceVariant color (except mode which is secondary).
class PRMetadataRow extends StatelessWidget {
  final int reps;
  final String workoutMode;
  final int timestamp;

  const PRMetadataRow({
    super.key,
    required this.reps,
    required this.workoutMode,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Format date: "MMM d, yyyy" (e.g., "Nov 12, 2025")
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formattedDate = DateFormat('MMM d, yyyy').format(date);

    return Row(
      children: [
        Text(
          '$reps reps',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: AppSpacing.extraSmall), // 4dp
        Text(
          '•',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: AppSpacing.extraSmall), // 4dp
        Text(
          workoutMode,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.secondary,
          ),
        ),
        SizedBox(width: AppSpacing.extraSmall), // 4dp
        Text(
          '•',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: AppSpacing.extraSmall), // 4dp
        Text(
          formattedDate,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
