# Phase 5: UI Layer Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans or superpowers:subagent-driven-development to implement this plan task-by-task.

**Goal:** Port complete UI layer from Kotlin Jetpack Compose to Flutter (36 files) matching source app visual design and functionality.

**Architecture:** Material 3 design system with custom theme, GoRouter for navigation, Riverpod ConsumerWidget pattern for state management, reusable widget component library, screen composition from widgets.

**Tech Stack:** Flutter 3.9+, Material 3, GoRouter 14.x, Riverpod 2.6+, fl_chart 0.69+, permission_handler 11.3+

**Source Reference:** `C:\Users\dasbl\AndroidStudioProjects\VitruvianRedux\app\src\main\java\com\vitruvian\phoenix\ui`

**Target Location:** `C:\Users\dasbl\AndroidStudioProjects\VPP_Flutter_Port\lib\presentation`

**Delegation Strategy:** ✅ marks tasks ideal for Cursor Composer delegation. All others require orchestrator oversight for business logic integration.

---

## Sub-Phase 5.1: Foundation (Theme + Navigation) - 6 files

**Goal:** Establish theme system and navigation framework before building widgets/screens.

**Estimated Time:** 4-6 hours

**Dependencies:** None (Phases 1-4 complete)

---

### Task 1: Theme Colors & Typography ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/theme/colors.dart`
- Create: `lib/presentation/theme/typography.dart`
- Create: `lib/presentation/theme/spacing.dart`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/theme/Color.kt`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/theme/Type.kt`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/theme/Spacing.kt`

**Delegation Briefing:**
```markdown
Port Kotlin Jetpack Compose theme files to Flutter Material 3:

1. **colors.dart** - Port Color.kt color scheme definitions
   - 7 predefined color schemes (Blue, Purple, Green, Orange, Red, Teal, Pink)
   - Light/dark mode variants for each
   - Use ColorScheme.fromSeed() or manual ColorScheme() constructor
   - Preserve exact color hex values

2. **typography.dart** - Port Type.kt typography scale
   - Material 3 TextTheme with displayLarge, headlineMedium, bodyLarge, etc.
   - Custom font if used (check Kotlin source)
   - Font weights, sizes, letter spacing

3. **spacing.dart** - Port Spacing.kt spacing constants
   - Standard spacing scale (xs, sm, md, lg, xl, xxl)
   - Convert dp to logical pixels (1:1 for Flutter)

**Output Format:**
- Use const constructors for performance
- Export all from colors.dart, typography.dart, spacing.dart
- Add documentation comments for color scheme names
```

**Step 1: Query Gemini for Kotlin theme source**

Use Gemini CLI to analyze Color.kt, Type.kt, Spacing.kt:

```bash
.skills/gemini.agent.wrapper.sh -d "@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/theme/" "
Analyze the Kotlin theme files: Color.kt, Type.kt, Spacing.kt

Provide:
1. All color scheme definitions with hex values
2. Typography scale (font families, sizes, weights)
3. Spacing constants
4. Light/dark mode differences

Format output for Flutter Material 3 translation."
```

Expected: Complete color palettes, typography specs, spacing values

**Step 2: Delegate to Cursor Composer**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER THEME PORTING TASK:

**Source Files:**
- Color.kt: [paste Gemini output for colors]
- Type.kt: [paste Gemini output for typography]
- Spacing.kt: [paste Gemini output for spacing]

**Target Files:**
- lib/presentation/theme/colors.dart
- lib/presentation/theme/typography.dart
- lib/presentation/theme/spacing.dart

**Requirements:**
- Port all 7 color schemes to Flutter ColorScheme
- Port typography to Material 3 TextTheme
- Port spacing constants as const double values
- Preserve exact hex values and measurements
- Use const constructors
- Add documentation comments

**After Completion:**
1. Run flutter analyze
2. Report file locations and line counts"
```

Expected: 3 theme files created, ~150-250 lines total

**Step 3: Verify theme files**

```bash
flutter analyze lib/presentation/theme/
```

Expected: 0 errors, 0 warnings

**Step 4: Commit theme foundation**

```bash
git add lib/presentation/theme/
git commit -m "feat(ui): add Material 3 theme foundation (colors, typography, spacing)

- Port 7 color schemes from Kotlin (Blue, Purple, Green, Orange, Red, Teal, Pink)
- Port typography scale to Material 3 TextTheme
- Port spacing constants

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 2: Main Theme Composition ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/theme/theme.dart`
- Create: `lib/presentation/providers/theme_provider.dart`
- Test: `test/presentation/providers/theme_provider_test.dart`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/theme/Theme.kt`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/viewmodels/ThemeViewModel.kt`

**Delegation Briefing:**
```markdown
Create Flutter theme composition and provider:

1. **theme.dart** - Main theme factory
   - Function: getAppTheme(ColorScheme colorScheme, Brightness brightness)
   - Returns ThemeData with Material 3 enabled
   - Applies typography, spacing, color scheme
   - Configure component themes (AppBarTheme, CardTheme, etc.)

2. **theme_provider.dart** - Riverpod theme state management
   - StateNotifierProvider<ThemeNotifier, ThemeState>
   - ThemeState: colorScheme index (0-6), brightness (light/dark)
   - Methods: setColorScheme(int index), toggleBrightness()
   - Persist to PreferencesManager

**Pattern:**
```dart
@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default(0) int colorSchemeIndex,
    @Default(Brightness.dark) Brightness brightness,
  }) = _ThemeState;
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  final PreferencesManager _prefs;

  ThemeNotifier(this._prefs) : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> setColorScheme(int index) async { ... }
  Future<void> toggleBrightness() async { ... }
}
```

**Output:**
- theme.dart with getAppTheme() function
- theme_provider.dart with Riverpod provider
- Widget test for theme provider
```

**Step 1: Write failing widget test**

Create `test/presentation/providers/theme_provider_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpp_flutter_port/presentation/providers/theme_provider.dart';
import 'package:vpp_flutter_port/data/preferences/preferences_manager.dart';

void main() {
  group('ThemeProvider', () {
    test('initial state is default theme', () async {
      final container = ProviderContainer();
      final state = container.read(themeProvider);

      expect(state.colorSchemeIndex, 0);
      expect(state.brightness, Brightness.dark);
    });

    test('setColorScheme updates state and persists', () async {
      final container = ProviderContainer();
      final notifier = container.read(themeProvider.notifier);

      await notifier.setColorScheme(3);
      final state = container.read(themeProvider);

      expect(state.colorSchemeIndex, 3);
    });
  });
}
```

**Step 2: Run test to verify it fails**

```bash
flutter test test/presentation/providers/theme_provider_test.dart
```

Expected: FAIL - "Provider themeProvider not found"

**Step 3: Delegate implementation to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER THEME PROVIDER TASK:

[Include delegation briefing from above]

**After Completion:**
1. Run flutter analyze
2. Run flutter test
3. Report results"
```

Expected: theme.dart and theme_provider.dart created, tests passing

**Step 4: Verify tests pass**

```bash
flutter test test/presentation/providers/theme_provider_test.dart
```

Expected: All tests PASS

**Step 5: Commit theme provider**

```bash
git add lib/presentation/theme/theme.dart lib/presentation/providers/theme_provider.dart test/presentation/providers/theme_provider_test.dart
git commit -m "feat(ui): add theme provider with persistence

