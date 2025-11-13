import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/routine.dart' as domain;
import '../../../domain/models/routine_exercise.dart' as domain;
import '../../providers/routine_provider.dart';
import '../../theme/spacing.dart';
import '../routines/exercise_list_item.dart';

/// Dialog for creating or editing a workout routine
///
/// Phase 2: Full builder dialog with gradient background, description field, and exercise list
/// - 90% screen height dialog with gradient background
/// - Fields: name* (required), description (optional, 4 lines)
/// - Exercise list with ExerciseListItem widgets
/// - Validation: name.isNotBlank(), exercises.isNotEmpty()
/// - Buttons: Cancel (outlined), Save (filled, 56dp height)
/// - 'Add Exercise' button (STUB - disable for now, Phase 3)
class RoutineBuilderDialog extends ConsumerStatefulWidget {
  /// Routine to edit (null for new routine)
  final domain.Routine? routine;

  /// Map of exerciseId -> exerciseName for display
  final Map<String, String> exerciseNames;

  const RoutineBuilderDialog({
    super.key,
    this.routine,
    required this.exerciseNames,
  });

  /// Show the dialog and return the updated routine
  ///
  /// Returns the updated Routine if saved, null if cancelled.
  static Future<domain.Routine?> show(
    BuildContext context, {
    domain.Routine? routine,
    required Map<String, String> exerciseNames,
  }) {
    return showDialog<domain.Routine>(
      context: context,
      barrierDismissible: false,
      builder: (context) => RoutineBuilderDialog(
        routine: routine,
        exerciseNames: exerciseNames,
      ),
    );
  }

  @override
  ConsumerState<RoutineBuilderDialog> createState() => _RoutineBuilderDialogState();
}

class _RoutineBuilderDialogState extends ConsumerState<RoutineBuilderDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late List<domain.RoutineExercise> _exercises;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.routine?.name ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.routine?.description ?? '',
    );
    _exercises = List.from(widget.routine?.exercises ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleAddExercise() {
    // STUB - Phase 3: Exercise picker dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise picker coming in Phase 3'),
      ),
    );
  }

  void _handleMoveUp(int index) {
    if (index > 0) {
      setState(() {
        final temp = _exercises[index];
        _exercises[index] = _exercises[index - 1];
        _exercises[index - 1] = temp;
        // Update order values
        for (int i = 0; i < _exercises.length; i++) {
          _exercises[i] = _exercises[i].copyWith(order: i);
        }
      });
    }
  }

  void _handleMoveDown(int index) {
    if (index < _exercises.length - 1) {
      setState(() {
        final temp = _exercises[index];
        _exercises[index] = _exercises[index + 1];
        _exercises[index + 1] = temp;
        // Update order values
        for (int i = 0; i < _exercises.length; i++) {
          _exercises[i] = _exercises[i].copyWith(order: i);
        }
      });
    }
  }

  void _handleDelete(int index) {
    setState(() {
      _exercises.removeAt(index);
      // Reorder remaining exercises
      for (int i = 0; i < _exercises.length; i++) {
        _exercises[i] = _exercises[i].copyWith(order: i);
      }
    });
  }

  void _handleEdit(int index) {
    // STUB - Phase 3: Exercise edit bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise editing coming in Phase 3'),
      ),
    );
  }

  void _handleSave() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty || _exercises.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final routine = domain.Routine(
      id: widget.routine?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      createdAt: widget.routine?.createdAt ?? now,
      lastUsed: now,
      exerciseCount: _exercises.length,
      exercises: _exercises,
    );

    Navigator.of(context).pop(routine);
    
    // Save via provider
    final actions = ref.read(routineActionsProvider);
    if (widget.routine != null) {
      actions.updateRoutine(routine);
    } else {
      actions.saveRoutine(routine);
    }
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(16),
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
                    widget.routine == null ? 'Create Routine' : 'Edit Routine',
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
                    // Name field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Routine Name *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText: _showError && _nameController.text.trim().isEmpty
                            ? 'Routine name is required'
                            : null,
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),

                    if (_showError && _nameController.text.trim().isEmpty) ...[
                      const SizedBox(height: AppSpacing.extraSmall),
                      Text(
                        'Routine name is required',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.medium),

                    // Description field
                    SizedBox(
                      height: 100,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.large),

                    // Exercises header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercises${_exercises.isNotEmpty ? ' (${_exercises.length})' : ''}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    if (_showError && _exercises.isEmpty) ...[
                      const SizedBox(height: AppSpacing.extraSmall),
                      Text(
                        'At least one exercise is required',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.small),

                    // Exercise list or empty state
                    if (_exercises.isEmpty)
                      Card(
                        elevation: 4,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFFF5F3FF), // purple-50
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.large),
                          alignment: Alignment.center,
                          child: Text(
                            'No exercises added yet',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    else
                      ...List.generate(_exercises.length, (index) {
                        final exercise = _exercises[index];
                        final exerciseName = widget.exerciseNames[exercise.exerciseId] ?? 
                            'Unknown Exercise';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.small),
                          child: ExerciseListItem(
                            exercise: exercise,
                            exerciseName: exerciseName,
                            index: index,
                            totalCount: _exercises.length,
                            onMoveUp: () => _handleMoveUp(index),
                            onMoveDown: () => _handleMoveDown(index),
                            onEdit: () => _handleEdit(index),
                            onDelete: () => _handleDelete(index),
                          ),
                        );
                      }),

                    const SizedBox(height: AppSpacing.medium),

                    // Add Exercise button (STUB - Phase 3)
                    OutlinedButton.icon(
                      onPressed: _handleAddExercise,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Exercise'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        side: BorderSide(color: theme.colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 48),
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
      ),
    );
  }
}
