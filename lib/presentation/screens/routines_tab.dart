import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/routine_provider.dart';
import '../widgets/common/empty_state.dart';
import '../widgets/dialogs/routine_builder_dialog.dart';
import '../theme/spacing.dart';
import '../../data/database/app_database.dart';

/// Routines tab screen displaying list of workout routines.
class RoutinesTab extends ConsumerWidget {
  const RoutinesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routinesProvider);
    final routineActions = ref.watch(routineActionsProvider);

    return Scaffold(
      body: routinesAsync.when(
        data: (routines) {
          if (routines.isEmpty) {
            return const EmptyState(
              icon: Icons.list,
              title: 'No Routines',
              message: 'Create your first routine to get started!',
              actionLabel: 'Create Routine',
              onAction: null, // Will be handled by FAB
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.small),
            itemCount: routines.length,
            itemBuilder: (context, index) => _RoutineCard(
              routine: routines[index],
              onTap: () {
                // TODO: Navigate to routine detail screen
                context.go(Routes.dailyRoutines);
              },
              onEdit: () => _showRoutineBuilder(context, ref, routines[index]),
              onDelete: () => _confirmDeleteRoutine(context, ref, routines[index], routineActions),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: AppSpacing.medium),
              Text('Error loading routines: $error'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRoutineBuilder(context, ref, null),
        icon: const Icon(Icons.add),
        label: const Text('New Routine'),
      ),
    );
  }

  Future<void> _showRoutineBuilder(BuildContext context, WidgetRef ref, Routine? routine) async {
    // TODO: Get exercises from exercise provider/repository
    final exercises = <Exercise>[];

    // TODO: Convert database Routine to domain Routine before passing to dialog
    // The dialog expects domain.Routine, but we have database Routine from provider
    // Need to implement conversion logic or refactor dialog to accept database type
    await RoutineBuilderDialog.show(
      context,
      routine: null, // Placeholder - needs conversion from database Routine
      exercises: exercises,
      onSave: (savedRoutine) {
        // TODO: Save routine via routineActionsProvider
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(routine == null ? 'Routine created' : 'Routine updated'),
            ),
          );
        }
      },
    );
  }

  Future<void> _confirmDeleteRoutine(
    BuildContext context,
    WidgetRef ref,
    Routine routine,
    RoutineActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Routine?'),
        content: Text('Are you sure you want to delete "${routine.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await actions.deleteRoutine(routine.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Routine deleted')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting routine: $e')),
          );
        }
      }
    }
  }
}

class _RoutineCard extends StatelessWidget {
  final Routine routine; // Database Routine type
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _RoutineCard({
    required this.routine,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.list,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          routine.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('${routine.exerciseCount} exercise${routine.exerciseCount != 1 ? 's' : ''}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: AppSpacing.small),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: AppSpacing.small),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
