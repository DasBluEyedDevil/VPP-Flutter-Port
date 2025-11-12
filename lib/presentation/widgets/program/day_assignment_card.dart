import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/routine_provider.dart';

/// Day assignment card widget for assigning routines to days of the week
/// 
/// Matches Kotlin DayRoutineCard exactly with:
/// - Day name (100dp width, titleMedium Bold)
/// - Routine dropdown (rest day + all routines)
/// - 2dp elevation, 12dp radius, 16dp padding
class DayAssignmentCard extends ConsumerWidget {
  final int dayOfWeek; // 1=Monday, 7=Sunday
  final String? selectedRoutineId;
  final ValueChanged<String?> onRoutineSelected;

  const DayAssignmentCard({
    super.key,
    required this.dayOfWeek,
    this.selectedRoutineId,
    required this.onRoutineSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routinesProvider);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFF5F3FF), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Day Name
            SizedBox(
              width: 100,
              child: Text(
                _getDayName(dayOfWeek),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Routine Dropdown
            Expanded(
              child: routinesAsync.when(
                data: (routines) => DropdownButtonFormField<String?>(
                  initialValue: selectedRoutineId,
                  decoration: const InputDecoration(
                    labelText: 'Routine',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Rest day'),
                    ),
                    ...routines.map((r) => DropdownMenuItem(
                          value: r.id,
                          child: Text(r.name),
                        )),
                  ],
                  onChanged: onRoutineSelected,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (error, stack) => Text(
                  'Error loading routines: $error',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[dayOfWeek];
  }
}
