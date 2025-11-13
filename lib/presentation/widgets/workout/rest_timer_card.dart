import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/weight_unit.dart';

/// Rest timer card displayed during rest periods between sets/exercises.
///
/// Shows countdown timer, next exercise info, and action buttons.
/// Displays during rest periods in autoplay mode.
class RestTimerCard extends StatefulWidget {
  /// Seconds remaining in rest period
  final int secondsRemaining;

  /// Total seconds for rest period
  final int totalSeconds;

  /// Next exercise name
  final String nextExerciseName;

  /// Whether this is the last exercise
  final bool isLastExercise;

  /// Current set number
  final int currentSet;

  /// Total sets
  final int totalSets;

  /// Next exercise weight (optional)
  final double? nextExerciseWeight;

  /// Next exercise target reps (optional)
  final int? nextExerciseReps;

  /// Next exercise mode (optional)
  final String? nextExerciseMode;

  /// Current exercise index (optional, for multi-exercise routines)
  final int? currentExerciseIndex;

  /// Total exercises (optional, for multi-exercise routines)
  final int? totalExercises;

  /// Weight formatting function
  final String Function(double, WeightUnit)? formatWeight;

  /// Callback when skip rest is pressed
  final VoidCallback onSkip;

  /// Callback when end workout is pressed
  final VoidCallback? onEndWorkout;

  const RestTimerCard({
    super.key,
    required this.secondsRemaining,
    required this.totalSeconds,
    required this.nextExerciseName,
    required this.isLastExercise,
    required this.currentSet,
    required this.totalSets,
    this.nextExerciseWeight,
    this.nextExerciseReps,
    this.nextExerciseMode,
    this.currentExerciseIndex,
    this.totalExercises,
    this.formatWeight,
    required this.onSkip,
    this.onEndWorkout,
  });

  @override
  State<RestTimerCard> createState() => _RestTimerCardState();
}

class _RestTimerCardState extends State<RestTimerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.06,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  /// Formats rest time in seconds to MM:SS format
  String _formatRestTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = widget.totalSeconds > 0
        ? (widget.totalSeconds - widget.secondsRemaining) / widget.totalSeconds
        : 0.0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface,
            colorScheme.surface,
            colorScheme.surfaceContainerHighest,
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.small),
          // REST TIME Header
          Text(
            'REST TIME',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          // Countdown timer - large centered text with pulsing animation
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular background with pulse effect
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Circular progress indicator
                SizedBox(
                  width: 220,
                  height: 220,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                  ),
                ),
                // Timer text
                Text(
                  _formatRestTime(widget.secondsRemaining),
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 80,
                    fontWeight: FontWeight.w900,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          // UP NEXT section
          Column(
            children: [
              Text(
                'UP NEXT',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              // Next exercise name or completion message
              Text(
                widget.isLastExercise ? 'Workout Complete' : widget.nextExerciseName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: widget.isLastExercise
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
              ),
              // Set progress indicator
              if (!widget.isLastExercise) ...[
                const SizedBox(height: AppSpacing.small),
                Text(
                  'Set ${widget.currentSet} of ${widget.totalSets}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
          // Workout parameters preview (if available)
          if (!widget.isLastExercise &&
              (widget.nextExerciseWeight != null || widget.nextExerciseReps != null))
            _WorkoutParametersCard(
              nextExerciseWeight: widget.nextExerciseWeight,
              nextExerciseReps: widget.nextExerciseReps,
              nextExerciseMode: widget.nextExerciseMode,
              formatWeight: widget.formatWeight,
            ),
          // Progress through routine (if multi-exercise)
          if (widget.currentExerciseIndex != null &&
              widget.totalExercises != null &&
              widget.totalExercises! > 1)
            _ExerciseProgressIndicator(
              currentIndex: widget.currentExerciseIndex!,
              totalExercises: widget.totalExercises!,
            ),
          const SizedBox(height: AppSpacing.medium),
          // Action buttons
          Column(
            children: [
              // Skip Rest button (primary action)
              FilledButton.icon(
                onPressed: widget.onSkip,
                icon: const Icon(Icons.play_arrow, size: 20),
                label: Text(
                  widget.isLastExercise ? 'Continue' : 'Skip Rest',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              // End Workout button (secondary/destructive action)
              if (widget.onEndWorkout != null)
                TextButton.icon(
                  onPressed: widget.onEndWorkout,
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: colorScheme.error,
                  ),
                  label: Text(
                    'End Workout',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Workout parameters preview card
class _WorkoutParametersCard extends StatelessWidget {
  final double? nextExerciseWeight;
  final int? nextExerciseReps;
  final String? nextExerciseMode;
  final String Function(double, WeightUnit)? formatWeight;

  const _WorkoutParametersCard({
    this.nextExerciseWeight,
    this.nextExerciseReps,
    this.nextExerciseMode,
    this.formatWeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.small),
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'WORKOUT PARAMETERS',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (nextExerciseWeight != null && formatWeight != null)
                _WorkoutParamItem(
                  icon: Icons.settings,
                  label: 'Weight',
                  value: formatWeight!(nextExerciseWeight!, WeightUnit.kg),
                ),
              if (nextExerciseReps != null)
                _WorkoutParamItem(
                  icon: Icons.refresh,
                  label: 'Target Reps',
                  value: nextExerciseReps.toString(),
                ),
              if (nextExerciseMode != null)
                _WorkoutParamItem(
                  icon: Icons.settings,
                  label: 'Mode',
                  value: nextExerciseMode!.length > 8
                      ? nextExerciseMode!.substring(0, 8)
                      : nextExerciseMode!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Individual workout parameter item
class _WorkoutParamItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WorkoutParamItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Exercise progress indicator for multi-exercise routines
class _ExerciseProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalExercises;

  const _ExerciseProgressIndicator({
    required this.currentIndex,
    required this.totalExercises,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = (currentIndex + 1) / totalExercises;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.small),
      child: Column(
        children: [
          Text(
            'Exercise ${currentIndex + 1} of $totalExercises',
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