- ThemeData factory with Material 3
- Riverpod theme state management
- Color scheme selection (7 options)
- Light/dark mode toggle
- Persist preferences

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 3: Navigation Setup ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/navigation/routes.dart`
- Create: `lib/presentation/navigation/app_router.dart`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/navigation/NavGraph.kt`
- Source: `VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/navigation/NavigationRoutes.kt`

**Delegation Briefing:**
```markdown
Port Kotlin Jetpack Navigation to Flutter GoRouter:

1. **routes.dart** - Route path constants
   - All route paths as const String
   - Match Kotlin NavigationRoutes exactly

2. **app_router.dart** - GoRouter configuration
   - GoRouter instance with all routes
   - Initial route: /splash
   - Nested navigation for main app (tabs)
   - Route guards for connection state (TBD)

**Routes to define:**
- /splash - Splash screen
- /home - Main dashboard (TabBarView container)
  - /home/workout - Workout tab
  - /home/routines - Routines tab
  - /home/history - History tab
  - /home/settings - Settings tab
- /active-workout - Active workout screen
- /just-lift - Just Lift mode
- /single-exercise - Single exercise setup
- /routines - Routine management
- /weekly-programs - Weekly program management
- /program-builder - Program creation
- /analytics - Analytics/charts
- /connection-logs - Debug logs
- /exercise-library - Exercise library

**Pattern:**
```dart
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
          GoRoute(path: Routes.homeWorkout, builder: ...),
          // ... other tab routes
        ],
      ),
      // ... other routes
    ],
  );
}
```

**Output:**
- routes.dart with all path constants
- app_router.dart with GoRouter config
- Placeholder screen widgets (empty Scaffold with Text) for all routes
```

**Step 1: Query Gemini for Kotlin navigation structure**

```bash
.skills/gemini.agent.wrapper.sh -d "@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/navigation/" "
Analyze Kotlin navigation files: NavGraph.kt, NavigationRoutes.kt

Provide:
1. All route definitions and paths
2. Navigation hierarchy (nested routes, tabs)
3. Route arguments/parameters
4. Navigation flow patterns

Format for Flutter GoRouter translation."
```

Expected: Complete route list, navigation structure, route parameters

**Step 2: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER NAVIGATION TASK:

**Kotlin Navigation:**
[paste Gemini output]

**Requirements:**
- Create routes.dart with path constants
- Create app_router.dart with GoRouter
- Create placeholder screens (Scaffold + Text) for all routes
- Use ShellRoute for tab navigation
- Set initial route to /splash

**After Completion:**
1. flutter analyze
2. List all created files"
```

Expected: Navigation files + placeholder screens, ~300-400 lines total

**Step 3: Verify navigation**

```bash
flutter analyze lib/presentation/navigation/
```

Expected: 0 errors, possible warnings about unused screens (OK for placeholders)

**Step 4: Commit navigation foundation**

```bash
git add lib/presentation/navigation/ lib/presentation/screens/
git commit -m "feat(ui): add GoRouter navigation with placeholder screens

- Define all route paths
- Configure GoRouter with nested/tab navigation
- Create placeholder Scaffold screens for all routes
- Set splash as initial route

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 4: Update Main App Entry Point

**Files:**
- Modify: `lib/main.dart`
- Create: `lib/presentation/app.dart`

**Step 1: Create app.dart with Material App**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/app_router.dart';
import 'providers/theme_provider.dart';
import 'theme/theme.dart';
import 'theme/colors.dart';

class VPPApp extends ConsumerWidget {
  const VPPApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final colorScheme = AppColors.colorSchemes[themeState.colorSchemeIndex];

    return MaterialApp.router(
      title: 'Vitruvian Project Phoenix',
      theme: getAppTheme(colorScheme, Brightness.light),
      darkTheme: getAppTheme(colorScheme, Brightness.dark),
      themeMode: themeState.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

**Step 2: Update main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VPPApp(),
    ),
  );
}
```

**Step 3: Test app builds and navigates**

```bash
flutter run --debug
```

Expected: App launches, shows splash screen placeholder, can navigate

**Step 4: Commit app integration**

```bash
git add lib/main.dart lib/presentation/app.dart
git commit -m "feat(ui): integrate theme and navigation into main app

- Wire theme provider to MaterialApp
- Configure GoRouter
- Enable hot reload for theme/navigation changes

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Sub-Phase 5.2: Reusable Widget Library - 16 files

**Goal:** Build component library for screen composition.

**Estimated Time:** 8-12 hours

**Dependencies:** Sub-Phase 5.1 complete (theme, navigation)

**Strategy:** Most widgets are UI-heavy with minimal business logic - ideal for Cursor delegation.

---

### Task 5: Common Widgets (Cards, Empty State, Banners) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/cards/stats_card.dart`
- Create: `lib/presentation/widgets/common/empty_state.dart`
- Create: `lib/presentation/widgets/banners/connection_status_banner.dart`
- Create: `test/presentation/widgets/common/empty_state_test.dart`
- Source: `VitruvianRedux/.../StatsCard.kt, EmptyStateComponent.kt, ConnectionStatusBanner.kt`

**Delegation Briefing:**
```markdown
Port 3 common UI components:

1. **StatsCard** - Reusable card for displaying statistics
   - Props: title, value, subtitle, icon, onTap
   - Material 3 Card with elevation
   - Responsive layout

2. **EmptyState** - Empty state placeholder
   - Props: icon, title, message, actionLabel, onAction
   - Centered layout with icon + text + button
   - Use theme colors

3. **ConnectionStatusBanner** - BLE connection status banner
   - Props: connectionState (from Riverpod)
   - Shows connecting/connected/disconnected
   - Color coded (green/yellow/red)
   - Dismissible on connected

**Pattern:**
```dart
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // ... Material 3 styling
      child: InkWell(
        onTap: onTap,
        child: Padding(
          // ... layout
        ),
      ),
    );
  }
}
```

**Widget Test Example:**
```dart
testWidgets('EmptyState shows correct text', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: EmptyState(
          icon: Icons.info,
          title: 'No Data',
          message: 'Nothing to see here',
        ),
      ),
    ),
  );

  expect(find.text('No Data'), findsOneWidget);
  expect(find.text('Nothing to see here'), findsOneWidget);
  expect(find.byIcon(Icons.info), findsOneWidget);
});
```
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER COMMON WIDGETS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze lib/presentation/widgets/
2. flutter test test/presentation/widgets/
3. Report file count and test results"
```

Expected: 3 widget files + 1 test file, tests passing

**Step 2: Verify widgets**

```bash
flutter test test/presentation/widgets/common/
```

Expected: All widget tests PASS

**Step 3: Commit common widgets**

```bash
git add lib/presentation/widgets/cards/ lib/presentation/widgets/common/ lib/presentation/widgets/banners/ test/presentation/widgets/
git commit -m "feat(ui): add common widget components

- StatsCard for metrics display
- EmptyState for placeholder UI
- ConnectionStatusBanner for BLE status
- Widget tests for all components

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 6: Input Widgets (Number Pickers) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/inputs/compact_number_picker.dart`
- Create: `lib/presentation/widgets/inputs/custom_number_picker.dart`
- Create: `test/presentation/widgets/inputs/number_picker_test.dart`
- Source: `VitruvianRedux/.../CompactNumberPicker.kt, CustomNumberPicker.kt`

