import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/workout_mode.dart';
import '../../../domain/models/echo_level.dart';

/// Mode selection card widget for Just Lift screen
///
/// Displays 3 FilterChips for workout mode selection: Old School, Pump, Echo
/// with mode-specific descriptions and spring animation on tap.
///
/// Ported from Kotlin JustLiftScreen.kt ModeSelectionCard (lines 599-650)
class ModeSelectionCard extends StatefulWidget {
  /// Currently selected workout mode
  final WorkoutMode selectedMode;

  /// Callback when mode changes
  final ValueChanged<WorkoutMode> onModeChanged;

  const ModeSelectionCard({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  State<ModeSelectionCard> createState() => _ModeSelectionCardState();
}

class _ModeSelectionCardState extends State<ModeSelectionCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
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

  void _handleTap() {
    setState(() => _isPressed = true);
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _isPressed = false);
        _animationController.reverse();
      }
    });
  }

  String _getDescription(WorkoutMode mode) {
    return switch (mode) {
      OldSchool() => 'Constant resistance throughout the movement.',
      Pump() => 'Resistance increases the faster you go.',
      Echo() => 'Adaptive resistance with echo feedback.',
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        elevation: _isPressed ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workout Mode',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),
                Row(
                  children: [
                    Expanded(
                      child: _buildModeChip(
                        context,
                        const WorkoutMode.oldSchool(),
                        'Old School',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Expanded(
                      child: _buildModeChip(
                        context,
                        const WorkoutMode.pump(),
                        'Pump',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Expanded(
                      child: _buildModeChip(
                        context,
                        WorkoutMode.echo(level: EchoLevel.harder),
                        'Echo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  _getDescription(widget.selectedMode),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeChip(
    BuildContext context,
    WorkoutMode mode,
    String label,
  ) {
    final isSelected = _isModeSelected(mode);
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: true,
      onSelected: (selected) {
        if (selected) {
          widget.onModeChanged(_getModeForChip(mode));
        }
      },
      labelStyle: theme.textTheme.bodySmall?.copyWith(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  bool _isModeSelected(WorkoutMode mode) {
    return switch ((widget.selectedMode, mode)) {
      (OldSchool(), OldSchool()) => true,
      (Pump(), Pump()) => true,
      (Echo(), Echo()) => true,
      _ => false,
    };
  }

  WorkoutMode _getModeForChip(WorkoutMode chipMode) {
    // For Echo chip, use current echo level if already Echo, otherwise default
    if (chipMode is Echo && widget.selectedMode is Echo) {
      return widget.selectedMode;
    }
    return chipMode;
  }
}
