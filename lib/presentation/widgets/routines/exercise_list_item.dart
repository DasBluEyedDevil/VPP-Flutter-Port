import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/routine_exercise.dart';
import '../../../domain/models/weight_unit.dart';
import '../../providers/preferences_provider.dart';
import '../../theme/spacing.dart';

/// Exercise list item widget for RoutineBuilderDialog
///
/// Phase 2: Core display with reorder buttons, tags, and actions
/// - Reorder buttons (up/down arrows, 32dp each)
/// - Exercise info: name, set/rep tag, weight tag
/// - Optional tags: progression (if != 0), rest time (if > 0)
/// - Notes display (if not empty, italic, 2 lines max) - STUB for Phase 2
/// - Action buttons: Edit (STUB - snackbar), Delete (functional)
class ExerciseListItem extends ConsumerWidget {
  final RoutineExercise exercise;
  final String exerciseName; // Exercise name from database
  final int index;
  final int totalCount;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.exerciseName,
    required this.index,
    required this.totalCount,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final weightUnit = ref.watch(weightUnitProvider);
    final preferencesActions = ref.watch(preferencesActionsProvider);
    
    final isFirst = index == 0;
    final isLast = index == totalCount - 1;

    return Card(
      elevation: 4,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFF5F3FF), // purple-50
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reorder buttons column (64dp width)
            SizedBox(
              width: 64,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Move up button
                  IconButton(
                    onPressed: isFirst ? null : onMoveUp,
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                      size: 20,
                      color: isFirst
                          ? theme.colorScheme.outlineVariant
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    style: IconButton.styleFrom(
                      fixedSize: const Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Move down button
                  IconButton(
                    onPressed: isLast ? null : onMoveDown,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: isLast
                          ? theme.colorScheme.outlineVariant
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    style: IconButton.styleFrom(
                      fixedSize: const Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.small),

            // Exercise info column (expanded)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise name
                  Text(
                    exerciseName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.small),

                  // Set/Rep and Weight tags row
                  Wrap(
                    spacing: AppSpacing.small,
                    runSpacing: AppSpacing.small,
                    children: [
                      // Set/Rep tag
                      _buildTag(
                        text: _formatReps(exercise.sets, exercise.reps),
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                        textColor: theme.colorScheme.primary,
                        theme: theme,
                      ),

                      // Weight tag
                      _buildTag(
                        text: _formatWeight(exercise, weightUnit, preferencesActions),
                        backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.15),
                        textColor: theme.colorScheme.secondary,
                        theme: theme,
                      ),

                      // Rest time tag (if > 0)
                      if (exercise.restSeconds > 0)
                        _buildTag(
                          text: '${exercise.restSeconds}s rest',
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          textColor: theme.colorScheme.onSurfaceVariant,
                          theme: theme,
                        ),
                    ],
                  ),

                  // Notes display (STUB - Phase 2: RoutineExercise doesn't have notes field yet)
                  // Will be implemented in Phase 3 when notes field is added
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.small),

            // Action buttons column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button (STUB - Phase 3)
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Exercise editing coming in Phase 3'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  style: IconButton.styleFrom(
                    fixedSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                  ),
                ),

                const SizedBox(height: 4),

                // Delete button
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: theme.colorScheme.error,
                  ),
                  style: IconButton.styleFrom(
                    fixedSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build a tag widget with rounded corners
  Widget _buildTag({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Format reps for display
  /// Example: 3 sets × 10 reps → "3 x 10 reps"
  /// Example: Different reps → "3 sets: 10/8/6" (not applicable in Phase 2 - single reps per exercise)
  String _formatReps(int sets, int reps) {
    return '$sets x $reps reps';
  }

  /// Format weight for display
  /// Echo mode → 'Adaptive', single weight → value
  String _formatWeight(
    RoutineExercise exercise,
    WeightUnit unit,
    PreferencesActions preferencesActions,
  ) {
    // Check if eccentricOnly mode (adaptive weight)
    final isEccentricMode = exercise.mode.maybeWhen(
      eccentricOnly: () => true,
      orElse: () => false,
    );

    if (isEccentricMode) {
      return 'Adaptive';
    }

    // For Phase 2, we only have single weight per exercise
    // Phase 3 will support per-set weights
    return preferencesActions.formatWeight(exercise.weightPerCableKg, unit);
  }
}
