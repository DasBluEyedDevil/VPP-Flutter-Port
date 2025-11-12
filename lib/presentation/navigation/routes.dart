/// Route path constants matching Kotlin NavigationRoutes
class Routes {
  Routes._(); // Private constructor to prevent instantiation

  static const String splash = '/';
  static const String home = '/home';
  
  // Tab routes (nested under home)
  static const String homeWorkout = '/home/workout';
  static const String homeRoutines = '/home/routines';
  static const String homeHistory = '/home/history';
  static const String homeSettings = '/home/settings';
  
  static const String justLift = '/just-lift';
  static const String singleExercise = '/single-exercise';
  static const String dailyRoutines = '/daily-routines';
  static const String activeWorkout = '/active-workout';
  static const String weeklyPrograms = '/weekly-programs';
  static const String programBuilder = '/program-builder';
  static const String programBuilderWithId = '/program-builder/:programId';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
  static const String connectionLogs = '/connection-logs';
}
