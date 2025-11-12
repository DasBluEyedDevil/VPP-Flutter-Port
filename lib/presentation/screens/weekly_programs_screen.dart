import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/weekly_program_provider.dart';
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../data/database/daos/workout_dao.dart';

/// Weekly Programs Screen - displays list of weekly programs with CRUD operations
class WeeklyProgramsScreen extends ConsumerWidget {
  const WeeklyProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsAsync = ref.watch(weeklyProgramsProvider);
    final programActions = ref.watch(weeklyProgramActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Programs'),
      ),
      body: programsAsync.when(
        data: (programs) {
          if (programs.isEmpty) {
            return const EmptyState(
              icon: Icons.calendar_today,
              title: 'No Programs',
              message: 'Create your first weekly program to organize your workouts!',
              actionLabel: 'Create Program',
              onAction: null, // Will be handled by FAB
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.small),
            itemCount: programs.length,
            itemBuilder: (context, index) => _ProgramCard(
              program: programs[index],
              onTap: () {
                // Navigate to program builder for editing
                context.go('${Routes.programBuilder}/${programs[index].program.id}');
              },
              onDelete: () => _confirmDeleteProgram(
                context,
                ref,
                programs[index],
                programActions,
              ),
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
              Text('Error loading programs: $error'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('${Routes.programBuilder}/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Program'),
      ),
    );
  }

  Future<void> _confirmDeleteProgram(
    BuildContext context,
    WidgetRef ref,
    WeeklyProgramWithDays program,
    WeeklyProgramActions actions,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Program?'),
        content: Text(
          'Are you sure you want to delete "${program.program.name}"? This action cannot be undone.',
        ),
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
        await actions.deleteWeeklyProgram(program.program.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Program deleted')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting program: $e')),
          );
        }
      }
    }
  }
}

class _ProgramCard extends StatelessWidget {
  final WeeklyProgramWithDays program;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ProgramCard({
    required this.program,
    required this.onTap,
    required this.onDelete,
  });

  String _getDaysAssigned() {
    if (program.days.isEmpty) {
      return 'No days assigned';
    }

    final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final assignedDays = program.days
        .map((day) => dayNames[day.dayOfWeek])
        .toList()
      ..sort();

    if (assignedDays.length <= 3) {
      return assignedDays.join(', ');
    } else {
      return '${assignedDays.take(3).join(', ')} +${assignedDays.length - 3} more';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.calendar_today,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          program.program.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(_getDaysAssigned()),
            if (program.days.isNotEmpty)
              Text(
                '${program.days.length} day${program.days.length != 1 ? 's' : ''} assigned',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onTap();
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
        isThreeLine: true,
      ),
    );
  }
}
