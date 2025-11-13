import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/routine.dart';
import '../../../domain/models/routine_exercise.dart';
import '../../../domain/models/weight_unit.dart';
import '../../providers/preferences_provider.dart';
import '../../theme/spacing.dart';

/// Routine card widget displaying routine information
/// 
/// Phase 1: Core display with set/rep formatting, duration estimation, weight display
/// - Press animation (scale 1.0 → 0.98, 100ms)
/// - Dropdown menu with Edit/Duplicate DISABLED (Phase 2)
/// - Delete functionality with confirmation
class RoutineCard extends ConsumerStatefulWidget {
  final Routine routine;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.onTap,
    required this.onDelete,
  });

  @override
  ConsumerState<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends ConsumerState<RoutineCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weightUnit = ref.watch(weightUnitProvider);
    final preferencesActions = ref.watch(preferencesActionsProvider);

    // Use exercises from domain Routine (already populated by repository)
    final exercises = widget.routine.exercises;

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => _isPressed = true);
              _animationController.forward();
            },
            onTapUp: (_) {
              _animationController.reverse().then((_) {
                setState(() => _isPressed = false);
                widget.onTap();
              });
            },
            onTapCancel: () {
              _animationController.reverse();
              setState(() => _isPressed = false);
            },
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Card(
                elevation: _isPressed ? 2 : 4,
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
                    children: [
                      // Gradient Icon Box (64dp)
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF9333EA), // purple-600
                              Color(0xFF7E22CE), // purple-700
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF9333EA).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: AppSpacing.medium),

                      // Content Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Routine Name
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.routine.name,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Overflow Menu Button
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    if (value == 'delete') {
                                      widget.onDelete();
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      enabled: false,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Edit (Phase 2)',
                                            style: TextStyle(
                                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'duplicate',
                                      enabled: false,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.content_copy,
                                            size: 20,
                                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Duplicate (Phase 2)',
                                            style: TextStyle(
                                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: theme.colorScheme.error,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: theme.colorScheme.error,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // Exercise count
                            Text(
                              '${exercises.length} exercise${exercises.length != 1 ? 's' : ''}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),

                            if (exercises.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.small),

                              // Exercise Preview (first 4 exercises)
                              ..._buildExercisePreview(exercises, theme),

                              const SizedBox(height: AppSpacing.small),

                              // Metadata Row (Sets/Reps, Duration, Weight)
                              Row(
                                children: [
                                  // Total sets
                                  Icon(
                                    Icons.numbers,
                                    size: 16,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_calculateTotalSets(exercises)} sets',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Duration
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatEstimatedDuration(exercises),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Weight preview
                                  Icon(
                                    Icons.fitness_center,
                                    size: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatRoutineWeight(
                                      exercises,
                                      weightUnit,
                                      preferencesActions.formatWeight,
                                    ),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }

  List<Widget> _buildExercisePreview(
    List<RoutineExercise> exercises,
    ThemeData theme,
  ) {
    final previewCount = math.min(4, exercises.length);
    final previewExercises = exercises.take(previewCount).toList();
    final remaining = exercises.length - previewCount;

    return [
      ...previewExercises.map((exercise) {
        // Format set/reps: [10,10,10,8,8] → "3×10, 2×8"
        final setReps = List.generate(exercise.sets, (_) => exercise.reps);
        final formatted = _formatSetReps(setReps);

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            '${exercise.exerciseId} - $formatted',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }),
      if (remaining > 0)
        Text(
          '+ $remaining more',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
    ];
  }

  int _calculateTotalSets(List<RoutineExercise> exercises) {
    return exercises.fold(0, (sum, exercise) => sum + exercise.sets);
  }

  /// Format set/reps: Groups consecutive identical reps
  /// Example: [10,10,10,8,8] → "3×10, 2×8"
  String _formatSetReps(List<int> reps) {
    if (reps.isEmpty) return '0 sets';

    final groups = <String>[];
    int count = 1;
    int currentRep = reps[0];

    for (int i = 1; i < reps.length; i++) {
      if (reps[i] == currentRep) {
        count++;
      } else {
        groups.add('$count×$currentRep');
        currentRep = reps[i];
        count = 1;
      }
    }
    groups.add('$count×$currentRep');

    return groups.join(', ');
  }

  /// Estimate duration: 3 seconds per rep + rest time between sets
  String _formatEstimatedDuration(List<RoutineExercise> exercises) {
    if (exercises.isEmpty) return '0 min';

    int totalSeconds = 0;
    // ignore: unused_local_variable
    const defaultRestSeconds = 90; // Default rest time if not specified (Phase 2)

    for (final exercise in exercises) {
      final totalReps = exercise.reps * exercise.sets;
      totalSeconds += totalReps * 3; // 3 seconds per rep

      // Rest time between sets (exclude last set)
      // Note: Database RoutineExercise doesn't have restSeconds field yet
      // Using default 90 seconds for Phase 1
      const defaultRestSeconds = 90;
      if (exercise.sets > 1) {
        totalSeconds += defaultRestSeconds * (exercise.sets - 1);
      }
    }

    final minutes = totalSeconds ~/ 60;
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return remainingMinutes > 0 ? '${hours}h ${remainingMinutes}m' : '${hours}h';
    }
  }

  /// Format routine weight: Shows first exercise weight or range
  String _formatRoutineWeight(
    List<RoutineExercise> exercises,
    WeightUnit unit,
    String Function(double, WeightUnit) formatWeight,
  ) {
    if (exercises.isEmpty) return '';

    final firstExercise = exercises[0];

    // Check if eccentricOnly mode (adaptive weight)
    // ProgramMode is a freezed union, check variant directly
    final isEccentricMode = firstExercise.mode.maybeWhen(
      eccentricOnly: () => true,
      orElse: () => false,
    );

    if (isEccentricMode) {
      return 'Adaptive';
    }

    // For Phase 1, we only have single weight per exercise
    // Phase 2 will support per-set weights
    return formatWeight(firstExercise.weightPerCableKg, unit);
  }
}
