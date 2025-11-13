import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

/// Empty state widget for when no routines exist
/// 
/// Phase 1: Shows message that builder is coming in Phase 2
class EmptyRoutinesState extends StatelessWidget {
  const EmptyRoutinesState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              'No Routines Yet',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Create your first workout routine to get started.\n(Routine builder coming in Phase 2)',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
