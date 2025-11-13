import 'package:flutter/material.dart';
import '../../../domain/models/personal_record.dart';
import '../../theme/spacing.dart';
import 'rank_badge.dart';
import 'pr_metadata_row.dart';

/// Personal Record Card widget.
/// 
/// Displays a single PR with rank badge, exercise name, weight, reps, mode, and date.
/// Includes spring press animation (1.0 → 0.98 scale, 150ms).
class PersonalRecordCard extends StatefulWidget {
  final PersonalRecord pr;
  final int rank;
  final String exerciseName;
  final String weightUnit; // "kg" or "lbs"

  const PersonalRecordCard({
    super.key,
    required this.pr,
    required this.rank,
    required this.exerciseName,
    this.weightUnit = 'kg',
  });

  @override
  State<PersonalRecordCard> createState() => _PersonalRecordCardState();
}

class _PersonalRecordCardState extends State<PersonalRecordCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
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

  void _handleTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _scaleController.reverse();
      }
    });
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  color: Color(0xFFF5F3FF), // Soft lavender border
                  width: 1.0,
                ),
              ),
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.medium), // 16dp
                child: Row(
                  children: [
                    // Left section: Rank badge + Exercise details
                    Expanded(
                      child: Row(
                        children: [
                          RankBadge(rank: widget.rank),
                          SizedBox(width: AppSpacing.medium), // 16dp
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Exercise name
                                Text(
                                  widget.exerciseName,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.extraSmall), // 4dp
                                // Weight display
                                Text(
                                  '${widget.pr.weightPerCableKg.toStringAsFixed(1)} ${widget.weightUnit}/cable',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.extraSmall), // 4dp
                                // Metadata row
                                PRMetadataRow(
                                  reps: widget.pr.reps,
                                  workoutMode: widget.pr.workoutMode,
                                  timestamp: widget.pr.timestamp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right section: Star icon (if rank == 1)
                    if (widget.rank == 1)
                      Icon(
                        Icons.star,
                        size: 32,
                        color: colorScheme.primary,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