**Delegation Briefing:**
```markdown
Port 2 number picker widgets for weight/rep selection:

1. **CompactNumberPicker** - Inline number stepper
   - Props: value, min, max, step, unit, onChange
   - Layout: [−] value unit [+]
   - Buttons with haptic feedback

2. **CustomNumberPicker** - Scrollable wheel picker
   - Props: value, min, max, step, unit, itemHeight, visibleItems, onChange
   - Use ListWheelScrollView
   - Snap to values
   - Highlight selected item

**Requirements:**
- Enforce min/max bounds
- Support decimal steps (0.5 kg increments)
- Debounce rapid taps
- Accessibility labels
- Widget tests for increment/decrement/bounds

**Pattern:**
```dart
class CompactNumberPicker extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final String? unit;
  final ValueChanged<double> onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: value > min ? () => onChange(value - step) : null,
        ),
        Text('$value ${unit ?? ''}'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: value < max ? () => onChange(value + step) : null,
        ),
      ],
    );
  }
}
```
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER NUMBER PICKER WIDGETS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. flutter test
3. Report results"
```

Expected: 2 widget files + test file, tests passing

**Step 2: Commit input widgets**

```bash
git add lib/presentation/widgets/inputs/ test/presentation/widgets/inputs/
git commit -m "feat(ui): add number picker input widgets

- CompactNumberPicker for inline selection
- CustomNumberPicker with wheel scroll
- Bounds enforcement and haptic feedback
- Widget tests

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 7: Workout Widgets (Countdown, Rest Timer, Set Summary) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/workout/countdown_card.dart`
- Create: `lib/presentation/widgets/workout/rest_timer_card.dart`
- Create: `lib/presentation/widgets/workout/set_summary_card.dart`
- Create: `test/presentation/widgets/workout/workout_widgets_test.dart`
- Source: `VitruvianRedux/.../CountdownCard.kt, RestTimerCard.kt, SetSummaryCard.kt`

**Delegation Briefing:**
```markdown
Port 3 workout-specific widgets:

1. **CountdownCard** - Pre-workout countdown display (5-4-3-2-1-GO!)
   - Props: secondsRemaining
   - Large animated text
   - Circular progress indicator
   - Pulse animation on GO!

2. **RestTimerCard** - Rest timer between sets
   - Props: secondsRemaining, totalSeconds, onSkip
   - Circular progress with time
   - Skip button
   - Ready/Resting state

3. **SetSummaryCard** - Individual set summary
   - Props: setNumber, reps, concentric (kg), eccentric (kg), power (W), duration
   - Card layout with icons
   - PR badge if applicable

**Requirements:**
- Use Riverpod ConsumerWidget if consuming providers
- Animations: CircularProgressIndicator, ScaleTransition for pulse
- Format time as MM:SS
- Widget tests for rendering and state changes
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER WORKOUT WIDGETS TASK:

[Include delegation briefing]

Source Kotlin files:
- CountdownCard.kt
- RestTimerCard.kt
- SetSummaryCard.kt

**After Completion:**
1. flutter analyze
2. flutter test
3. Report results"
```

Expected: 3 widget files + test file

**Step 2: Commit workout widgets**

```bash
git add lib/presentation/widgets/workout/ test/presentation/widgets/workout/
git commit -m "feat(ui): add workout UI widgets

- CountdownCard for pre-workout countdown
- RestTimerCard for rest periods
- SetSummaryCard for set results display
- Animations and progress indicators

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 8: Effects & Animations (Shimmer, Haptic, PR Celebration) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/effects/shimmer_effect.dart`
- Create: `lib/presentation/widgets/effects/haptic_feedback.dart`
- Create: `lib/presentation/widgets/animations/pr_celebration.dart`
- Source: `VitruvianRedux/.../ShimmerEffect.kt, HapticFeedbackEffect.kt, PRCelebrationAnimation.kt`

**Delegation Briefing:**
```markdown
Port 3 visual effect widgets:

1. **ShimmerEffect** - Loading skeleton shimmer
   - Wrapper widget with shimmer gradient animation
   - Use shimmer package or custom AnimationController
   - Props: child, enabled

2. **HapticFeedback** - Haptic feedback wrapper
   - Stateless utility for triggering haptics
   - Methods: light(), medium(), heavy(), success(), error()
   - Platform: HapticFeedback.vibrate() on Flutter

3. **PRCelebrationAnimation** - Personal record celebration
   - Full-screen overlay with confetti/fireworks
   - Props: onComplete, prData (exercise, oldValue, newValue)
   - Use lottie or particles package
   - Auto-dismiss after 3s

**Requirements:**
- Use flutter_animate or custom animations
- Handle platform differences (haptics iOS/Android only)
- No tests needed (visual effects)
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER EFFECTS/ANIMATIONS TASK:

[Include delegation briefing]

**Additional Packages:**
Consider adding to pubspec.yaml:
- shimmer: ^3.0.0 (for shimmer effect)
- confetti: ^0.7.0 (for PR celebration)

**After Completion:**
1. flutter analyze
2. Report package additions if any"
```

Expected: 3 widget/utility files

**Step 2: Update pubspec.yaml if needed**

If Cursor added packages, run:

```bash
flutter pub get
```

**Step 3: Commit effects**

```bash
git add lib/presentation/widgets/effects/ lib/presentation/widgets/animations/ pubspec.yaml
git commit -m "feat(ui): add visual effects and animations

- ShimmerEffect for loading states
- HapticFeedback utility wrapper
- PRCelebrationAnimation for achievements
- Add shimmer and confetti packages

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 9: Dialogs (Connection, Routine Builder, Exercise) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/dialogs/connection_error_dialog.dart`
- Create: `lib/presentation/widgets/dialogs/connection_lost_dialog.dart`
- Create: `lib/presentation/widgets/dialogs/routine_builder_dialog.dart`
- Create: `lib/presentation/widgets/dialogs/exercise_edit_dialog.dart`
- Create: `lib/presentation/widgets/dialogs/exercise_picker_dialog.dart`
- Source: `VitruvianRedux/.../ConnectionErrorDialog.kt, ConnectionLostDialog.kt, RoutineBuilderDialog.kt, etc.`

**Delegation Briefing:**
```markdown
Port 5 dialog widgets:

1. **ConnectionErrorDialog** - BLE connection failed
   - Props: error message, onRetry, onCancel
   - Material 3 AlertDialog
   - Actions: Retry, Cancel

2. **ConnectionLostDialog** - Connection dropped during workout
   - Props: onReconnect, onEndWorkout
   - Warning style
   - Actions: Reconnect, End Workout

3. **RoutineBuilderDialog** - Create/edit routine
   - Props: routine (null for create), onSave
   - Form: name, exercises (multi-select), sets/reps
   - Use StatefulWidget for form state
   - Save/Cancel buttons

4. **ExerciseEditDialog** - Edit exercise in routine
   - Props: exercise, onSave
   - Form: sets, reps, concentric weight, eccentric load
   - Number pickers for inputs

5. **ExercisePickerDialog** - Select exercise from library
   - Props: exercises list, selectedIds, onConfirm
   - Searchable list with checkboxes
   - Filter/search bar

**Requirements:**
- Use showDialog() to display
- Return values via Navigator.pop(context, value)
- Form validation (non-empty names, positive numbers)
- Material 3 styling
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER DIALOGS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. List created files
3. Report any form validation patterns used"
```

Expected: 5 dialog files, ~600-800 lines total

**Step 2: Commit dialogs**

```bash
git add lib/presentation/widgets/dialogs/
git commit -m "feat(ui): add dialog widgets

- ConnectionErrorDialog for BLE failures
- ConnectionLostDialog for dropped connections
- RoutineBuilderDialog for routine CRUD
- ExerciseEditDialog for exercise configuration
- ExercisePickerDialog for exercise selection
- Form validation and Material 3 styling

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 10: Overlays & Charts ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/overlays/connecting_overlay.dart`
- Create: `lib/presentation/widgets/charts/analytics_charts.dart`
- Source: `VitruvianRedux/.../ConnectingOverlay.kt, AnalyticsCharts.kt`

