import 'package:flutter/material.dart';
import '../../../data/database/app_database.dart';

/// Routine card widget displaying routine information with gradient icon and animations.
/// 
/// Matches Kotlin RoutineCard exactly with:
/// - 64dp gradient icon box (purple-500 → purple-700)
/// - Spring press animation (1.0 → 0.99 scale, 100ms)
/// - Content: name, description, metadata row, exercise preview
/// - Overflow menu: Edit, Duplicate, Delete
class RoutineCard extends StatefulWidget {
  final Routine routine;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.onTap,
    required this.onEdit,
    required this.onDuplicate,
    required this.onDelete,
  });

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.99).animate(
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) {
          _animationController.reverse();
          widget.onTap();
        },
        onTapCancel: () => _animationController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Card(
            elevation: 4,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Color(0xFFF5F3FF), // purple-50
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                          Color(0xFF9333EA), // purple-500
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

                  const SizedBox(width: 16),

                  // Content Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Routine Name
                        Text(
                          widget.routine.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        // Description or exercise count
                        Text(
                          '${widget.routine.exerciseCount} exercise${widget.routine.exerciseCount != 1 ? 's' : ''}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // Metadata Row (Sets/Reps and Duration)
                        // Note: We'll need to load routine exercises to show this properly
                        // For now, showing placeholder
                        Row(
                          children: [
                            Icon(
                              Icons.numbers,
                              size: 16,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Sets info', // TODO: Load and format actual sets/reps
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Duration', // TODO: Calculate from exercises
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Exercise Preview
                        Text(
                          'Exercise preview', // TODO: Load and format actual exercises
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Overflow Menu Button
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          widget.onEdit();
                          break;
                        case 'duplicate':
                          widget.onDuplicate();
                          break;
                        case 'delete':
                          widget.onDelete();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 12),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: Row(
                          children: [
                            Icon(Icons.content_copy, size: 20),
                            SizedBox(width: 12),
                            Text('Duplicate'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20),
                            SizedBox(width: 12),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper function to format set/reps display
/// Groups consecutive identical reps: [10, 10, 8] → "2×10, 1×8"
String formatSetReps(List<int> reps) {
  if (reps.isEmpty) return '0 sets';

  final groups = <String>[];
  int count = 1;
  int? currentRep = reps.first;

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

/// Helper function to format estimated duration
/// Formula: totalReps × 3 seconds + (sets × restTime)
/// Note: Database RoutineExercise doesn't have restSeconds, using default 90s
String formatEstimatedDuration(List<RoutineExercise> exercises) {
  if (exercises.isEmpty) return '0 min';

  int totalSeconds = 0;
  const defaultRestSeconds = 90; // Default rest time if not specified
  for (final exercise in exercises) {
    final totalReps = exercise.reps * exercise.sets; // Total reps for this exercise
    totalSeconds += totalReps * 3; // 3 seconds per rep
    totalSeconds += exercise.sets * defaultRestSeconds; // rest between sets (default 90s)
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

/// Helper function to format exercise preview
/// Shows first 4 exercise IDs + remainder count
String formatExercisePreview(List<RoutineExercise> exercises) {
  if (exercises.isEmpty) return 'No exercises';

  final preview = exercises.take(4).map((e) => e.exerciseId).join(', ');
  final remaining = exercises.length - 4;

  return remaining > 0 ? '$preview, + $remaining more' : preview;
}

/// Helper function to format set/reps for a single exercise
/// Converts sets × reps to format like "3×10" (for 3 sets of 10 reps)
String formatSetRepsForExercise(RoutineExercise exercise) {
  return '${exercise.sets}×${exercise.reps}';
}
