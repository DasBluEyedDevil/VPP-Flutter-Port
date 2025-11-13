import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/preferences_provider.dart';
import '../providers/workout_session_provider.dart';
import '../widgets/inputs/compact_number_picker.dart';
import '../widgets/dialogs/exercise_picker_dialog.dart';
import '../theme/spacing.dart';
import '../../domain/models/eccentric_load.dart';
import '../../domain/models/weight_unit.dart';
import '../../domain/models/workout_type.dart';
import '../../domain/models/program_mode.dart';
import '../../data/database/app_database.dart';

/// Single exercise workout setup screen.
///
/// Allows user to configure a single exercise workout with:
/// - Exercise selection
/// - Sets and reps configuration
/// - Weight configuration
/// - Eccentric load setting
/// - Rest time between sets
///
/// Ported from Kotlin SingleExerciseScreen.kt
class SingleExerciseScreen extends ConsumerStatefulWidget {
  const SingleExerciseScreen({super.key});

  @override
  ConsumerState<SingleExerciseScreen> createState() => _SingleExerciseScreenState();
}

class _SingleExerciseScreenState extends ConsumerState<SingleExerciseScreen> {
  Exercise? _selectedExercise;
  int _sets = 3;
  int _reps = 10;
  double _concentricWeight = 20.0; // kg
  EccentricLoad _eccentricLoad = EccentricLoad.load100;
  int _restSeconds = 60;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weightUnit = ref.watch(weightUnitProvider);
    final prefsActions = ref.watch(preferencesActionsProvider);
    final isDark = theme.brightness == Brightness.dark;

    // Convert weight for display
    final displayWeight = prefsActions.kgToDisplay(_concentricWeight, weightUnit);
    final unitLabel = weightUnit == WeightUnit.kg ? 'kg' : 'lb';

    // Gradient background colors (matching other screens)
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Single Exercise Workout'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          children: [
            // Exercise Picker
            Card(
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text('Exercise'),
                subtitle: Text(
                  _selectedExercise?.name ?? 'Select exercise',
                  style: TextStyle(
                    color: _selectedExercise != null
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showExercisePicker(context),
              ),
            ),

            const SizedBox(height: AppSpacing.medium),

            // Sets
            CompactNumberPicker(
              label: 'Sets',
              value: _sets,
              min: 1,
              max: 10,
              suffix: '',
              onChanged: (value) => setState(() => _sets = value),
            ),

            const SizedBox(height: AppSpacing.medium),

            // Reps
            CompactNumberPicker(
              label: 'Reps',
              value: _reps,
              min: 1,
              max: 50,
              suffix: '',
              onChanged: (value) => setState(() => _reps = value),
            ),

            const SizedBox(height: AppSpacing.medium),

            // Concentric Weight
            CompactNumberPicker(
              label: 'Concentric Weight',
              value: displayWeight.round(),
              min: 0,
              max: 100,
              suffix: unitLabel,
              onChanged: (value) {
                setState(() {
                  _concentricWeight = prefsActions.displayToKg(value.toDouble(), weightUnit);
                });
              },
            ),

            const SizedBox(height: AppSpacing.medium),

            // Eccentric Load
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eccentric Load',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    SegmentedButton<EccentricLoad>(
                      segments: EccentricLoad.values.map((load) {
                        return ButtonSegment<EccentricLoad>(
                          value: load,
                          label: Text(load.displayName),
                        );
                      }).toList(),
                      selected: {_eccentricLoad},
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

            // Rest Time
            CompactNumberPicker(
              label: 'Rest Time',
              value: _restSeconds,
              min: 30,
              max: 300,
              suffix: 's',
              onChanged: (value) => setState(() => _restSeconds = value),
            ),

            const SizedBox(height: AppSpacing.large),

            // Start Workout Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _selectedExercise != null ? _startWorkout : null,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Workout'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showExercisePicker(BuildContext context) async {
    if (!mounted) return;
    
    final exerciseRepository = ref.read(exerciseRepositoryProvider);
    
    final selected = await ExercisePickerDialog.show(
      context,
      selectedIds: _selectedExercise != null ? {_selectedExercise!.id} : {},
      onConfirm: (ids) async {
        if (!mounted) return;
        if (ids.isNotEmpty) {
          final selectedId = ids.first;
          final exercise = await exerciseRepository.getExerciseById(selectedId);
          if (exercise != null && mounted) {
            setState(() {
              _selectedExercise = exercise;
            });
          }
        }
      },
    );
    
    // Handle selection from dialog return value as well
    if (!mounted) return;
    if (selected != null && selected.isNotEmpty) {
      final selectedId = selected.first;
      final exercise = await exerciseRepository.getExerciseById(selectedId);
      if (exercise != null && mounted) {
        setState(() {
          _selectedExercise = exercise;
        });
      }
    }
  }

  void _startWorkout() {
    if (_selectedExercise == null || !mounted) return;

    final notifier = ref.read(workoutSessionProvider.notifier);
    final currentState = ref.read(workoutSessionProvider);
    final weightUnit = ref.read(weightUnitProvider);

    // Convert display weight to kg if needed
    final weightKg = weightUnit == WeightUnit.kg
        ? _concentricWeight
        : _concentricWeight / 2.20462;

    // Configure workout parameters for single exercise
    // Using OldSchool mode as default (can be extended later)
    final workoutType = WorkoutType.program(mode: const ProgramMode.oldSchool());

    final newParams = currentState.workoutParameters.copyWith(
      workoutType: workoutType,
      reps: _reps,
      weightPerCableKg: weightKg,
      selectedExerciseId: _selectedExercise!.id,
      isJustLift: false,
      useAutoStart: false,
      warmupReps: 0, // No warmup for single exercise mode
    );

    // Update workout session state with new parameters
    notifier.updateWorkoutParameters(newParams);

    // Navigate to active workout screen
    if (mounted) {
      context.go(Routes.activeWorkout);
    }
  }
}

