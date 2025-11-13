import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/workout_parameters.dart';
import '../../../domain/models/workout_type.dart';
import '../../../domain/models/program_mode.dart';
import '../../../domain/models/weight_unit.dart';
import '../../providers/workout_session_provider.dart';
import '../../providers/preferences_provider.dart';
import '../../theme/spacing.dart';
import 'exercise_picker_dialog.dart';
import '../inputs/compact_number_picker.dart';

/// Workout setup dialog for configuring workout parameters before starting
///
/// Ported from WorkoutTab.kt WorkoutSetupDialog (lines 632-730)
/// Allows user to configure exercise, mode, weight, reps, and other settings
class WorkoutSetupDialog extends ConsumerStatefulWidget {
  const WorkoutSetupDialog({super.key});

  /// Show the dialog and return true if workout was started
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const WorkoutSetupDialog(),
    );
  }

  @override
  ConsumerState<WorkoutSetupDialog> createState() => _WorkoutSetupDialogState();
}

class _WorkoutSetupDialogState extends ConsumerState<WorkoutSetupDialog> {
  // Local state for dialog
  String? _selectedExerciseId;
  ProgramMode _selectedMode = const ProgramMode.oldSchool();
  double _weightPerCableKg = 20.0;
  int _reps = 10;
  double _progressionRegressionKg = 0.0;
  bool _isProgression = true; // true = progression, false = regression
  bool _isJustLift = false;
  bool _stopAtTop = false;