**Delegation Briefing:**
```markdown
Port 2 overlay/chart widgets:

1. **ConnectingOverlay** - Full-screen BLE connecting overlay
   - Props: isConnecting, deviceName, progress (0.0-1.0)
   - Semi-transparent black background
   - Centered card with CircularProgressIndicator
   - Text: "Connecting to {deviceName}..."
   - Timeout message if >15s

2. **AnalyticsCharts** - Workout analytics charts (fl_chart)
   - Props: workoutHistory (List<WorkoutSession>)
   - 3 chart types:
     a) LineChart: Volume over time (kg × reps)
     b) BarChart: Workout frequency per week
     c) PieChart: Exercise distribution
   - Use fl_chart package
   - Interactive tooltips
   - Theme-aware colors

**Pattern for fl_chart:**
```dart
LineChart(
  LineChartData(
    titlesData: FlTitlesData(...),
    gridData: FlGridData(...),
    lineBarsData: [
      LineChartBarData(
        spots: workoutHistory.map((w) =>
          FlSpot(w.date.millisecondsSinceEpoch.toDouble(), w.totalVolume)
        ).toList(),
        isCurved: true,
        color: theme.colorScheme.primary,
      ),
    ],
  ),
)
```

**Requirements:**
- ConnectingOverlay uses Stack with Positioned.fill
- Charts use fl_chart 0.69+
- Responsive chart sizing
- No tests (visual components)
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER OVERLAYS/CHARTS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Verify fl_chart is in pubspec.yaml (should already be present)"
```

Expected: 2 widget files, analytics_charts.dart ~200-300 lines

**Step 2: Commit overlays and charts**

```bash
git add lib/presentation/widgets/overlays/ lib/presentation/widgets/charts/
git commit -m "feat(ui): add overlay and chart widgets

- ConnectingOverlay for BLE connection progress
- AnalyticsCharts with line/bar/pie charts using fl_chart
- Theme-aware chart styling
- Interactive tooltips

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 11: Settings Widgets (Theme Toggle) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/widgets/settings/theme_toggle.dart`
- Create: `lib/presentation/widgets/settings/color_scheme_picker.dart`
- Source: `VitruvianRedux/.../ThemeToggle.kt`

**Delegation Briefing:**
```markdown
Port settings-related widgets:

1. **ThemeToggle** - Light/dark mode toggle
   - ConsumerWidget using themeProvider
   - Switch or ToggleButtons widget
   - Icons: light_mode, dark_mode
   - Calls themeProvider.toggleBrightness()

2. **ColorSchemePicker** - Color scheme selector
   - ConsumerWidget using themeProvider
   - Grid of 7 color circles
   - Selected indicator (check or border)
   - Calls themeProvider.setColorScheme(index)

**Pattern:**
```dart
class ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    return Switch(
      value: theme.brightness == Brightness.dark,
      onChanged: (_) => notifier.toggleBrightness(),
    );
  }
}
```
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER SETTINGS WIDGETS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Test with hot reload that theme changes work"
```

Expected: 2 widget files

**Step 2: Commit settings widgets**

```bash
git add lib/presentation/widgets/settings/
git commit -m "feat(ui): add settings widgets

- ThemeToggle for light/dark mode
- ColorSchemePicker for theme color selection
- Riverpod integration with theme provider

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Sub-Phase 5.3: Main Screens - 14 files

**Goal:** Implement all primary application screens with business logic integration.

**Estimated Time:** 12-16 hours

**Dependencies:** Sub-Phases 5.1 + 5.2 complete

**Strategy:** These screens require careful orchestration as they integrate Riverpod providers, BLE state, and workout logic. Start with simple screens (splash, settings) before complex ones (active workout).

---

### Task 12: Splash Screen (Simple)

**Files:**
- Create: `lib/presentation/screens/splash_screen.dart`
- Source: `VitruvianRedux/.../LargeSplashScreen.kt`

**Step 1: Implement splash screen**

Replace placeholder with real implementation:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 120,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Vitruvian Project Phoenix',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

**Step 2: Test splash navigation**

```bash
flutter run --debug
```

Expected: Shows splash for 2s, navigates to home

**Step 3: Commit splash screen**

```bash
git add lib/presentation/screens/splash_screen.dart
git commit -m "feat(ui): implement splash screen

- Brand logo and name
- 2-second delay
- Auto-navigate to home screen

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 13: Settings Tab ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/settings_tab.dart`
- Source: `VitruvianRedux/.../HistoryAndSettingsTabs.kt` (settings portion)

**Delegation Briefing:**
```markdown
Port Settings tab screen:

**Layout:**
- AppBar: "Settings"
- ListView with sections:

1. **Appearance Section**
   - ThemeToggle widget (light/dark mode)
   - ColorSchemePicker widget

2. **Workout Preferences Section**
   - Stop at top toggle (PreferencesManager)
   - Autoplay videos toggle
   - Weight unit selector (kg/lb)

3. **Debug Section**
   - Connection logs button → navigate to /connection-logs
   - Clear workout data button (confirmation dialog)

4. **About Section**
   - App version
   - Open source licenses

**Pattern:**
```dart
class SettingsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSection('Appearance', [
            ListTile(
              title: const Text('Theme'),
              trailing: const ThemeToggle(),
            ),
            const ColorSchemePicker(),
          ]),
          _buildSection('Workout', [
            // preference switches using PreferencesManager provider
          ]),
          // ... more sections
        ],
      ),
    );
  }
}
```

**Requirements:**
- Use ConsumerWidget for Riverpod
- PreferencesManager provider for settings persistence
- Confirmation dialog for destructive actions
- Material 3 ListTile styling
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER SETTINGS SCREEN TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Test settings changes persist (hot restart app)"
```

Expected: settings_tab.dart, ~150-200 lines

**Step 2: Commit settings tab**

```bash
git add lib/presentation/screens/settings_tab.dart
git commit -m "feat(ui): implement settings tab screen

- Theme and appearance settings
- Workout preferences (stop at top, autoplay, units)
- Debug tools (connection logs, clear data)
- About section

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 14: Connection Logs Screen ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/connection_logs_screen.dart`
- Source: `VitruvianRedux/.../ConnectionLogsScreen.kt`

**Delegation Briefing:**
```markdown
Port connection logs debug screen:

**Layout:**
- AppBar: "Connection Logs" with clear button
- StreamBuilder listening to ConnectionLogDao.getAllLogsStream()
- ListView.builder with log entries
- Each entry shows:
  - Timestamp (HH:mm:ss.SSS)
  - Event type (icon + text)
  - Log level (color coded: debug/info/warning/error)
  - Message
  - Metadata (expandable)

**Pattern:**
```dart
class ConnectionLogsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmClearLogs(context, ref),
          ),
        ],
      ),
      body: StreamBuilder<List<ConnectionLog>>(
        stream: ref.watch(connectionLogDaoProvider).getAllLogsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final logs = snapshot.data!;
          if (logs.isEmpty) {
            return const EmptyState(
              icon: Icons.info_outline,
              title: 'No Logs',
              message: 'Connection events will appear here',
            );
          }

          return ListView.builder(
            reverse: true, // Newest at top
            itemCount: logs.length,
            itemBuilder: (context, i) => _LogTile(log: logs[i]),
          );
        },
      ),
    );
  }
}
```

