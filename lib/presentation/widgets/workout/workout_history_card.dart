import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/workout_session.dart';
import '../../../domain/models/weight_unit.dart';
import '../common/enhanced_metric_item.dart';
import '../common/date_formatters.dart';
import '../settings/gradient_icon_box.dart';
import '../dialogs/delete_confirmation_dialog.dart';
import '../../theme/spacing.dart';

/// Workout history card widget displaying a completed workout session.
///
/// Ported from Kotlin WorkoutHistoryCard composable (lines 116-342).
/// Displays exercise name, timestamp, duration, metrics grid, and delete button.
class WorkoutHistoryCard extends ConsumerStatefulWidget {
  /// The workout session to display
  final WorkoutSession session;

  /// Weight unit for formatting
  final WeightUnit weightUnit;

  /// Function to format weight for display
  final String Function(double, WeightUnit) formatWeight;

  /// Exercise name (if available, otherwise defaults to "Just Lift")
  final String? exerciseName;

  /// Callback when delete button is tapped
  final VoidCallback onDelete;

  const WorkoutHistoryCard({
    super.key,
    required this.session,
    required this.weightUnit,
    required this.formatWeight,
    this.exerciseName,
    required this.onDelete,
  });

  @override
  ConsumerState<WorkoutHistoryCard> createState() => _WorkoutHistoryCardState();
}

class _WorkoutHistoryCardState extends ConsumerState<WorkoutHistoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Spring animation: scale 1.0 → 0.98, 150ms
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Press animation (cosmetic only, no navigation)
    _scaleController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _scaleController.reverse();
        }
      });
    });
  }

  Future<void> _handleDelete() async {
    final confirmed = await DeleteConfirmationDialog.show(
      context,
      title: 'Delete Workout?',
      message: 'This action cannot be undone.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirmed == true && mounted) {
      widget.onDelete();
    }
  }

  /// Calculate progress bar value (reps in current set / reps per set)
  double _calculateProgress() {
    if (widget.session.workingReps > 0 && widget.session.reps > 0) {
      final repsInCurrentSet = widget.session.workingReps % widget.session.reps;
      return repsInCurrentSet == 0 ? 1.0 : repsInCurrentSet / widget.session.reps;
    }
    return 0.0;
  }

  /// Calculate number of sets completed
  int _calculateSets() {
    if (widget.session.reps == 0) return 0;
    return (widget.session.workingReps / widget.session.reps).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color(0xFFF5F3FF), // Light purple border
            width: 1,
          ),
        ),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.medium), // 16dp
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Icon + Exercise Name + Date + Duration Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gradient Icon Box (48×48dp)
                    GradientIconBox(
                      icon: Icons.fitness_center,
                      gradientColors: const [
                        Color(0xFF14B8A6), // Teal
                        Color(0xFF06B6D4), // Cyan
                      ],
                      size: 48,
                    ),
                    const SizedBox(width: AppSpacing.medium), // 16dp
                    // Exercise Name + Date Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exercise Name (titleLarge Bold)
                          Text(
                            widget.exerciseName ?? 'Just Lift',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.extraSmall), // 4dp
                          // Date/Time (bodyMedium)
                          Text(
                            formatRelativeTimestamp(widget.session.timestamp),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Duration Badge (top-right)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.small, // 8dp
                        vertical: AppSpacing.extraSmall, // 4dp
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formatDuration(widget.session.duration),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.medium), // 16dp
                // Progress Bar
                LinearProgressIndicator(
                  value: _calculateProgress(),
                  minHeight: 6,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: AppSpacing.medium), // 16dp
                // Stats Grid (2×2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: EnhancedMetricItem(
                        icon: Icons.check,
                        label: 'Total Reps',
                        value: widget.session.totalReps.toString(),
                      ),
                    ),
                    Expanded(
                      child: EnhancedMetricItem(
                        icon: Icons.format_list_numbered,
                        label: 'Sets',
                        value: _calculateSets().toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.small), // 8dp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: EnhancedMetricItem(
                        icon: Icons.info,
                        label: 'Weight/Cable',
                        value: widget.formatWeight(
                          widget.session.weightPerCableKg,
                          widget.weightUnit,
                        ),
                      ),
                    ),
                    Expanded(
                      child: EnhancedMetricItem(
                        icon: Icons.settings,
                        label: 'Mode',
                        value: widget.session.mode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.small), // 8dp
                // Divider
                Divider(
                  thickness: 1,
                  color: theme.colorScheme.outlineVariant,
                ),
                const SizedBox(height: AppSpacing.small), // 8dp
                // Delete Button (right-aligned)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: _handleDelete,
                      icon: const Icon(Icons.delete, size: 18),
                      label: const Text('Delete'),
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
