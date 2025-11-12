import 'package:go_router/go_router.dart';
import 'package:vpp_flutter_port/presentation/navigation/routes.dart';
import 'package:vpp_flutter_port/presentation/screens/active_workout_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/analytics_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/connection_logs_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/daily_routines_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/home_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/just_lift_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/main_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/program_builder_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/settings_tab.dart';
import 'package:vpp_flutter_port/presentation/screens/single_exercise_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/splash_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/weekly_programs_screen.dart';
import 'package:vpp_flutter_port/presentation/screens/workout_tab.dart';
import 'package:vpp_flutter_port/presentation/screens/history_tab.dart';
import 'package:vpp_flutter_port/presentation/screens/routines_tab.dart';

/// App router configuration using GoRouter
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: Routes.homeWorkout,
            builder: (context, state) => const WorkoutTab(),
          ),
          GoRoute(
            path: Routes.homeRoutines,
            builder: (context, state) => const RoutinesTab(),
          ),
          GoRoute(
            path: Routes.homeHistory,
            builder: (context, state) => const HistoryTab(),
          ),
          GoRoute(
            path: Routes.homeSettings,
            builder: (context, state) => const SettingsTab(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.justLift,
        builder: (context, state) => const JustLiftScreen(),
      ),
      GoRoute(
        path: Routes.singleExercise,
        builder: (context, state) => const SingleExerciseScreen(),
      ),
      GoRoute(
        path: Routes.dailyRoutinesWithId,
        builder: (context, state) {
          final routineId = state.pathParameters['routineId'] ?? '';
          return DailyRoutinesScreen(routineId: routineId);
        },
      ),
      GoRoute(
        path: Routes.dailyRoutines,
        builder: (context, state) => const DailyRoutinesScreen(),
      ),
      GoRoute(
        path: Routes.activeWorkout,
        builder: (context, state) => const ActiveWorkoutScreen(),
      ),
      GoRoute(
        path: Routes.weeklyPrograms,
        builder: (context, state) => const WeeklyProgramsScreen(),
      ),
      GoRoute(
        path: Routes.programBuilderWithId,
        builder: (context, state) {
          final programId = state.pathParameters['programId'] ?? 'new';
          return ProgramBuilderScreen(programId: programId);
        },
      ),
      GoRoute(
        path: Routes.analytics,
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsTab(),
      ),
      GoRoute(
        path: Routes.connectionLogs,
        builder: (context, state) => const ConnectionLogsScreen(),
      ),
    ],
  );
}