**Requirements:**
- Use ConnectionLogDao provider from Riverpod
- Color code log levels (debug: grey, info: blue, warning: orange, error: red)
- Reverse chronological order (newest first)
- Expandable tiles for metadata
- Clear logs with confirmation
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER CONNECTION LOGS SCREEN TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Verify screen renders (may be empty without hardware)"
```

Expected: connection_logs_screen.dart, ~200 lines

**Step 2: Commit logs screen**

```bash
git add lib/presentation/screens/connection_logs_screen.dart
git commit -m "feat(ui): implement connection logs debug screen

- Stream BLE connection events from database
- Color-coded log levels
- Expandable metadata
- Clear logs functionality

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 15: Main Screen (Tab Container) ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/main_screen.dart`
- Source: `VitruvianRedux/.../EnhancedMainScreen.kt`

**Delegation Briefing:**
```markdown
Port main screen tab container:

**Layout:**
- Scaffold with BottomNavigationBar
- 4 tabs: Workout, Routines, History, Settings
- Tab content from nested routes (GoRouter ShellRoute child)
- ConnectionStatusBanner at top (if not connected)
- FloatingActionButton on workout tab (start workout)

**Pattern:**
```dart
class MainScreen extends ConsumerWidget {
  final Widget child; // From GoRouter ShellRoute

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(bleConnectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VPP'),
        actions: [
          // Connection status icon
        ],
      ),
      body: Column(
        children: [
          if (connectionState is! Connected)
            const ConnectionStatusBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Routines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _shouldShowFAB(context)
          ? FloatingActionButton.extended(
              onPressed: () => context.go(Routes.activeWorkout),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
            )
          : null,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains('/workout')) return 0;
    if (location.contains('/routines')) return 1;
    if (location.contains('/history')) return 2;
    if (location.contains('/settings')) return 3;
    return 0;
  }
}
```

**Requirements:**
- Integrate ConnectionStatusBanner widget
- Use GoRouter for tab navigation
- FAB only on workout tab
- BLE connection state from provider
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER MAIN SCREEN TAB CONTAINER TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Test tab navigation works
3. Verify FAB appears on workout tab only"
```

Expected: main_screen.dart, ~150 lines

**Step 2: Commit main screen**

```bash
git add lib/presentation/screens/main_screen.dart
git commit -m "feat(ui): implement main tab navigation screen

- BottomNavigationBar with 4 tabs
- GoRouter integration for nested routes
- ConnectionStatusBanner when not connected
- FAB on workout tab for starting workouts

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 16: Workout Tab & History Tab ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/workout_tab.dart`
- Create: `lib/presentation/screens/history_tab.dart`
- Source: `VitruvianRedux/.../WorkoutTab.kt, HistoryAndSettingsTabs.kt`

**Delegation Briefing:**
```markdown
Port 2 tab screens:

1. **WorkoutTab** - Workout mode selection
   - Quick action cards: Just Lift, Single Exercise, Routine, Program
   - Recent workouts summary (last 3 sessions)
   - Stats cards: Total workouts, Total volume, Last PR
   - Navigate to corresponding screens on tap

2. **HistoryTab** - Workout history list
   - StreamProvider for workout history (workoutHistoryProvider)
   - ListView.builder with workout session cards
   - Each card: date, exercise count, duration, total volume
   - Tap to view details (future: detail screen)
   - Empty state if no history

**Pattern:**
```dart
class WorkoutTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentWorkouts = ref.watch(workoutHistoryProvider).take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Quick Start', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            _QuickActionCard(
              icon: Icons.trending_up,
              title: 'Just Lift',
              onTap: () => context.go(Routes.justLift),
            ),
            // ... more cards
          ],
        ),
        const SizedBox(height: 24),
        Text('Recent Workouts', style: theme.textTheme.headlineSmall),
        // ... recent workout list
      ],
    );
  }
}

class HistoryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutHistoryProvider);

    return workoutsAsync.when(
      data: (workouts) {
        if (workouts.isEmpty) {
          return const EmptyState(
            icon: Icons.history,
            title: 'No Workout History',
            message: 'Complete your first workout to see it here!',
          );
        }

        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i) => WorkoutHistoryCard(
            workout: workouts[i],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

**Requirements:**
- Use workout history provider from Riverpod
- Empty state for no workouts
- Loading/error states
- Material 3 cards with elevation
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER WORKOUT/HISTORY TABS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Test tabs render (may show empty states without data)"
```

Expected: 2 tab files, ~300 lines total

**Step 2: Commit tabs**

```bash
git add lib/presentation/screens/workout_tab.dart lib/presentation/screens/history_tab.dart
git commit -m "feat(ui): implement workout and history tabs

- WorkoutTab with quick actions and recent workouts
- HistoryTab with workout history list
- Riverpod stream integration
- Empty states and loading indicators

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 17: Analytics Screen ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/analytics_screen.dart`
- Source: `VitruvianRedux/.../AnalyticsScreen.kt`

**Delegation Briefing:**
```markdown
Port analytics/charts screen:

**Layout:**
- AppBar: "Analytics"
- TabBarView with 3 tabs: Volume, Frequency, Distribution
- Each tab shows corresponding chart from AnalyticsCharts widget
- Date range selector (Last 7/30/90 days, All time)
- Loading state while fetching workout data

**Pattern:**
```dart
class AnalyticsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _dateRange = 30; // days

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(workoutHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Volume'),
            Tab(text: 'Frequency'),
            Tab(text: 'Distribution'),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _dateRange,
            onSelected: (days) => setState(() => _dateRange = days),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 7, child: Text('Last 7 days')),
              const PopupMenuItem(value: 30, child: Text('Last 30 days')),
              const PopupMenuItem(value: 90, child: Text('Last 90 days')),
              const PopupMenuItem(value: 0, child: Text('All time')),
            ],
          ),
        ],
      ),
      body: workoutsAsync.when(
        data: (workouts) {
          final filtered = _filterByDateRange(workouts, _dateRange);
          return TabBarView(
            controller: _tabController,
            children: [
              AnalyticsCharts.volumeChart(filtered),
              AnalyticsCharts.frequencyChart(filtered),
              AnalyticsCharts.distributionChart(filtered),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => ErrorWidget(err),
      ),
    );
  }
}
```

**Requirements:**
- Use TabBar + TabBarView
- Date range filtering
- AnalyticsCharts widget for rendering
- Empty state if no data in range
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER ANALYTICS SCREEN TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Verify screen builds (charts may be empty without data)"
```

Expected: analytics_screen.dart, ~200 lines

**Step 2: Commit analytics**

```bash
git add lib/presentation/screens/analytics_screen.dart
git commit -m "feat(ui): implement analytics screen

- TabBar with Volume/Frequency/Distribution charts
- Date range filtering (7/30/90 days, all time)
- Integration with AnalyticsCharts widget
- Loading and empty states

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 18: Routines & Programs Screens ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/routines_tab.dart`
- Create: `lib/presentation/screens/daily_routines_screen.dart`
- Create: `lib/presentation/screens/weekly_programs_screen.dart`
- Create: `lib/presentation/screens/program_builder_screen.dart`
- Source: `VitruvianRedux/.../RoutinesTab.kt, DailyRoutinesScreen.kt, WeeklyProgramsScreen.kt, ProgramBuilderScreen.kt`

