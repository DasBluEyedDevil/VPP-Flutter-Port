import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/routes.dart';
import '../providers/weekly_program_provider.dart';
import '../providers/routine_provider.dart';
import '../providers/preferences_provider.dart';
import '../widgets/cards/workout_card.dart';
import '../widgets/cards/home_active_program_card.dart';
import '../../domain/models/routine.dart';
import 'package:go_router/go_router.dart';

/// Home screen matching Kotlin HomeScreen.kt exactly
/// 
/// Displays gradient background, "Start a workout" header,
/// optional Active Program Card, and 4 Workout Cards.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Watch providers
    final programsAsync = ref.watch(weeklyProgramsProvider);
    final routinesAsync = ref.watch(routinesProvider);
    final weightUnit = ref.watch(weightUnitProvider);

    // Get active program (first program for now, TODO: filter by isActive)
    final activeProgram = programsAsync.maybeWhen(
      data: (programs) => programs.isNotEmpty ? programs.first : null,
      orElse: () => null,
    );

    // Get routines list
    final List<Routine> routines = routinesAsync.maybeWhen(
      data: (routines) => routines as List<Routine>,
      orElse: () => <Routine>[],
    );

    // Build gradient background
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
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
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: "Start a workout"
              Text(
                'Start a workout',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 18),
              // Active Program Card (conditional)
              if (activeProgram != null && routines.isNotEmpty)
                HomeActiveProgramCard(
                  program: activeProgram,
                  routines: routines,
                  weightUnit: weightUnit,
                ),
              if (activeProgram != null && routines.isNotEmpty)
                const SizedBox(height: 18),
              // Workout Card 1: Just Lift
              WorkoutCard(
                title: 'Just Lift',
                description: 'Quick setup, start lifting immediately',
                icon: Icons.fitness_center,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF9333EA), // purple-500
                    Color(0xFF7E22CE), // purple-700
                  ],
                ),
                onTap: () => context.go(Routes.justLift),
              ),
              const SizedBox(height: 18),
              // Workout Card 2: Single Exercise
              WorkoutCard(
                title: 'Single Exercise',
                description: 'Perform one exercise with custom configuration',
                icon: Icons.play_arrow,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B5CF6), // violet-500
                    Color(0xFF9333EA), // purple-600
                  ],
                ),
                onTap: () => context.go(Routes.singleExercise),
              ),
              const SizedBox(height: 18),
              // Workout Card 3: Daily Routines
              WorkoutCard(
                title: 'Daily Routines',
                description: 'Choose from your saved multi-exercise routines',
                icon: Icons.calendar_today,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6366F1), // indigo-500
                    Color(0xFF8B5CF6), // violet-600
                  ],
                ),
                onTap: () => context.go(Routes.homeRoutines),
              ),
              const SizedBox(height: 18),
              // Workout Card 4: Weekly Programs
              WorkoutCard(
                title: 'Weekly Programs',
                description: 'Follow a structured weekly training schedule',
                icon: Icons.date_range,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6), // blue-500
                    Color(0xFF6366F1), // indigo-600
                  ],
                ),
                onTap: () => context.go(Routes.weeklyPrograms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
