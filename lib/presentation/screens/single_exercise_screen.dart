import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/preferences_provider.dart';
import '../widgets/inputs/compact_number_picker.dart';
import '../theme/spacing.dart';
import '../../domain/models/eccentric_load.dart';
import '../../domain/models/weight_unit.dart';
import '../../data/database/app_database.dart';

/// Single exercise workout setup screen.
class SingleExerciseScreen extends ConsumerStatefulWidget {
  const SingleExerciseScreen({super.key});

  @override
  ConsumerState<SingleExerciseScreen> createState() => _SingleExerciseScreenState();
}

class _SingleExerciseScreenState extends ConsumerState<SingleExerciseScreen> {
  Exercise? _selectedExercise;
  int _sets = 3;
  int _reps = 10;
  double _concentricWeight = 20.0;
  EccentricLoad _eccentricLoad = EccentricLoad.load100;
  int _restSeconds = 60;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weightUnit = ref.watch(weightUnitProvider);
    final prefsActions = ref.watch(preferencesActionsProvider);

    // Convert weight for display
    final displayWeight = prefsActions.kgToDisplay(_concentricWeight, weightUnit);
    final unitLabel = weightUnit == WeightUnit.kg ? 'kg' : 'lb';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Exercise Workout'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          // Exercise Picker
          Card(
            child: ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Exercise'),
              subtitle: Text(_selectedExercise?.name ?? 'Select exercise'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showExercisePicker(context),
            ),
          ),

          const SizedBox(height: AppSpacing.medium),

          // Sets
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sets',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  CompactNumberPicker(
                    value: _sets.toDouble(),
                    min: 1,
                    max: 10,
                    step: 1,
                    onChange: (value) => setState(() => _sets = value.toInt()),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.medium),

          // Reps
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reps',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  CompactNumberPicker(
                    value: _reps.toDouble(),
                    min: 1,
                    max: 50,
                    step: 1,
                    onChange: (value) => setState(() => _reps = value.toInt()),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.medium),

          // Concentric Weight
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Concentric Weight',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  CompactNumberPicker(
                    value: displayWeight,
                    min: 0.0,
                    max: 100.0,
                    step: 0.5,
                    unit: unitLabel,
                    onChange: (value) {
                      setState(() {
                        _concentricWeight = prefsActions.displayToKg(value, weightUnit);
                      });
                    },
                  ),
                ],
              ),
            ),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rest Time',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  CompactNumberPicker(
                    value: _restSeconds.toDouble(),
                    min: 30,
                    max: 300,
                    step: 15,
                    unit: 's',
                    onChange: (value) => setState(() => _restSeconds = value.toInt()),
                  ),
                ],
              ),
            ),
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
    );
  }

  Future<void> _showExercisePicker(BuildContext context) async {
    // TODO: Get exercises from exercise repository/provider
    // For now, show placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exercise picker coming soon - need exercise provider')),
    );
    
    // Example usage when exercise provider is available:
    // final exercises = ref.read(exerciseProvider);
    // final selected = await ExercisePickerDialog.show(
    //   context,
    //   exercises: exercises,
    //   selectedIds: _selectedExercise != null ? {_selectedExercise!.id} : {},
    //   onConfirm: (ids) {
    //     if (ids.isNotEmpty) {
    //       setState(() {
    //         _selectedExercise = exercises.firstWhere((e) => e.id == ids.first);
    //       });
    //     }
    //   },
    // );
  }

  void _startWorkout() {
    // TODO: Configure workout session with these parameters
    // For now, just navigate to active workout
    // The workout session provider should be configured with these values
    context.go(Routes.activeWorkout);
  }
}