**Delegation Briefing:**
```markdown
Port 4 routine/program management screens:

1. **RoutinesTab** - Routine list
   - StreamProvider for routines (routineProvider)
   - ListView of routine cards (name, exercise count)
   - FAB: Create new routine → RoutineBuilderDialog
   - Tap routine → DailyRoutinesScreen
   - Long-press: Edit or Delete

2. **DailyRoutinesScreen** - Routine detail/execution
   - Display routine exercises with sets/reps
   - Start button → navigate to /active-workout with routine
   - Edit button → RoutineBuilderDialog

3. **WeeklyProgramsScreen** - Weekly program list
   - StreamProvider for programs (weeklyProgramProvider)
   - ListView of program cards
   - FAB: Create program → ProgramBuilderScreen
   - Tap: View/edit program

4. **ProgramBuilderScreen** - Create/edit weekly program
   - Form: program name, assign routines to days (Mon-Sun)
   - Dropdown per day to select routine (or rest day)
   - Save button: validate and save to repository

**Common Pattern:**
```dart
class RoutinesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routineProvider);

    return Scaffold(
      body: routinesAsync.when(
        data: (routines) => ListView.builder(
          itemCount: routines.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(routines[i].name),
            subtitle: Text('${routines[i].exercises.length} exercises'),
            onTap: () => context.go('/routines/${routines[i].id}'),
            trailing: PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
              onSelected: (action) => _handleAction(action, routines[i], ref),
            ),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => ErrorWidget(err),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRoutineBuilder(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Requirements:**
- Use routine and program providers
- CRUD operations via provider actions
- Dialogs for create/edit
- Confirmation for delete
- Form validation
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER ROUTINES/PROGRAMS SCREENS TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. List created files
3. Test CRUD flows work (create routine, edit, delete)"
```

Expected: 4 screen files, ~800-1000 lines total

**Step 2: Commit routines/programs**

```bash
git add lib/presentation/screens/routines_tab.dart lib/presentation/screens/daily_routines_screen.dart lib/presentation/screens/weekly_programs_screen.dart lib/presentation/screens/program_builder_screen.dart
git commit -m "feat(ui): implement routine and program management screens

- RoutinesTab with routine CRUD
- DailyRoutinesScreen for routine detail
- WeeklyProgramsScreen with program list
- ProgramBuilderScreen for program creation
- Full Riverpod integration

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 19: Active Workout Screen (Complex - Orchestrator Oversight)

**Files:**
- Create: `lib/presentation/screens/active_workout_screen.dart`
- Test: `test/presentation/screens/active_workout_screen_test.dart`
- Source: `VitruvianRedux/.../ActiveWorkoutScreen.kt`

**Overview:** This is the most complex screen - real-time workout display with BLE metrics, rep counting, state machine integration. Requires careful orchestration, not full delegation.

**Step 1: Create screen structure**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_session_provider.dart';
import '../providers/ble_connection_provider.dart';
import '../widgets/workout/countdown_card.dart';
import '../widgets/workout/rest_timer_card.dart';
import '../widgets/workout/set_summary_card.dart';
import '../widgets/dialogs/connection_lost_dialog.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final bleState = ref.watch(bleConnectionProvider);

    // Show connection lost dialog if disconnected during workout
    if (workoutState.connectionLost && bleState is! Connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showConnectionLostDialog(context, ref);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: workoutState.state == WorkoutState.active
                ? () => ref.read(workoutSessionProvider.notifier).pauseWorkout()
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () => _confirmEndWorkout(context, ref),
          ),
        ],
      ),
      body: _buildWorkoutBody(context, ref, workoutState),
    );
  }

  Widget _buildWorkoutBody(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
    return switch (state.state) {
      WorkoutState.countdownToStart => CountdownCard(secondsRemaining: state.autoStartSecondsRemaining ?? 5),
      WorkoutState.active => _buildActiveWorkoutView(context, ref, state),
      WorkoutState.paused => _buildPausedView(context, ref, state),
      WorkoutState.rest => RestTimerCard(
        secondsRemaining: state.restSecondsRemaining ?? 0,
        totalSeconds: 60, // TODO: get from preferences
        onSkip: () => ref.read(workoutSessionProvider.notifier).skipRest(),
      ),
      WorkoutState.completed || WorkoutState.summary => _buildSummaryView(context, ref, state),
      _ => const Center(child: Text('Unknown state')),
    };
  }

  Widget _buildActiveWorkoutView(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current metrics display
          Text('Current Set', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          _MetricsDisplay(metrics: state.currentMetrics),

          const SizedBox(height: 24),

          // Rep counter
          Text('Reps: ${state.repCount ?? 0}', style: theme.textTheme.displayLarge),

          const SizedBox(height: 24),

          // Completed sets
          Text('Completed Sets', style: theme.textTheme.headlineSmall),
          Expanded(
            child: ListView.builder(
              itemCount: state.completedSets.length,
              itemBuilder: (context, i) => SetSummaryCard(
                setNumber: i + 1,
                reps: state.completedSets[i].reps,
                concentric: state.completedSets[i].concentricAvg,
                eccentric: state.completedSets[i].eccentricAvg,
                power: state.completedSets[i].powerPeak,
                duration: state.completedSets[i].duration,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Implement _buildPausedView, _buildSummaryView, _showConnectionLostDialog, _confirmEndWorkout
}

class _MetricsDisplay extends StatelessWidget {
  final WorkoutMetric? metrics;

  const _MetricsDisplay({this.metrics});

  @override
  Widget build(BuildContext context) {
    if (metrics == null) {
      return const Text('Waiting for data...');
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _MetricRow('Concentric', '${metrics!.concentricLoad.toStringAsFixed(1)} kg'),
            _MetricRow('Eccentric', '${metrics!.eccentricLoad.toStringAsFixed(1)} kg'),
            _MetricRow('Power', '${metrics!.power.toStringAsFixed(0)} W'),
            _MetricRow('Velocity', '${metrics!.velocity.toStringAsFixed(2)} m/s'),
          ],
        ),
      ),
    );
  }

  Widget _MetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
```

**Step 2: Query Gemini for Kotlin screen details**

```bash
.skills/gemini.agent.wrapper.sh -d "@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/vitruvian/phoenix/ui/screens/ActiveWorkoutScreen.kt" "
Analyze ActiveWorkoutScreen.kt in detail.

Provide:
1. Complete UI layout structure
2. All state-dependent views (countdown, active, paused, rest, summary)
3. Metrics display format
4. Set summary display
5. User interactions (pause, resume, end, skip rest)
6. Connection lost handling

Format for Flutter implementation."
```

Expected: Detailed breakdown of UI states and layouts

**Step 3: Complete screen implementation**

Add missing methods and refine based on Gemini analysis:

```dart
// Add to ActiveWorkoutScreen class:

Widget _buildPausedView(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.pause_circle_outline, size: 120),
        const SizedBox(height: 24),
        Text('Workout Paused', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 48),
        ElevatedButton.icon(
          onPressed: () => ref.read(workoutSessionProvider.notifier).resumeWorkout(),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Resume'),
        ),
      ],
    ),
  );
}

Widget _buildSummaryView(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Workout Complete!', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 24),
        StatsCard(title: 'Total Sets', value: '${state.completedSets.length}'),
        StatsCard(title: 'Total Reps', value: '${_totalReps(state.completedSets)}'),
        StatsCard(title: 'Duration', value: _formatDuration(state.workoutDuration ?? 0)),
        StatsCard(title: 'Total Volume', value: '${_totalVolume(state.completedSets).toStringAsFixed(0)} kg'),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ref.read(workoutSessionProvider.notifier).completeWorkout();
              context.go(Routes.home);
            },
            child: const Text('Done'),
          ),
        ),
      ],
    ),
  );
}

