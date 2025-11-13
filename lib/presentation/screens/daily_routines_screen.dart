import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/routines/routines_tab.dart';

/// Daily Routines Screen - wrapper screen for viewing and managing workout routines
/// 
/// Phase 1: Core UI only - displays routine list with cards
/// Phase 2: Will add RoutineBuilderDialog and exercise editing
class DailyRoutinesScreen extends ConsumerWidget {
  final String? routineId;

  const DailyRoutinesScreen({
    super.key,
    this.routineId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Routines'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F172A), // slate-900
                    const Color(0xFF1E1B4B), // indigo-950
                    const Color(0xFF172554), // blue-950
                  ]
                : [
                    const Color(0xFFE0E7FF), // indigo-200
                    const Color(0xFFFCE7F3), // pink-100
                    const Color(0xFFDDD6FE), // violet-200
                  ],
          ),
        ),
        child: const RoutinesTab(),
      ),
    );
  }
}