  @override
  void initState() {
    super.initState();
    // Initialize from current workout parameters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workoutState = ref.read(workoutSessionProvider);
      final params = workoutState.workoutParameters;
      _loadFromParameters(params);
    });
  }

  void _loadFromParameters(WorkoutParameters params) {
    setState(() {
      _selectedExerciseId = params.selectedExerciseId;
      _reps = params.reps;
      _weightPerCableKg = params.weightPerCableKg;
      _progressionRegressionKg = params.progressionRegressionKg.abs();
      _isProgression = params.progressionRegressionKg >= 0;
      _isJustLift = params.isJustLift;
      _stopAtTop = params.stopAtTop;

      // Extract mode from workoutType
      params.workoutType.when(
        program: (mode) => _selectedMode = mode,
        echo: (level, eccentricLoad) {
          // Echo mode - for now default to OldSchool, will be handled in Phase 3
          _selectedMode = const ProgramMode.oldSchool();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weightUnit = ref.watch(weightUnitProvider);
    final prefsActions = ref.read(preferencesActionsProvider);

    // Convert weight to display unit
    final displayWeight = prefsActions.kgToDisplay(_weightPerCableKg, weightUnit);
    final displayProgression = prefsActions.kgToDisplay(
      _progressionRegressionKg,
      weightUnit,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Workout Setup',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SECTION 1: Exercise Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.medium,
                    vertical: AppSpacing.small,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exercise',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.small),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => _selectExercise(context),
                          child: Text(
                            _selectedExerciseId ?? 'Select Exercise',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.small),

              // SECTION 2: Workout Mode Dropdown
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isJustLift
                            ? 'Base Mode (resistance profile)'
                            : 'Workout Mode',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.small),
                      DropdownButtonFormField<ProgramMode>(
                        initialValue: _selectedMode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: ProgramMode.oldSchool(),
                            child: Text('Old School'),
                          ),
                          DropdownMenuItem(
                            value: ProgramMode.pump(),
                            child: Text('Pump'),
                          ),
                          DropdownMenuItem(
                            value: ProgramMode.eccentricOnly(),
                            child: Text('Eccentric Only'),
                          ),
                          // TODO: Phase 3 - Add Echo and TUT modes with sub-selectors
                        ],
                        onChanged: (mode) {
                          if (mode != null) {
                            setState(() => _selectedMode = mode);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.small),

              // SECTION 3: Weight Picker Card
              // Note: Echo mode shows "Adaptive" text instead (handled in Phase 3)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: CompactNumberPicker(
                    label: 'Weight per cable (${weightUnit == WeightUnit.kg ? 'kg' : 'lbs'})',
                    value: displayWeight.toInt(),
                    min: weightUnit == WeightUnit.kg ? 1 : 1,
                    max: weightUnit == WeightUnit.kg ? 100 : 220,
                    suffix: weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
                    onChanged: (value) {
                      setState(() {
                        _weightPerCableKg = prefsActions.displayToKg(
                          value.toDouble(),
                          weightUnit,
                        );
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.small),

              // SECTION 4: Reps Picker Card
              if (!_isJustLift) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    child: CompactNumberPicker(
                      label: 'Target reps',
                      value: _reps,
                      min: 1,
                      max: 50,
                      suffix: '',
                      onChanged: (value) {
                        setState(() => _reps = value);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
              ] else ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target reps',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.small),
                        Text(
                          'N/A',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.extraSmall),
                        Text(
                          'Just Lift doesn\'t use target reps',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
              ],

              // SECTION 5: Progression/Regression (if Program mode, not Just Lift)
              // Note: Only show if not Just Lift and in Program mode
              if (!_isJustLift) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progression/Regression',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.small),
                        Row(
                          children: [
                            FilterChip(
                              label: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.keyboard_arrow_up, size: 18),
                                  SizedBox(width: 4),
                                  Text('Prog'),
                                ],
                              ),
                              selected: _isProgression,
                              onSelected: (selected) {
                                setState(() => _isProgression = true);
                              },
                            ),
                            const SizedBox(width: AppSpacing.small),
                            FilterChip(
                              label: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.keyboard_arrow_down, size: 18),
                                  SizedBox(width: 4),
                                  Text('Regr'),
                                ],
                              ),
                              selected: !_isProgression,
                              onSelected: (selected) {
                                setState(() => _isProgression = false);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.small),
                        CompactNumberPicker(
                          label: 'Amount (${weightUnit == WeightUnit.kg ? 'kg' : 'lbs'})',
                          value: displayProgression.toInt(),
                          min: 0,
                          max: weightUnit == WeightUnit.kg ? 3 : 6,
                          suffix: weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
                          onChanged: (value) {
                            setState(() {
                              _progressionRegressionKg = prefsActions.displayToKg(
                                value.toDouble(),
                                weightUnit,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
              ],

              // SECTION 6: Just Lift Toggle
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Just Lift',
                        style: theme.textTheme.bodyLarge,
                      ),
                      Switch(
                        value: _isJustLift,
                        onChanged: (value) {
                          setState(() {
                            _isJustLift = value;
                            if (value) {
                              _stopAtTop = false; // Disable finish at top when Just Lift is on
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.small),

              // SECTION 7: Finish At Top Toggle
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Finish At Top',
                        style: theme.textTheme.bodyLarge,
                      ),
                      Switch(
                        value: _stopAtTop,
                        onChanged: _isJustLift
                            ? null
                            : (value) {
                                setState(() => _stopAtTop = value);
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _selectedExerciseId == null
              ? null
              : () {
                  _startWorkout();
                  Navigator.of(context).pop(true);
                },
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start Workout'),
        ),
      ],
    );
  }

  Future<void> _selectExercise(BuildContext context) async {
    final selectedIds = await ExercisePickerDialog.show(
      context,
      selectedIds: _selectedExerciseId != null ? {_selectedExerciseId!} : {},
      onConfirm: (ids) {},
    );

    if (selectedIds != null && selectedIds.isNotEmpty) {
      setState(() {
        _selectedExerciseId = selectedIds.first;
      });
    }
  }

  void _startWorkout() {
    final actions = ref.read(workoutSessionActionsProvider);

    // Create workout parameters
    final params = WorkoutParameters(
      workoutType: WorkoutType.program(mode: _selectedMode),
      reps: _isJustLift ? 0 : _reps,
      weightPerCableKg: _weightPerCableKg,
      progressionRegressionKg: _isProgression
          ? _progressionRegressionKg
          : -_progressionRegressionKg,
      isJustLift: _isJustLift,
      useAutoStart: _isJustLift,
      stopAtTop: _stopAtTop,
      selectedExerciseId: _selectedExerciseId,
    );

    // Update parameters and start workout
    actions.updateWorkoutParameters(params);
    actions.startWorkout();
  }
}