void _showConnectionLostDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ConnectionLostDialog(
      onReconnect: () {
        Navigator.pop(context);
        ref.read(bleConnectionProvider.notifier).reconnect();
      },
      onEndWorkout: () {
        Navigator.pop(context);
        ref.read(workoutSessionProvider.notifier).endWorkout();
        context.go(Routes.home);
      },
    ),
  );
}

Future<void> _confirmEndWorkout(BuildContext context, WidgetRef ref) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('End Workout?'),
      content: const Text('Are you sure you want to end this workout? Progress will be saved.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('End Workout'),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    ref.read(workoutSessionProvider.notifier).endWorkout();
    context.go(Routes.home);
  }
}

int _totalReps(List<SetData> sets) => sets.fold(0, (sum, set) => sum + set.reps);
double _totalVolume(List<SetData> sets) => sets.fold(0.0, (sum, set) => sum + (set.concentricAvg * set.reps));
String _formatDuration(int seconds) {
  final mins = seconds ~/ 60;
  final secs = seconds % 60;
  return '${mins}m ${secs}s';
}
```

**Step 4: Write widget tests**

Create `test/presentation/screens/active_workout_screen_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpp_flutter_port/presentation/screens/active_workout_screen.dart';

void main() {
  group('ActiveWorkoutScreen', () {
    testWidgets('shows countdown when in countdown state', (tester) async {
      // TODO: Mock workout provider with countdown state
      // Verify CountdownCard is displayed
    });

    testWidgets('shows metrics when in active state', (tester) async {
      // TODO: Mock workout provider with active state
      // Verify metrics display is shown
    });

    testWidgets('shows pause screen when paused', (tester) async {
      // TODO: Mock workout provider with paused state
      // Verify pause UI and resume button
    });
  });
}
```

**Step 5: Test with emulator**

```bash
flutter run --debug
# Navigate to active workout screen
# Verify all states render correctly
```

Expected: Screen renders, state transitions work (may need BLE hardware for full flow)

**Step 6: Commit active workout screen**

```bash
git add lib/presentation/screens/active_workout_screen.dart test/presentation/screens/active_workout_screen_test.dart
git commit -m "feat(ui): implement active workout screen

- Real-time metrics display from BLE
- Rep counting integration
- State machine UI (countdown, active, paused, rest, summary)
- Connection lost handling
- Set summary display
- Workout completion flow

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 20: Just Lift Screen (Complex - Orchestrator Oversight)

**Files:**
- Create: `lib/presentation/screens/just_lift_screen.dart`
- Source: `VitruvianRedux/.../JustLiftScreen.kt`

**Overview:** Similar to ActiveWorkoutScreen but with auto-start/auto-stop based on handle detection.

**Step 1: Create Just Lift screen structure**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_session_provider.dart';
import '../providers/ble_connection_provider.dart';

class JustLiftScreen extends ConsumerWidget {
  const JustLiftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutSessionProvider);
    final bleState = ref.watch(bleConnectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Just Lift'),
        subtitle: const Text('Auto-start when you grab the handles'),
      ),
      body: _buildBody(context, ref, workoutState, bleState),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    WorkoutSessionState workoutState,
    BleConnectionState bleState,
  ) {
    // Just Lift logic:
    // - Shows "Grab handles to start" when idle
    // - Auto-starts countdown when handles grabbed (auto-start timer)
    // - Shows active workout view during reps
    // - Auto-stops after 3s of no movement (auto-stop timer)
    // - Returns to idle instead of summary (Just Lift special behavior)

    if (bleState is! Connected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bluetooth_disabled, size: 80),
            const SizedBox(height: 16),
            const Text('Not connected to Vitruvian device'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(bleConnectionProvider.notifier).connect(),
              child: const Text('Connect'),
            ),
          ],
        ),
      );
    }

    return switch (workoutState.state) {
      WorkoutState.idle => _buildIdleView(context),
      WorkoutState.countdownToStart => _buildCountdownView(workoutState),
      WorkoutState.active => _buildActiveView(context, workoutState),
      WorkoutState.autoStop => _buildAutoStopView(workoutState),
      WorkoutState.justLiftSummary => _buildJustLiftSummary(context, ref, workoutState),
      _ => const Center(child: Text('Unexpected state')),
    };
  }

  Widget _buildIdleView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.back_hand_outlined,
            size: 120,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Grab the handles to start',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Workout will automatically begin when you pick up the handles',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownView(WorkoutSessionState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Get Ready!',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 24),
          Text(
            '${state.autoStartSecondsRemaining ?? 5}',
            style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveView(BuildContext context, WorkoutSessionState state) {
    // Similar to ActiveWorkoutScreen active view
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Current metrics
          if (state.currentMetrics != null) ...[
            Text('Concentric: ${state.currentMetrics!.concentricLoad.toStringAsFixed(1)} kg'),
            Text('Eccentric: ${state.currentMetrics!.eccentricLoad.toStringAsFixed(1)} kg'),
            Text('Power: ${state.currentMetrics!.power.toStringAsFixed(0)} W'),
          ],

          const SizedBox(height: 24),

          // Rep counter
          Text(
            'Reps: ${state.repCount ?? 0}',
            style: Theme.of(context).textTheme.displayLarge,
          ),

          const SizedBox(height: 16),
          Text('Set will auto-complete when you stop moving'),
        ],
      ),
    );
  }

  Widget _buildAutoStopView(WorkoutSessionState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text('Auto-stopping in ${state.autoStopSecondsRemaining ?? 3}s'),
          const Text('Continue moving to cancel'),
        ],
      ),
    );
  }

  Widget _buildJustLiftSummary(BuildContext context, WidgetRef ref, WorkoutSessionState state) {
    // Show set summary, then auto-return to idle after 3s
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          ref.read(workoutSessionProvider.notifier).resetToIdle(); // Just Lift special: reset to idle
        }
      });
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text('Set Complete!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text('Reps: ${state.repCount ?? 0}'),
          if (state.completedSets.isNotEmpty) ...[
            Text('Avg Concentric: ${state.completedSets.last.concentricAvg.toStringAsFixed(1)} kg'),
            Text('Peak Power: ${state.completedSets.last.powerPeak.toStringAsFixed(0)} W'),
          ],
          const SizedBox(height: 24),
          const Text('Returning to idle...'),
        ],
      ),
    );
  }
}
```

**Step 2: Test Just Lift flow**

```bash
flutter run --debug
# Navigate to Just Lift screen
# Verify idle state renders
# (Full flow requires hardware with handle detection)
```

**Step 3: Commit Just Lift screen**

```bash
git add lib/presentation/screens/just_lift_screen.dart
git commit -m "feat(ui): implement Just Lift auto-workout screen

- Auto-start countdown on handle grab
- Auto-stop timer after 3s idle
- Real-time metrics during active lifting
- Set summary with auto-return to idle (Just Lift special)
- Handle detection feedback

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 21: Single Exercise Screen ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/single_exercise_screen.dart`
- Source: `VitruvianRedux/.../SingleExerciseScreen.kt`

**Delegation Briefing:**
```markdown
Port single exercise workout setup screen:

**Layout:**
- AppBar: "Single Exercise Workout"
- Form fields:
  - Exercise picker (ExercisePickerDialog)
  - Sets: number picker (1-10)
  - Reps: number picker (1-50)
  - Concentric weight: custom number picker (kg/lb)
  - Eccentric load: dropdown (50%, 75%, 100%, 125%)
  - Rest time: number picker (30s-5min)
