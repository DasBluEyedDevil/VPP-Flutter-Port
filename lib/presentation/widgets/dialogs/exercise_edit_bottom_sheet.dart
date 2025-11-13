import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/routine_exercise.dart';
import '../../../domain/models/program_mode.dart';
import '../../../domain/models/eccentric_load.dart';
import '../../../domain/models/echo_level.dart';
import '../../../domain/models/weight_unit.dart';
import '../../providers/preferences_provider.dart';
import '../../theme/spacing.dart';
import '../inputs/compact_number_picker.dart';

/// Bottom sheet for editing exercise configuration in routines
///
/// Phase 3: Full exercise configuration with all parameters
/// - 90% screen height modal bottom sheet with gradient background
/// - Configuration fields: sets, reps, weight, rest time, mode, etc.
/// - Handles weight unit conversion (kg/lb)
/// - Supports Program modes and Echo mode configuration
class ExerciseEditBottomSheet extends ConsumerStatefulWidget {
  /// Exercise to edit (null for new exercise)
  final RoutineExercise? exercise;

  /// Exercise ID (required for new exercise)
  final String? exerciseId;

  /// Order within routine (required for new exercise)
  final int? order;

  /// Callback when exercise is saved
  final ValueChanged<RoutineExercise> onSave;

  /// Callback when bottom sheet is dismissed
  final VoidCallback? onDismiss;

  const ExerciseEditBottomSheet({
    super.key,
    this.exercise,
    this.exerciseId,
    this.order,
    required this.onSave,
    this.onDismiss,
  });

  /// Show the bottom sheet and return updated exercise
  ///
  /// Returns the updated RoutineExercise if saved, null if cancelled.
  static Future<RoutineExercise?> show(
    BuildContext context, {
    RoutineExercise? exercise,
    String? exerciseId,
    int? order,
    required ValueChanged<RoutineExercise> onSave,
    VoidCallback? onDismiss,
  }) {
    return showModalBottomSheet<RoutineExercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExerciseEditBottomSheet(
        exercise: exercise,
        exerciseId: exerciseId,
        order: order,
        onSave: onSave,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  ConsumerState<ExerciseEditBottomSheet> createState() => _ExerciseEditBottomSheetState();
}

class _ExerciseEditBottomSheetState extends ConsumerState<ExerciseEditBottomSheet> {
  late int _sets;
  late int _reps;
  late double _weightPerCableKg;
  late int _restSeconds;
  late ProgramMode _mode;
  EccentricLoad? _eccentricLoad;
  EchoLevel? _echoLevel;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    if (widget.exercise != null) {
      // Editing existing exercise
      _sets = widget.exercise!.sets;
      _reps = widget.exercise!.reps;
      _weightPerCableKg = widget.exercise!.weightPerCableKg;
      _restSeconds = widget.exercise!.restSeconds;
      _mode = widget.exercise!.mode;
      _eccentricLoad = widget.exercise!.eccentricLoad;
      _echoLevel = widget.exercise!.echoLevel;
    } else {
      // New exercise - defaults
      _sets = 3;
      _reps = 10;
      _weightPerCableKg = 20.0; // kg
      _restSeconds = 60;
      _mode = const ProgramMode.oldSchool();
      _eccentricLoad = null;
      _echoLevel = null;
    }
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (widget.exercise == null && (widget.exerciseId == null || widget.order == null)) {
      // Cannot create without exerciseId and order
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exercise ID and order are required')),
      );
      return;
    }

    final exercise = RoutineExercise(
      exerciseId: widget.exercise?.exerciseId ?? widget.exerciseId!,
      order: widget.exercise?.order ?? widget.order!,
      sets: _sets,
      reps: _reps,
      weightPerCableKg: _weightPerCableKg,
      mode: _mode,
      eccentricLoad: _eccentricLoad,
      echoLevel: _echoLevel,
      restSeconds: _restSeconds,
    );

    widget.onSave(exercise);
    Navigator.of(context).pop(exercise);
  }

