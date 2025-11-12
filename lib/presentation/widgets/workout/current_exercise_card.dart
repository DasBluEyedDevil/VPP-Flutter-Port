import 'package:flutter/material.dart';

/// Current exercise card displaying exercise name and set progress
///
/// Shows exercise name, set progress, and video placeholder (Phase 2: actual video)
class CurrentExerciseCard extends StatelessWidget {
  final String exerciseName;
  final int currentSet;
  final int totalSets;
  final String? videoUrl; // For Phase 2
  final bool enableVideoPlayback;

  const CurrentExerciseCard({
    super.key,
    required this.exerciseName,
    required this.currentSet,
    required this.totalSets,
    this.videoUrl,
    this.enableVideoPlayback = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise name
            Text(
              exerciseName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Set progress
            Text(
              'Set $currentSet of $totalSets',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            // Video placeholder (200dp height)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Exercise Video',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