- Start button: Navigate to /active-workout with exercise config

**Pattern:**
```dart
class SingleExerciseScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SingleExerciseScreen> createState() => _SingleExerciseScreenState();
}

class _SingleExerciseScreenState extends ConsumerState<SingleExerciseScreen> {
  Exercise? _selectedExercise;
  int _sets = 3;
  int _reps = 10;
  double _concentricWeight = 20.0;
  EccentricLoad _eccentricLoad = EccentricLoad.oneHundred;
  int _restSeconds = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Exercise')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Exercise'),
            subtitle: Text(_selectedExercise?.name ?? 'Select exercise'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showExercisePicker(),
          ),
          CompactNumberPicker(
            label: 'Sets',
            value: _sets.toDouble(),
            min: 1,
            max: 10,
            step: 1,
            onChange: (v) => setState(() => _sets = v.toInt()),
          ),
          // ... more pickers
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedExercise != null ? _startWorkout : null,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout() {
    ref.read(workoutSessionProvider.notifier).startSingleExercise(
      exercise: _selectedExercise!,
      sets: _sets,
      targetReps: _reps,
      concentricWeight: _concentricWeight,
      eccentricLoad: _eccentricLoad,
      restSeconds: _restSeconds,
    );
    context.go(Routes.activeWorkout);
  }
}
```

**Requirements:**
- Use exercise library provider
- Form validation (exercise selected)
- Weight unit conversion (kg/lb from preferences)
- Number pickers from widgets
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER SINGLE EXERCISE SCREEN TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Test screen renders and form works"
```

Expected: single_exercise_screen.dart, ~200 lines

**Step 2: Commit single exercise screen**

```bash
git add lib/presentation/screens/single_exercise_screen.dart
git commit -m "feat(ui): implement single exercise workout setup screen

- Exercise selection from library
- Sets/reps/weight/eccentric/rest configuration
- Number pickers for all inputs
- Weight unit conversion
- Start workout flow

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Task 22: Home Screen ✅ DELEGATE TO CURSOR

**Files:**
- Create: `lib/presentation/screens/home_screen.dart`
- Source: `VitruvianRedux/.../HomeScreen.kt`

**Delegation Briefing:**
```markdown
Port home dashboard screen:

**Layout:**
- AppBar: "Home"
- Scrollable content:
  1. **Welcome Section**
     - "Welcome back, [User]!" (or generic if no user)
     - Current date/time

  2. **Quick Stats Cards (Row)**
     - StatsCard: Total Workouts (this month)
     - StatsCard: Total Volume (this month)
     - StatsCard: Personal Records (all time)

  3. **Today's Program (if any)**
     - Card showing today's assigned routine from weekly program
     - "Start Routine" button → DailyRoutinesScreen
     - If no program: Empty state "No program today"

  4. **Recent Activity**
     - Last 3 workout sessions (mini cards)
     - "View All" → History Tab

  5. **Quick Actions**
     - Grid of action buttons:
       - Just Lift
       - Single Exercise
       - Browse Routines
       - Weekly Programs

**Pattern:**
```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutHistoryProvider);
    final prsAsync = ref.watch(personalRecordProvider);
    final programsAsync = ref.watch(weeklyProgramProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Welcome back!', style: theme.textTheme.headlineMedium),
          Text(DateFormat.yMMMd().format(DateTime.now())),
          const SizedBox(height: 24),

          // Stats row
          Row(
            children: [
              Expanded(child: StatsCard(title: 'Workouts', value: '${_monthWorkouts(workouts)}')),
              Expanded(child: StatsCard(title: 'Volume', value: '${_monthVolume(workouts)} kg')),
              Expanded(child: StatsCard(title: 'PRs', value: '${prs.length}')),
            ],
          ),

          // Today's program
          _TodaysProgramCard(programs: programs),

          // Recent activity
          _RecentActivitySection(workouts: workouts.take(3).toList()),

          // Quick actions
          _QuickActionsGrid(),
        ],
      ),
    );
  }
}
```

**Requirements:**
- Use multiple providers (workouts, PRs, programs)
- AsyncValue handling for all providers
- Date formatting (intl package)
- Navigation to various screens
```

**Step 1: Delegate to Cursor**

```bash
.skills/cursor.agent.wrapper.sh "FLUTTER HOME SCREEN TASK:

[Include delegation briefing]

**After Completion:**
1. flutter analyze
2. Verify screen renders (may show empty states without data)"
```

Expected: home_screen.dart, ~300 lines

**Step 2: Commit home screen**

```bash
git add lib/presentation/screens/home_screen.dart
git commit -m "feat(ui): implement home dashboard screen

- Welcome section with date
- Quick stats cards (workouts, volume, PRs)
- Today's program display
- Recent activity list
- Quick action grid
- Multi-provider integration

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Final Tasks: Integration & Testing

### Task 23: End-to-End Verification

**Step 1: Run full analysis**

```bash
flutter analyze
```

Expected: 0 errors, minimal warnings (print statements OK)

**Step 2: Run all tests**

```bash
flutter test
```

Expected: All tests pass

**Step 3: Build for all platforms**

```bash
flutter build apk --debug  # Android
flutter build ios --debug --no-codesign  # iOS (macOS only)
flutter build windows --debug  # Windows
flutter build macos --debug  # macOS
flutter build linux --debug  # Linux
```

Expected: All builds succeed

**Step 4: Update PORTING_PROGRESS.md**

Mark all Phase 5 files as ✅ COMPLETE

**Step 5: Update LAST_SESSION.md**

```markdown
## Current State

### Completed - ✅ PHASE 1 + 2 + 3 + 4 + 5

**Phase 5: UI Layer (36 files)** - ✅ COMPLETE
- Theme system (4 files)
- Navigation (2 files)
- Reusable widgets (16 files)
- Main screens (14 files)
- All screens integrated with Riverpod providers
- Widget tests for critical components

**Overall Progress:** 84/84 (100%) ✅ **PROJECT COMPLETE**
```

**Step 6: Final commit**

```bash
git add -A
git commit -m "feat(ui): complete Phase 5 - UI Layer (36 files)

Phase 5 Sub-phases:
- 5.1: Foundation (theme + navigation) - 6 files
- 5.2: Reusable widgets - 16 files
- 5.3: Main screens - 14 files

All screens:
- Material 3 design
- Riverpod state management
- BLE integration
- Widget tests
- Cross-platform support

✅ VPP_Flutter_Port - 100% COMPLETE ✅

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Plan Summary

**Total Tasks:** 23 tasks across 3 sub-phases
**Total Files:** 36 UI files + tests
**Estimated Time:** 24-34 hours
**Delegation Opportunities:** 15 tasks (✅ marked) - ~60% of work

**Critical Path:**
1. Foundation (theme, navigation) - MUST complete first
2. Reusable widgets - Enables screen development
3. Simple screens (splash, settings, logs) - Build confidence
4. Complex screens (active workout, Just Lift) - Require orchestration

**Success Criteria:**
- All 36 UI files ported
- flutter analyze: 0 errors
- flutter test: All tests pass
- flutter build: All platforms build successfully
- App runs and navigates (hardware needed for full BLE testing)

**Next Steps After Plan:**
- Choose execution approach (subagent-driven or parallel session)
- Begin with Task 1 (Theme foundation)
- Use Quadrumvirate delegation for ✅ tasks
- Orchestrator oversight for complex screens

---

**Plan saved:** `docs/plans/2025-11-12-phase-5-ui-layer.md`