  void _handleCancel() {
    widget.onDismiss?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final weightUnit = ref.watch(weightUnitProvider);
    final preferencesActions = ref.watch(preferencesActionsProvider);

    // Convert weight for display
    final displayWeight = preferencesActions.kgToDisplay(_weightPerCableKg, weightUnit);
    final unitLabel = weightUnit == WeightUnit.kg ? 'kg' : 'lb';

    // Gradient background colors
    final gradientColors = isDark
        ? [
            const Color(0xFF0F172A), // slate-900
            const Color(0xFF1E1B4B), // indigo-950
            const Color(0xFF172554), // blue-950
          ]
        : [
            const Color(0xFFE0E7FF), // indigo-200
            const Color(0xFFFCE7F3), // pink-100
            const Color(0xFFDDD6FE), // violet-200
          ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exercise == null ? 'Add Exercise' : 'Edit Exercise',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _handleCancel,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sets
                  CompactNumberPicker(
                    label: 'Number of Sets',
                    value: _sets,
                    min: 1,
                    max: 10,
                    suffix: '',
                    onChanged: (value) => setState(() => _sets = value),
                  ),

                  const SizedBox(height: AppSpacing.medium),

                  // Reps
                  CompactNumberPicker(
                    label: 'Reps per Set',
                    value: _reps,
                    min: 1,
                    max: 50,
                    suffix: '',
                    onChanged: (value) => setState(() => _reps = value),
                  ),

                  const SizedBox(height: AppSpacing.medium),

                  // Weight per Cable
                  CompactNumberPicker(
                    label: 'Weight per Cable',
                    value: displayWeight.round(),
                    min: 0,
                    max: 100,
                    suffix: unitLabel,
                    onChanged: (value) {
                      setState(() {
                        _weightPerCableKg = preferencesActions.displayToKg(
                          value.toDouble(),
                          weightUnit,
                        );
                      });
                    },
                  ),

                  const SizedBox(height: AppSpacing.medium),

                  // Rest Time
                  CompactNumberPicker(
                    label: 'Rest Time',
                    value: _restSeconds,
                    min: 30,
                    max: 300,
                    suffix: 's',
                    onChanged: (value) => setState(() => _restSeconds = value),
                  ),

                  const SizedBox(height: AppSpacing.medium),

                  // Program Mode
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Workout Type',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.small),
                          DropdownButtonFormField<ProgramMode>(
                            initialValue: _mode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem<ProgramMode>(
                                value: ProgramMode.oldSchool(),
                                child: Text('Old School'),
                              ),
                              DropdownMenuItem<ProgramMode>(
                                value: ProgramMode.pump(),
                                child: Text('Pump'),
                              ),
                              DropdownMenuItem<ProgramMode>(
                                value: ProgramMode.tut(),
                                child: Text('TUT'),
                              ),
                              DropdownMenuItem<ProgramMode>(
                                value: ProgramMode.tutBeast(),
                                child: Text('TUT Beast'),
                              ),
                              DropdownMenuItem<ProgramMode>(
                                value: ProgramMode.eccentricOnly(),
                                child: Text('Eccentric Only'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _mode = value;
                                  // Reset Echo-specific fields when changing mode
                                  if (value != const ProgramMode.eccentricOnly()) {
                                    _eccentricLoad = null;
                                    _echoLevel = null;
                                  } else {
                                    // Set defaults for Echo mode
                                    _eccentricLoad ??= EccentricLoad.load100;
                                    _echoLevel ??= EchoLevel.hard;
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Eccentric Load (only for EccentricOnly mode)
                  if (_mode == const ProgramMode.eccentricOnly()) ...[
                    const SizedBox(height: AppSpacing.medium),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.medium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eccentric Load',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.small),
                            SegmentedButton<EccentricLoad>(
                              segments: EccentricLoad.values.map((load) {
                                return ButtonSegment<EccentricLoad>(
                                  value: load,
                                  label: Text(load.displayName),
                                );
                              }).toList(),
                              selected: {_eccentricLoad ?? EccentricLoad.load100},
                              onSelectionChanged: (Set<EccentricLoad> selected) {
                                setState(() {
                                  _eccentricLoad = selected.first;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.medium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Echo Level',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.small),
                            DropdownButtonFormField<EchoLevel>(
                              initialValue: _echoLevel ?? EchoLevel.hard,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: EchoLevel.values.map((level) {
                                return DropdownMenuItem<EchoLevel>(
                                  value: level,
                                  child: Text(level.displayName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _echoLevel = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Notes (optional)
                  const SizedBox(height: AppSpacing.medium),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes (optional)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.small),
                          TextField(
                            controller: _notesController,
                            decoration: InputDecoration(
                              hintText: 'Add notes about this exercise...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignLabelWithHint: true,
                            ),
                            maxLines: 3,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.large),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(AppSpacing.medium),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // Cancel button
                Expanded(
                  child: OutlinedButton(
                    onPressed: _handleCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                      side: BorderSide(color: theme.colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),

                const SizedBox(width: AppSpacing.medium),

                // Save button
                Expanded(
                  child: FilledButton(
                    onPressed: _handleSave,
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      'Save',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
