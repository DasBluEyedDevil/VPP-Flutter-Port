import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/exercise_repository.dart';
import '../../providers/connection_log_provider.dart' show appDatabaseProvider;
import '../../theme/spacing.dart';

/// Exercise picker dialog for selecting an exercise from the library.
///
/// Displays a searchable list of exercises. User can select an exercise
/// to use in workout configuration.
class ExercisePickerDialog extends ConsumerStatefulWidget {
  /// Currently selected exercise IDs (for highlighting)
  final Set<String> selectedIds;

  /// Callback when user confirms selection
  final ValueChanged<Set<String>> onConfirm;

  const ExercisePickerDialog({
    super.key,
    required this.selectedIds,
    required this.onConfirm,
  });

  /// Show the dialog and return selected exercise IDs
  static Future<Set<String>?> show(
    BuildContext context, {
    required Set<String> selectedIds,
    required ValueChanged<Set<String>> onConfirm,
  }) {
    return showDialog<Set<String>>(
      context: context,
      builder: (context) => ExercisePickerDialog(
        selectedIds: selectedIds,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  ConsumerState<ExercisePickerDialog> createState() => _ExercisePickerDialogState();
}

class _ExercisePickerDialogState extends ConsumerState<ExercisePickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  Set<String> _selectedIds = {};
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedIds = Set.from(widget.selectedIds);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Watch exercises stream with search filter
    final exercisesAsync = ref.watch(exercisesStreamProvider(_searchQuery));

    return AlertDialog(
      title: const Text('Select Exercise'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            
            // Exercise list
            Expanded(
              child: exercisesAsync.when(
                data: (exercises) {
                  if (exercises.isEmpty) {
                    return Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'No exercises available'
                            : 'No exercises found',
                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: exercises.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.extraSmall),
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      final isSelected = _selectedIds.contains(exercise.id);
                      return _buildExerciseCard(context, theme, exercise, isSelected);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading exercises: $error',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        FilledButton(
          onPressed: _selectedIds.isEmpty
              ? null
              : () {
                  widget.onConfirm(_selectedIds);
                  Navigator.of(context).pop(_selectedIds);
                },
          child: const Text('Select'),
        ),
      ],
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    ThemeData theme,
    Exercise exercise,
    bool isSelected,
  ) {
    return Card(
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedIds.remove(exercise.id);
            } else {
              // Single selection mode - clear previous and select new
              _selectedIds.clear();
              _selectedIds.add(exercise.id);
            }
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              // Exercise info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    if (exercise.muscleGroups != null && exercise.muscleGroups!.isNotEmpty)
                      Text(
                        exercise.muscleGroups!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              
              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Provider for exercise repository
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ExerciseRepositoryImpl(database.exerciseDao);
});

/// Provider for exercises stream with search filter
final exercisesStreamProvider = StreamProvider.family<List<Exercise>, String>((ref, query) {
  final repository = ref.watch(exerciseRepositoryProvider);
  if (query.trim().isEmpty) {
    return repository.getAllExercises();
  } else {
    return repository.searchExercises(query);
  }
});
