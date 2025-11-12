import 'package:flutter/material.dart';
import '../../../domain/models/routine.dart' as domain;
import '../../../domain/models/routine_exercise.dart' as domain;
import '../../../domain/models/program_mode.dart';
import '../../../data/database/app_database.dart' as db;
import 'exercise_picker_dialog.dart';
import 'exercise_edit_dialog.dart';

/// Dialog for creating or editing a workout routine
///
/// Allows setting routine name and managing exercises with sets/reps.
/// Returns the updated Routine when saved.
class RoutineBuilderDialog extends StatefulWidget {
  /// Routine to edit (null for new routine)
  final domain.Routine? routine;

  /// List of all available exercises
  final List<db.Exercise> exercises;
  
  /// Callback when user saves changes
  final ValueChanged<domain.Routine> onSave;

  const RoutineBuilderDialog({
    super.key,
    this.routine,
    required this.exercises,
    required this.onSave,
  });

  /// Show the dialog and return the updated routine
  ///
  /// Returns the updated Routine if saved, null if cancelled.
  static Future<domain.Routine?> show(
    BuildContext context, {
    domain.Routine? routine,
    required List<db.Exercise> exercises,
    required ValueChanged<domain.Routine> onSave,
  }) {
    return showDialog<domain.Routine>(
      context: context,
      builder: (context) => RoutineBuilderDialog(
        routine: routine,
        exercises: exercises,
        onSave: onSave,
      ),
    );
  }

  @override
  State<RoutineBuilderDialog> createState() => _RoutineBuilderDialogState();
}

class _RoutineBuilderDialogState extends State<RoutineBuilderDialog> {
  late TextEditingController _nameController;
  late List<domain.RoutineExercise> _exercises;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.routine?.name ?? '',
    );
    _exercises = List.from(widget.routine?.exercises ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _addExercises() async {
    final selectedIds = await ExercisePickerDialog.show(
      context,
      exercises: widget.exercises,
      selectedIds: _exercises.map((e) => e.exerciseId).toSet().cast<String>(),
      onConfirm: (ids) {},
    );

    if (selectedIds != null && selectedIds.isNotEmpty) {
      setState(() {
        // Add new exercises that aren't already in the routine
        final existingIds = _exercises.map((e) => e.exerciseId).toSet();
        int nextOrder = _exercises.length;

        for (final exerciseId in selectedIds) {
          if (!existingIds.contains(exerciseId)) {
            // Find exercise details (not strictly needed, just for validation)
            final exerciseExists = widget.exercises.any((e) => e.id == exerciseId);

            if (exerciseExists) {
              // Create default RoutineExercise
              _exercises.add(
                domain.RoutineExercise(
                  exerciseId: exerciseId,
                  order: nextOrder++,
                  sets: 3,
                  reps: 10,
                  weightPerCableKg: 5.0,
                  mode: const ProgramMode.oldSchool(),
                  restSeconds: 90,
                ),
              );
            }
          }
        }
      });
    }
  }

  Future<void> _editExercise(int index) async {
    final updated = await ExerciseEditDialog.show(
      context,
      exercise: _exercises[index],
      onSave: (_) {},
    );

    if (updated != null) {
      setState(() {
        _exercises[index] = updated;
      });
    }
  }

  void _removeExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
      // Reorder remaining exercises
      for (int i = 0; i < _exercises.length; i++) {
        _exercises[i] = _exercises[i].copyWith(order: i);
      }
    });
  }

  void _moveExercise(int index, int direction) {
    if ((direction < 0 && index == 0) ||
        (direction > 0 && index == _exercises.length - 1)) {
      return;
    }

    setState(() {
      final newIndex = index + direction;
      final temp = _exercises[index];
      _exercises[index] = _exercises[newIndex];
      _exercises[newIndex] = temp;
      
      // Update order values
      for (int i = 0; i < _exercises.length; i++) {
        _exercises[i] = _exercises[i].copyWith(order: i);
      }
    });
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      if (_exercises.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one exercise to the routine'),
          ),
        );
        return;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final routine = domain.Routine(
        id: widget.routine?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        createdAt: widget.routine?.createdAt ?? now,
        lastUsed: now,
        exerciseCount: _exercises.length,
        exercises: _exercises,
      );

      Navigator.of(context).pop(routine);
      widget.onSave(routine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.routine == null ? 'Create Routine' : 'Edit Routine'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Routine Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a routine name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Exercises section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Exercises',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    FilledButton.icon(
                      onPressed: _addExercises,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Exercise list
                if (_exercises.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Text(
                        'No exercises added yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                else
                  ...List.generate(_exercises.length, (index) {
                    final routineExercise = _exercises[index];
                    final exercise = widget.exercises.firstWhere(
                      (e) => e.id == routineExercise.exerciseId,
                      orElse: () => db.Exercise(
                        id: routineExercise.exerciseId,
                        name: 'Unknown Exercise',
                        createdAt: BigInt.zero,
                        lastUsed: BigInt.zero,
                      ),
                    );
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(exercise.name),
                        subtitle: Text(
                          '${routineExercise.sets} sets × ${routineExercise.reps} reps @ ${routineExercise.weightPerCableKg}kg',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_upward, size: 20),
                              onPressed: index > 0
                                  ? () => _moveExercise(index, -1)
                                  : null,
                              tooltip: 'Move up',
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_downward, size: 20),
                              onPressed: index < _exercises.length - 1
                                  ? () => _moveExercise(index, 1)
                                  : null,
                              tooltip: 'Move down',
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () => _editExercise(index),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20),
                              onPressed: () => _removeExercise(index),
                              tooltip: 'Remove',
                            ),
                          ],
                        ),
                        onTap: () => _editExercise(index),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _handleSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
