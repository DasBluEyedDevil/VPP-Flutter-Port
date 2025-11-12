import 'package:flutter/material.dart';
import '../../../domain/models/routine_exercise.dart';
import '../../../domain/models/program_mode.dart';
import '../../../domain/models/eccentric_load.dart';
import '../../../domain/models/echo_level.dart';
import '../../widgets/inputs/compact_number_picker.dart';

/// Dialog for editing exercise parameters in a routine
/// 
/// Allows editing sets, reps, weight, mode, and Echo-specific settings.
/// Returns the updated RoutineExercise when saved.
class ExerciseEditDialog extends StatefulWidget {
  /// Exercise to edit (null for new exercise)
  final RoutineExercise exercise;
  
  /// Callback when user saves changes
  final ValueChanged<RoutineExercise> onSave;

  const ExerciseEditDialog({
    super.key,
    required this.exercise,
    required this.onSave,
  });

  /// Show the dialog and return the updated exercise
  /// 
  /// Returns the updated RoutineExercise if saved, null if cancelled.
  static Future<RoutineExercise?> show(
    BuildContext context, {
    required RoutineExercise exercise,
    required ValueChanged<RoutineExercise> onSave,
  }) {
    return showDialog<RoutineExercise>(
      context: context,
      builder: (context) => ExerciseEditDialog(
        exercise: exercise,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ExerciseEditDialog> createState() => _ExerciseEditDialogState();
}

class _ExerciseEditDialogState extends State<ExerciseEditDialog> {
  late int _sets;
  late int _reps;
  late double _weightPerCableKg;
  late ProgramMode _mode;
  EccentricLoad? _eccentricLoad;
  EchoLevel? _echoLevel;
  late int _restSeconds;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _sets = widget.exercise.sets;
    _reps = widget.exercise.reps;
    _weightPerCableKg = widget.exercise.weightPerCableKg;
    _mode = widget.exercise.mode;
    _eccentricLoad = widget.exercise.eccentricLoad;
    _echoLevel = widget.exercise.echoLevel;
    _restSeconds = widget.exercise.restSeconds;
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final updated = widget.exercise.copyWith(
        sets: _sets,
        reps: _reps,
        weightPerCableKg: _weightPerCableKg,
        mode: _mode,
        eccentricLoad: _eccentricLoad,
        echoLevel: _echoLevel,
        restSeconds: _restSeconds,
      );
      Navigator.of(context).pop(updated);
      widget.onSave(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEchoMode = _mode == const ProgramMode.eccentricOnly();
    
    return AlertDialog(
      title: const Text('Edit Exercise'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sets
              _buildLabel('Sets'),
              CompactNumberPicker(
                value: _sets.toDouble(),
                min: 1,
                max: 20,
                step: 1,
                onChange: (value) => setState(() => _sets = value.toInt()),
              ),
              const SizedBox(height: 16),
              
              // Reps
              _buildLabel('Reps'),
              CompactNumberPicker(
                value: _reps.toDouble(),
                min: 1,
                max: 100,
                step: 1,
                onChange: (value) => setState(() => _reps = value.toInt()),
              ),
              const SizedBox(height: 16),
              
              // Weight per cable (kg)
              _buildLabel('Weight per Cable (kg)'),
              CompactNumberPicker(
                value: _weightPerCableKg,
                min: 0.0,
                max: 100.0,
                step: 0.5,
                unit: 'kg',
                onChange: (value) => setState(() => _weightPerCableKg = value),
              ),
              const SizedBox(height: 16),
              
              // Program Mode
              _buildLabel('Mode'),
              DropdownButtonFormField<ProgramMode>(
                value: _mode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: const [
                  DropdownMenuItem(value: ProgramMode.oldSchool(), child: Text('Old School')),
                  DropdownMenuItem(value: ProgramMode.pump(), child: Text('Pump')),
                  DropdownMenuItem(value: ProgramMode.tut(), child: Text('TUT')),
                  DropdownMenuItem(value: ProgramMode.tutBeast(), child: Text('TUT Beast')),
                  DropdownMenuItem(value: ProgramMode.eccentricOnly(), child: Text('Eccentric Only')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _mode = value;
                      // Reset Echo settings if switching away from Echo mode
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
              const SizedBox(height: 16),
              
              // Echo Mode Settings (only show if Echo mode selected)
              if (isEchoMode) ...[
                _buildLabel('Eccentric Load'),
                DropdownButtonFormField<EccentricLoad>(
                  value: _eccentricLoad ?? EccentricLoad.load100,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: EccentricLoad.values.map((load) {
                    return DropdownMenuItem(
                      value: load,
                      child: Text(load.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _eccentricLoad = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                
                _buildLabel('Echo Level'),
                DropdownButtonFormField<EchoLevel>(
                  value: _echoLevel ?? EchoLevel.hard,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: EchoLevel.values.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _echoLevel = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
              
              // Rest Seconds
              _buildLabel('Rest Duration (seconds)'),
              CompactNumberPicker(
                value: _restSeconds.toDouble(),
                min: 0,
                max: 600,
                step: 5,
                unit: 's',
                onChange: (value) => setState(() => _restSeconds = value.toInt()),
              ),
            ],
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
