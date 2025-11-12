import 'package:flutter/material.dart';
import '../../../data/database/app_database.dart';

/// Dialog for selecting exercises from the exercise library
/// 
/// Displays a searchable list of exercises with checkboxes for multi-select.
/// Returns a list of selected exercise IDs when confirmed.
class ExercisePickerDialog extends StatefulWidget {
  /// List of all available exercises
  final List<Exercise> exercises;
  
  /// Currently selected exercise IDs
  final Set<String> selectedIds;
  
  /// Callback when user confirms selection
  final ValueChanged<List<String>> onConfirm;

  const ExercisePickerDialog({
    super.key,
    required this.exercises,
    required this.selectedIds,
    required this.onConfirm,
  });

  /// Show the dialog and return selected exercise IDs
  /// 
  /// Returns list of selected exercise IDs if confirmed, null if cancelled.
  static Future<List<String>?> show(
    BuildContext context, {
    required List<Exercise> exercises,
    required Set<String> selectedIds,
    required ValueChanged<List<String>> onConfirm,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (context) => ExercisePickerDialog(
        exercises: exercises,
        selectedIds: selectedIds,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<ExercisePickerDialog> createState() => _ExercisePickerDialogState();
}

class _ExercisePickerDialogState extends State<ExercisePickerDialog> {
  late Set<String> _selectedIds;
  late List<Exercise> _filteredExercises;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedIds = Set.from(widget.selectedIds);
    _filteredExercises = List.from(widget.exercises);
    _searchController.addListener(_filterExercises);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterExercises() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredExercises = List.from(widget.exercises);
      } else {
        _filteredExercises = widget.exercises.where((exercise) {
          return exercise.name.toLowerCase().contains(query) ||
              (exercise.category?.toLowerCase().contains(query) ?? false) ||
              (exercise.muscleGroups?.toLowerCase().contains(query) ?? false);
        }).toList();
      }
    });
  }

  void _toggleSelection(String exerciseId) {
    setState(() {
      if (_selectedIds.contains(exerciseId)) {
        _selectedIds.remove(exerciseId);
      } else {
        _selectedIds.add(exerciseId);
      }
    });
  }

  void _handleConfirm() {
    final selected = _selectedIds.toList();
    Navigator.of(context).pop(selected);
    widget.onConfirm(selected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Exercises'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Exercise list
            Flexible(
              child: _filteredExercises.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'No exercises found',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredExercises.length,
                      itemBuilder: (context, index) {
                        final exercise = _filteredExercises[index];
                        final isSelected = _selectedIds.contains(exercise.id);
                        
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (_) => _toggleSelection(exercise.id),
                          title: Text(exercise.name),
                          subtitle: exercise.category != null
                              ? Text(
                                  exercise.category!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : null,
                          dense: true,
                        );
                      },
                    ),
            ),
            
            // Selection count
            if (_selectedIds.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${_selectedIds.length} selected',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _selectedIds.isEmpty ? null : _handleConfirm,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
