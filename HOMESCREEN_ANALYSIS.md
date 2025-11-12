# HomeScreen Implementation Analysis - Extreme Detail

**Source File**: `C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/example/vitruvianredux/presentation/screen/HomeScreen.kt`

**Last Updated**: 2025-11-12

---

## Executive Summary

The HomeScreen is the main landing screen when users open the app. It serves as a hub for accessing four main workout modes (Just Lift, Single Exercise, Daily Routines, Weekly Programs) plus an optional Active Program widget that displays today's scheduled routine. The design uses a modern gradient background with card-based navigation elements and smooth press animations.

---

## 1. LAYOUT HIERARCHY & STRUCTURE

### Root Container: Box
```
Box(fillMaxSize, background: verticalGradient)
├── Column(fillMaxSize, padding: 20dp, spacing: 18dp)
│   ├── Header Text: "Start a workout"
│   ├── HomeActiveProgramCard (conditional - if activeProgram exists)
│   ├── WorkoutCard: "Just Lift"
│   ├── WorkoutCard: "Single Exercise"
│   ├── WorkoutCard: "Daily Routines"
│   └── WorkoutCard: "Weekly Programs"
│
└── Overlay Dialogs (conditional)
    ├── ConnectingOverlay (if isAutoConnecting)
    └── ConnectionErrorDialog (if connectionError exists)
```

### Key Structure Characteristics
- **Root Box**: Uses `Modifier.fillMaxSize()` with gradient background that spans entire screen
- **Main Column**:
  - Width: `fillMaxWidth()` (inherits from Box)
  - Height: `fillMaxSize()` (inherits from Box)
  - Padding: `20.dp` (uniform all sides)
  - Vertical spacing between items: `18.dp`
  - Children arranged vertically with `Arrangement.spacedBy(18.dp)`

---

## 2. BACKGROUND & THEMING

### Gradient Background
Two distinct gradients based on theme mode:

#### Dark Theme Gradient
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFF0F172A),  // slate-900 (dark navy)
        Color(0xFF1E1B4B),  // indigo-950 (deep indigo)
        Color(0xFF172554)   // blue-950 (dark blue)
    )
)
```
- Direction: Top to bottom
- Creates a deep, dark atmosphere suitable for night usage
- Transitions from slate → indigo → blue

#### Light Theme Gradient
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFFE0E7FF),  // indigo-200 (soft lavender)
        Color(0xFFFCE7F3),  // pink-100 (soft pink)
        Color(0xFFDDD6FE)   // violet-200 (soft violet)
    )
)
```
- Direction: Top to bottom
- Creates a soft, pastel atmosphere
- Transitions from lavender → pink → violet

### Theme Mode Selection Logic
```kotlin
val useDarkColors = when (themeMode) {
    ThemeMode.SYSTEM -> isSystemInDarkTheme()  // Uses device setting
    ThemeMode.LIGHT -> false
    ThemeMode.DARK -> true
}
```

---

## 3. UI ELEMENTS - COMPLETE BREAKDOWN

### 3.1 Header Section

#### Element: Screen Title
```kotlin
Text(
    "Start a workout",
    style = MaterialTheme.typography.headlineSmall,
    fontWeight = FontWeight.Bold,
    color = MaterialTheme.colorScheme.onSurface
)
```

**Specifications**:
- **Text Content**: "Start a workout"
- **Typography**: `headlineSmall` (Material 3 standard)
  - Font Size: `24.sp`
  - Font Weight: Bold (900)
  - Line Height: `32.sp`
  - Letter Spacing: `0.sp`
  - Font Family: Roboto (Android system default)
- **Color**: `onSurface` (theme-aware, adapts to light/dark)
  - Dark theme: `TextPrimary` (#FFFFFF)
  - Light theme: `ColorOnLightSurface` (#111827 - dark gray)
- **Font Weight Override**: `FontWeight.Bold` (explicit Bold application)
- **Position**: First item in Column after root title
- **Spacing Below**: `18.dp` (Column spacing)

---

### 3.2 Active Program Card (Conditional)

#### Container Structure
```kotlin
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
    shape = RoundedCornerShape(16.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
)
```

**Card Properties**:
- **Shape**: `RoundedCornerShape(16.dp)` (16dp border radius)
- **Background Color**: `surface` (theme-aware)
  - Dark: `SurfaceDarkGrey` (#1E1E1E)
  - Light: `ColorLightSurface` (#FFFFFF)
- **Border**: 1dp, Color(0xFFF5F3FF) - purple-50 (subtle lavender border)
- **Elevation**: 4dp (default state)
- **Width**: `fillMaxWidth()`
- **Display**: Only shown when `activeProgram != null`

#### Internal Column
```kotlin
Column(
    modifier = Modifier.fillMaxWidth().padding(Spacing.medium),
    // Contains exercises list and start button
)
```
- **Padding**: `Spacing.medium` = `16.dp` (all sides)
- **Fill Width**: Yes
- **Spacing Between Items**: Implicit via explicit Spacer components

#### Exercise Item Display Format
Each exercise in the routine displays:
```
"${Exercise Name} | ${Reps} | ${Weight} | ${Mode}"

Example:
"Chest Press | 10, 10, 12 | 45.0 lbs | Concentric"
```

**Display Logic**:
- **Exercise Name**: Direct from `exercise.exercise.name`
- **Reps**: Joined from `exercise.setReps` with ", " separator
  - Example: "10, 10, 12" for 3 sets
- **Weight**: Intelligently formatted
  - If `setWeightsPerCableKg` is uniform: single value "%.1f {unit}"
  - If varied: range format "%.1f-%.1f {unit}"
  - Suffix: "lbs" for pounds, "kg" for kilograms
  - Example uniform: "45.0 lbs"
  - Example varied: "40.5-50.0 lbs"
- **Mode**: `exercise.workoutType.displayName` (e.g., "Concentric", "Eccentric")

**Spacing Between Exercises**:
- Each exercise followed by `Spacer(modifier = Modifier.height(Spacing.extraSmall))`
- `Spacing.extraSmall` = `4.dp`

#### Start Routine Button
```kotlin
Button(
    onClick = { onStartRoutine(todayRoutineId) },
    modifier = Modifier.fillMaxWidth(),
    enabled = todayRoutine != null,
    colors = ButtonDefaults.buttonColors(
        containerColor = MaterialTheme.colorScheme.primary
    )
)
```

**Button Properties**:
- **Width**: `fillMaxWidth()`
- **Enabled State**: Only enabled when full routine details are loaded (`todayRoutine != null`)
- **Background Color**: `primary` (theme-aware)
  - Dark: `PrimaryPurple` (#BB86FC)
  - Light: `TertiaryPurple` (#E0BBF7)
- **Height**: Material default (~48-56dp)
- **Content**: Icon + Spacer(8dp) + Text("Start Routine")
- **Icon**: `Icons.Default.PlayArrow` (play triangle icon)
- **Text**: "Start Routine"

**On Click Action**:
```kotlin
viewModel.ensureConnection(
    onConnected = {
        viewModel.loadRoutineById(routineId)
        viewModel.startWorkout()
        navController.navigate(NavigationRoutes.DailyRoutines.route)
    },
    onFailed = { /* Error shown via StateFlow */ }
)
```

#### Rest Day Display (No Workout Today)
If `hasWorkoutToday` is false:
```kotlin
Text(
    text = "Rest day",
    style = MaterialTheme.typography.bodyMedium,
    color = MaterialTheme.colorScheme.onSurfaceVariant
)
```
- **Text**: "Rest day"
- **Typography**: `bodyMedium` (14sp, Normal weight)
- **Color**: `onSurfaceVariant` (theme-aware secondary text)

#### Active Program Card Positioning Logic
```kotlin
// Conditionally renders only if activeProgram != null
activeProgram?.let { program ->
    HomeActiveProgramCard(
        program = program,
        routines = routines,
        weightUnit = weightUnit,
        formatWeight = viewModel::formatWeight,
        kgToDisplay = viewModel::kgToDisplay,
        onStartRoutine = { routineId ->
            // Navigation logic above
        }
    )
}
```

---

### 3.3 Workout Selection Cards

All four workout cards follow the same reusable `WorkoutCard` composable with different parameters.

#### WorkoutCard Composable

##### Container: Card with Press Animation
```kotlin
Card(
    onClick = { isPressed = true; onClick() },
    modifier = Modifier.fillMaxWidth().scale(scale),
    shape = RoundedCornerShape(16.dp),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
    elevation = CardDefaults.cardElevation(
        defaultElevation = if (isPressed) 2.dp else 4.dp
    ),
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
)
```

**Card Properties**:
- **Shape**: `RoundedCornerShape(16.dp)` (rounded corners)
- **Background**: `surface` (theme-aware)
- **Border**: 1dp solid Color(0xFFF5F3FF) - purple-50
- **Width**: `fillMaxWidth()`
- **Elevation**:
  - Default: 4dp
  - Pressed: 2dp (reduces on press for tactile feedback)
- **Click Handler**: Sets `isPressed = true` and triggers `onClick()`

##### Press Animation State
```kotlin
var isPressed by remember { mutableStateOf(false) }
val scale by animateFloatAsState(
    targetValue = if (isPressed) 0.97f else 1f,
    animationSpec = spring(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = 400f
    ),
    label = "scale"
)
```

**Animation Details**:
- **Target Scale**: 0.97f when pressed (3% shrink), 1f normal
- **Animation Type**: Spring (bouncy)
- **Damping Ratio**: `DampingRatioMediumBouncy` (creates subtle bounce effect)
- **Stiffness**: 400f (medium responsiveness)
- **Duration**: Auto-calculated by spring (typically 200-300ms)
- **After Press**: Resets `isPressed = false` after 100ms delay via `LaunchedEffect`

##### Internal Row Layout
```kotlin
Row(
    modifier = Modifier.fillMaxWidth().padding(16.dp),
    horizontalArrangement = Arrangement.spacedBy(16.dp),
    verticalAlignment = Alignment.CenterVertically
)
```

**Row Properties**:
- **Width**: `fillMaxWidth()` (fills card interior)
- **Padding**: `16.dp` (uniform all sides)
- **Horizontal Spacing**: `16.dp` between children
- **Vertical Alignment**: `CenterVertically` (items vertically centered)

#### 3.3.1 Icon Container Box

```kotlin
Box(
    modifier = Modifier
        .size(64.dp)
        .shadow(4.dp, RoundedCornerShape(12.dp))
        .background(gradient, RoundedCornerShape(12.dp)),
    contentAlignment = Alignment.Center
)
```

**Container Specifications**:
- **Size**: 64x64 dp (square)
- **Shape**: `RoundedCornerShape(12.dp)` (12dp corner radius)
- **Shadow**: 4dp elevation shadow
- **Background**: Gradient (unique per card, see below)
- **Content Alignment**: Center (icon centered within box)

**Icon Inside Box**:
```kotlin
Icon(
    imageVector = icon,
    contentDescription = "Select $title workout",
    tint = MaterialTheme.colorScheme.onPrimary,
    modifier = Modifier.size(32.dp)
)
```
- **Size**: 32x32 dp
- **Tint Color**: `onPrimary` (contrast against gradient)
  - Dark: `BackgroundBlack` (#000000)
  - Light: `ColorOnLightBackground` (#0F172A)
- **Content Description**: "Select [Title] workout"

#### 3.3.2 Content Column (Title + Description)

```kotlin
Column(
    modifier = Modifier.weight(1f),
    verticalArrangement = Arrangement.spacedBy(4.dp)
)
```

**Column Properties**:
- **Width**: `weight(1f)` (takes remaining horizontal space after icon)
- **Vertical Spacing**: 4dp between title and description

##### Title Text
```kotlin
Text(
    text = title,
    style = MaterialTheme.typography.titleMedium,
    fontWeight = FontWeight.Bold,
    color = MaterialTheme.colorScheme.onSurface
)
```

**Typography**:
- **Size**: 16sp (`titleMedium`)
- **Line Height**: 24sp
- **Font Weight**: Medium → Bold (override with Bold)
- **Letter Spacing**: 0.15sp
- **Color**: `onSurface` (theme-aware primary text)

##### Description Text
```kotlin
Text(
    text = description,
    style = MaterialTheme.typography.bodySmall,
    color = MaterialTheme.colorScheme.onSurfaceVariant
)
```

**Typography**:
- **Size**: 12sp (`bodySmall`)
- **Line Height**: 16sp
- **Font Weight**: Normal
- **Letter Spacing**: 0.4sp
- **Color**: `onSurfaceVariant` (theme-aware secondary text)

#### 3.3.3 Arrow Navigation Icon

```kotlin
Surface(
    shape = RoundedCornerShape(50),
    color = Color(0xFFF5F3FF),
    modifier = Modifier.size(36.dp)
)
```

**Container**:
- **Size**: 36x36 dp (square, makes circle with radius 18)
- **Shape**: `RoundedCornerShape(50)` (creates perfect circle)
- **Background**: Color(0xFFF5F3FF) - purple-50 (light lavender)

**Icon Inside**:
```kotlin
Icon(
    imageVector = Icons.AutoMirrored.Filled.ArrowForward,
    contentDescription = "Navigate",
    tint = Color(0xFF9333EA),
    modifier = Modifier.size(16.dp)
)
```
- **Icon**: `ArrowForward` (right-facing arrow, auto-mirrors in RTL)
- **Size**: 16x16 dp
- **Tint**: Color(0xFF9333EA) - purple-500
- **Content Description**: "Navigate"

---

## 4. WORKOUT CARD VARIANTS

All four cards use identical structure with unique colors and destinations.

### 4.1 Just Lift Card

**Parameters**:
- **Title**: "Just Lift"
- **Description**: "Quick setup, start lifting immediately"
- **Icon**: `Icons.Default.FitnessCenter` (dumbbell icon)
- **Gradient**:
  ```kotlin
  Brush.linearGradient(
      colors = listOf(
          Color(0xFF9333EA),  // purple-500
          Color(0xFF7E22CE)   // purple-700
      )
  )
  ```
- **Destination**: `NavigationRoutes.JustLift.route` = "just_lift"
- **Icon Tint**: `onPrimary` (white/dark for contrast)

### 4.2 Single Exercise Card

**Parameters**:
- **Title**: "Single Exercise"
- **Description**: "Perform one exercise with custom configuration"
- **Icon**: `Icons.Default.PlayArrow` (play/triangle icon)
- **Gradient**:
  ```kotlin
  Brush.linearGradient(
      colors = listOf(
          Color(0xFF8B5CF6),  // violet-500
          Color(0xFF9333EA)   // purple-600
      )
  )
  ```
- **Destination**: `NavigationRoutes.SingleExercise.route` = "single_exercise"

### 4.3 Daily Routines Card

**Parameters**:
- **Title**: "Daily Routines"
- **Description**: "Choose from your saved multi-exercise routines"
- **Icon**: `Icons.Default.CalendarToday` (calendar icon)
- **Gradient**:
  ```kotlin
  Brush.linearGradient(
      colors = listOf(
          Color(0xFF6366F1),  // indigo-500
          Color(0xFF8B5CF6)   // violet-600
      )
  )
  ```
- **Destination**: `NavigationRoutes.DailyRoutines.route` = "daily_routines"

### 4.4 Weekly Programs Card

**Parameters**:
- **Title**: "Weekly Programs"
- **Description**: "Follow a structured weekly training schedule"
- **Icon**: `Icons.Default.DateRange` (date range icon)
- **Gradient**:
  ```kotlin
  Brush.linearGradient(
      colors = listOf(
          Color(0xFF3B82F6),  // blue-500
          Color(0xFF6366F1)   // indigo-600
      )
  )
  ```
- **Destination**: `NavigationRoutes.WeeklyPrograms.route` = "weekly_programs"

---

## 5. OVERLAY DIALOGS

### 5.1 Connecting Overlay

**Condition**: `if (isAutoConnecting)`

```kotlin
if (isAutoConnecting) {
    com.example.vitruvianredux.presentation.components.ConnectingOverlay(
        onCancel = { viewModel.cancelAutoConnecting() }
    )
}
```

**Behavior**:
- Full-screen overlay appears when app attempts automatic BLE connection
- Shows connecting state UI (typically spinner or animation)
- Provides cancel button to abort connection attempt
- Calls `viewModel.cancelAutoConnecting()` on cancel

### 5.2 Connection Error Dialog

**Condition**: `if (connectionError != null)`

```kotlin
connectionError?.let { error ->
    com.example.vitruvianredux.presentation.components.ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

**Behavior**:
- Shows error dialog when BLE connection fails
- Displays error message from `viewModel.connectionError` StateFlow
- Dialog dismissible via `viewModel.clearConnectionError()`
- Allows user to retry or proceed without device connection

---

## 6. STATE MANAGEMENT & DATA SOURCES

### 6.1 Collected StateFlows

```kotlin
// Stats
val workoutStreak by viewModel.workoutStreak.collectAsState()
val completedWorkouts by viewModel.completedWorkouts.collectAsState()
val progressPercentage by viewModel.progressPercentage.collectAsState()

// Connection
val connectionState by viewModel.connectionState.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()

// Programs
val activeProgram by viewModel.activeProgram.collectAsState()
val routines by viewModel.routines.collectAsState()
val weightUnit by viewModel.weightUnit.collectAsState()
```

### 6.2 Derived State

```kotlin
val hasStats = workoutStreak != null ||
               completedWorkouts != null ||
               progressPercentage != null
```

### 6.3 ViewModel Calculations

#### Workout Streak Calculation
```kotlin
val workoutStreak: StateFlow<Int?> = allWorkoutSessions.map { sessions ->
    if (sessions.isEmpty()) return@map null

    val workoutDates = sessions
        .map { Instant.ofEpochMilli(it.timestamp)
            .atZone(ZoneId.systemDefault())
            .toLocalDate() }
        .distinct()
        .sortedDescending()

    val today = LocalDate.now()
    val lastWorkoutDate = workoutDates.first()

    // Streak only valid if workout was today or yesterday
    if (lastWorkoutDate.isBefore(today.minusDays(1))) return@map null

    var streak = 1
    for (i in 1 until workoutDates.size) {
        if (workoutDates[i] == workoutDates[i-1].minusDays(1)) {
            streak++
        } else {
            break
        }
    }
    streak
}
```

**Key Points**:
- Returns `null` if no workouts exist
- Returns `null` if last workout > 1 day ago (streak broken)
- Counts consecutive days going backwards from most recent workout
- Stops counting on first gap

#### Completed Workouts Count
```kotlin
val completedWorkouts: StateFlow<Int?> = allWorkoutSessions.map { sessions ->
    sessions.size.takeIf { it > 0 }
}
```
- Simple count of total workout sessions
- Returns `null` if zero workouts

#### Progress Percentage
```kotlin
val progressPercentage: StateFlow<Int?> = allWorkoutSessions.map { sessions ->
    if (sessions.size < 2) return@map null

    val latestSession = sessions[0]
    val previousSession = sessions[1]

    // Volume = (Total Weight * 2 cables) * Total Reps
    val latestVolume = (latestSession.weightPerCableKg * 2) * latestSession.totalReps
    val previousVolume = (previousSession.weightPerCableKg * 2) * previousSession.totalReps

    if (previousVolume <= 0f) return@map null

    val percentageChange = ((latestVolume - previousVolume) / previousVolume) * 100
    percentageChange.toInt()
}
```

**Key Points**:
- Requires at least 2 sessions
- Calculates volume change between most recent and previous workout
- Volume formula accounts for **2 cables** (Vitruvian machine characteristic)
- Returns percentage change as integer
- Returns `null` if insufficient data

### 6.4 Weight Unit Formatting

#### kgToDisplay Function
```kotlin
fun kgToDisplay(kg: Float, unit: WeightUnit): Float =
    if (unit == WeightUnit.LB) kg * 2.20462f else kg
```
- Converts internal KG storage to display unit
- LB conversion: multiply by 2.20462
- KG: no conversion (returns as-is)

#### formatWeight Function
```kotlin
fun formatWeight(kg: Float, unit: WeightUnit): String {
    val displayValue = kgToDisplay(kg, unit)
    return "%.1f %s".format(displayValue, unit.name.lowercase())
}
```
- Returns: "45.0 kg" or "99.2 lbs"
- Format: 1 decimal place
- Unit suffix: lowercase unit name

---

## 7. NAVIGATION FLOW

### Active Program Start Flow

```
User clicks "Start Routine" on Active Program Card
                    ↓
viewModel.ensureConnection() called
                    ↓
        ┌─────────────────────┐
        │ Connection Status?  │
        └─────────────────────┘
           ↓ Connected    ↓ Not Connected
        Success         Auto-connect
                        Dialog shown
           ↓             (can cancel)
   Load routine by ID       ↓
   Call startWorkout()   Connection
   Navigate to          Success
   DailyRoutines         ↓
                        (same as left side)
```

### Workout Card Navigation

```
User clicks any Workout Card
                    ↓
onClick() triggered
                    ↓
Card animates (scale 0.97f)
                    ↓
navController.navigate(route) called
                    ↓
Navigate to:
- Just Lift → "just_lift"
- Single Exercise → "single_exercise"
- Daily Routines → "daily_routines"
- Weekly Programs → "weekly_programs"
```

---

## 8. COLORS & THEME MAPPING

### Color Palette

#### Background (Gradient)
| Theme | Top | Middle | Bottom |
|-------|-----|--------|--------|
| Dark | #0F172A (slate-900) | #1E1B4B (indigo-950) | #172554 (blue-950) |
| Light | #E0E7FF (indigo-200) | #FCE7F3 (pink-100) | #DDD6FE (violet-200) |

#### Card Components
| Element | Dark Mode | Light Mode | Hex |
|---------|-----------|-----------|-----|
| Card Background | SurfaceDarkGrey | ColorLightSurface | #1E1E1E / #FFFFFF |
| Card Border | Purple-50 | Purple-50 | #F5F3FF |
| Text (Primary) | TextPrimary | ColorOnLightSurface | #FFFFFF / #111827 |
| Text (Secondary) | TextSecondary | ColorOnLightSurfaceVariant | #E0E0E0 / #6B7280 |
| Arrow Icon BG | Purple-50 | Purple-50 | #F5F3FF |
| Arrow Icon Color | Purple-500 | Purple-500 | #9333EA |

#### Icon Container Gradients
| Card | Start | End | Colors |
|------|-------|-----|--------|
| Just Lift | #9333EA | #7E22CE | purple-500 to purple-700 |
| Single Exercise | #8B5CF6 | #9333EA | violet-500 to purple-600 |
| Daily Routines | #6366F1 | #8B5CF6 | indigo-500 to violet-600 |
| Weekly Programs | #3B82F6 | #6366F1 | blue-500 to indigo-600 |

#### Primary Colors (Button)
| Theme | Color | Hex |
|-------|-------|-----|
| Dark | PrimaryPurple | #BB86FC |
| Light | TertiaryPurple | #E0BBF7 |

---

## 9. TYPOGRAPHY SPECIFICATIONS

### Screen Title ("Start a workout")
- **Font Family**: Roboto (System Default)
- **Font Size**: 24sp
- **Font Weight**: Bold (900)
- **Line Height**: 32sp
- **Letter Spacing**: 0sp
- **Applied Style**: `headlineSmall` with `FontWeight.Bold` override

### Workout Card Title (e.g., "Just Lift")
- **Font Family**: Roboto
- **Font Size**: 16sp
- **Font Weight**: Medium (→ Bold override)
- **Line Height**: 24sp
- **Letter Spacing**: 0.15sp
- **Applied Style**: `titleMedium` with `FontWeight.Bold`

### Workout Card Description
- **Font Family**: Roboto
- **Font Size**: 12sp
- **Font Weight**: Normal
- **Line Height**: 16sp
- **Letter Spacing**: 0.4sp
- **Applied Style**: `bodySmall`

### Exercise List Items (Active Program)
- **Font Family**: Roboto
- **Font Size**: 14sp
- **Font Weight**: Normal
- **Line Height**: 20sp
- **Letter Spacing**: 0.25sp
- **Applied Style**: `bodyMedium`

### Start Routine Button Text
- **Font Family**: Roboto
- **Font Size**: 14sp (from Material default button)
- **Font Weight**: Medium
- **Applied Style**: `labelLarge` (Material default)

### Rest Day Text
- **Font Family**: Roboto
- **Font Size**: 14sp
- **Font Weight**: Normal
- **Line Height**: 20sp
- **Letter Spacing**: 0.25sp
- **Applied Style**: `bodyMedium`

---

## 10. SPACING & DIMENSIONS

### Spacing Tokens (8dp Grid System)
```kotlin
object Spacing {
    val extraSmall = 4.dp    // Tight spacing
    val small = 8.dp         // Standard small gap
    val medium = 16.dp       // Standard medium gap
    val large = 24.dp        // Large gap
    val extraLarge = 32.dp   // Extra large gap
    val huge = 48.dp         // Maximum gap
}
```

### Layout Dimensions
| Component | Dimension | Value |
|-----------|-----------|-------|
| Screen Padding | Top/Bottom/Left/Right | 20dp |
| Column Item Spacing | Vertical gap | 18dp |
| Workout Card Height | Auto (content height) | ~120-140dp |
| Workout Card Corner Radius | Border radius | 16dp |
| Icon Container | Width × Height | 64dp × 64dp |
| Icon Container Corner Radius | Border radius | 12dp |
| Icon Size (inside box) | Width × Height | 32dp × 32dp |
| Arrow Circle | Width × Height | 36dp × 36dp |
| Arrow Icon | Width × Height | 16dp × 16dp |
| Card Interior Padding (Row) | All sides | 16dp |
| Row Item Spacing | Horizontal gap | 16dp |
| Content Column Spacing | Vertical gap | 4dp |
| Active Program Card Corner Radius | Border radius | 16dp |
| Active Program Card Padding | All sides | 16dp |
| Exercise Item Spacing | Vertical gap below each | 4dp |
| Button Height | Auto (Material default) | ~48-56dp |
| Button Width | Horizontal | fillMaxWidth |

### Elevation (Shadow) Values
| Component | Elevation |
|-----------|-----------|
| Workout Card (default) | 4dp |
| Workout Card (pressed) | 2dp |
| Icon Container (shadow) | 4dp |
| Active Program Card | 4dp |

---

## 11. INTERACTIVE BEHAVIORS

### 11.1 Workout Card Press Animation

**Timeline**:
1. User touches/clicks card
2. `isPressed` state changes to `true`
3. `scale` animation starts: 1f → 0.97f
4. Elevation changes: 4dp → 2dp
5. Spring animation plays (~200-300ms)
6. `LaunchedEffect` waits 100ms
7. `isPressed` resets to `false`
8. `scale` animates back: 0.97f → 1f
9. Elevation restores: 2dp → 4dp

**Visual Effect**: Subtle "squeeze" and "bounce" feedback

### 11.2 Active Program Card Conditional Rendering

**Condition**: `activeProgram?.let { ... }`
- Card only renders if `activeProgram` is not null
- Uses Kotlin scope function for safe null handling
- Complete card hidden if no active program exists

### 11.3 Start Routine Button Logic

**Enable Condition**: `todayRoutine != null`
- Button disabled (grayed out) until routine data fully loads
- Prevents premature start attempt

**On Click Sequence**:
```
1. viewModel.ensureConnection() called
   - If already connected: proceed to step 3
   - If not connected: show ConnectingOverlay

2. Connection established (or user has device connected)
   - ConnectingOverlay dismisses
   - Proceeds to step 3

3. Load routine: viewModel.loadRoutineById(routineId)
4. Start workout: viewModel.startWorkout()
5. Navigate: navController.navigate("daily_routines")
```

### 11.4 Error Handling

**Connection Error Display**:
```
If connectionError StateFlow has value:
- ConnectionErrorDialog overlays screen
- Shows error message
- User can dismiss or retry
- On dismiss: viewModel.clearConnectionError()
```

**AutoConnecting State**:
```
If isAutoConnecting is true:
- ConnectingOverlay displays
- Shows connecting animation
- Provides cancel button
- On cancel: viewModel.cancelAutoConnecting()
```

---

## 12. RESPONSIVE BEHAVIOR

### Screen Size Adaptation
- **Card Width**: Always `fillMaxWidth()` - expands/contracts with screen
- **Column Padding**: Fixed 20dp - intentional margin on all screen sizes
- **Scrolling**: No explicit scroll in HomeScreen
  - Content must fit within single screen
  - Typically 4 workout cards + optional active program + title
  - May need scroll if screen very small or fonts enlarged

### Orientation Independence
- **Portrait**: Primary design orientation
- **Landscape**: Column arrangement scales horizontally
  - Cards become wider
  - Layout remains vertical
  - No special landscape handling in code

---

## 13. ACCESSIBILITY FEATURES

### Content Descriptions
- All icons have `contentDescription` parameters
- Examples:
  - Icon buttons: "Select Just Lift workout"
  - Arrow: "Navigate"
  - Play icon: `null` (inside button with text)

### Color Contrast
- Text on surface: sufficient contrast in both themes
- Icons on gradient: white/dark text on colored backgrounds
- Error/success states: use semantic colors

### Keyboard Navigation
- All interactive elements are focusable
- Card click triggers `onClick` handler
- Button is keyboard accessible
- Tab order follows document order

### Text Sizing
- Typography uses Material 3 standard scales
- Users can adjust system font size
- App respects user preferences (no hardcoded px)

---

## 14. PERFORMANCE CONSIDERATIONS

### StateFlow Subscriptions
- All `collectAsState()` calls use Jetpack Compose's efficient collection
- Recomposition only occurs when specific StateFlow value changes
- No unnecessary recompositions across all flows

### Conditional Rendering
- `activeProgram?.let { ... }` prevents rendering card when null
- Dialogs only compose when conditions met
- Efficient conditional rendering in Compose

### Animation Performance
- Spring animation uses Compose's optimized animation framework
- Runs on composition thread (not separate thread)
- GPU-accelerated scale transform

### Lazy Loading Consideration
- Routines list collected as StateFlow
- Not explicitly lazy-loaded in HomeScreen
- Could be optimized if routines list becomes very large

---

## 15. KOTLIN/COMPOSE IDIOMS USED

1. **Safe Null Navigation**: `activeProgram?.let { ... }`
2. **StateFlow Collection**: `viewModel.state.collectAsState()`
3. **Scope Functions**: `.let`, `.map` on flows
4. **Reusable Composables**: `WorkoutCard` function component
5. **String Formatting**: `"%.1f %s".format(value, unit)`
6. **Enum Values**: `unit.name.lowercase()`
7. **Function References**: `viewModel::formatWeight`
8. **Lambda Captures**: Click handlers with captured values
9. **Extension Properties**: Material Typography properties
10. **Sealed Classes**: `NavigationRoutes` sealed class navigation

---

## 16. RELATED COMPONENTS

### Dependencies
- `MainViewModel` - Provides all state and actions
- `WorkoutRepository` - Loads programs and routines
- `NavigationRoutes` - Navigation destinations
- `StatsCard` - Reusable stat display (not used in HomeScreen currently)
- `ConnectingOverlay` - Loading dialog for BLE connection
- `ConnectionErrorDialog` - Error handling for BLE issues

### Used Material Components
- `Box` - Root container
- `Column` - Vertical layout
- `Row` - Horizontal layout in card
- `Card` - Elevated card surface
- `Text` - Text display
- `Icon` - Icon display
- `Button` - Interactive button
- `Surface` - Round icon background
- `Spacer` - Spacing element

### Material 3 Theme Integration
- `MaterialTheme.colorScheme` - Dynamic theming
- `MaterialTheme.typography` - Consistent typography
- `CardDefaults` - Card styling
- `ButtonDefaults` - Button styling
- `Colors` objects - Dark/light color definitions

---

## 17. STATE FLOW DIAGRAM

```
MainViewModel
├── workoutStreak: StateFlow<Int?>
│   └─ Calculated: Consecutive days with workouts
├── completedWorkouts: StateFlow<Int?>
│   └─ Calculated: Total workout count
├── progressPercentage: StateFlow<Int?>
│   └─ Calculated: Volume change % from last workout
├── connectionState: StateFlow<ConnectionState>
│   └─ Source: BleRepository
├── isAutoConnecting: StateFlow<Boolean>
│   └─ Source: Internal auto-connection logic
├── connectionError: StateFlow<String?>
│   └─ Source: BLE errors
├── activeProgram: StateFlow<WeeklyProgramWithDays?>
│   └─ Source: WorkoutRepository
├── routines: StateFlow<List<Routine>>
│   └─ Source: ExerciseRepository
└── weightUnit: StateFlow<WeightUnit>
    └─ Source: PreferencesManager
```

---

## 18. MIGRATION NOTES FOR FLUTTER PORT

### Equivalent Flutter Concepts

| Kotlin/Compose | Flutter |
|---|---|
| `StateFlow` | Riverpod `StateNotifierProvider` + `StreamProvider` |
| `collectAsState()` | `riverpod.consumer_widget` + `.watch()` |
| `MutableStateFlow` | Riverpod `StateNotifier` |
| `@Composable` function | `Widget` class / function |
| `Column` | `Column` widget |
| `Row` | `Row` widget |
| `Card` | `Card` widget or `Material` + elevation |
| `Text` | `Text` widget |
| `Icon` | `Icon` widget |
| `Button` | `ElevatedButton` or `Material` + `InkWell` |
| `Shape: RoundedCornerShape(16.dp)` | `borderRadius: BorderRadius.circular(16)` |
| `Brush.linearGradient()` | `LinearGradient` in `Container` decoration |
| Spring animation | `TweenSequence` or `Flutter Animate` package |
| `remember { mutableStateOf() }` | `useState()` equivalent: local state in `State` class |
| `Modifier.fillMaxWidth()` | `width: double.infinity` or `constraints.maxWidth` |
| `Modifier.padding(20.dp)` | `Padding` widget or `EdgeInsets` |
| `Arrangement.spacedBy()` | `SizedBox(height/width)` between items or `Spacing` helper |
| `navigateController.navigate()` | `Navigator.push()` or Named Routes |
| `LaunchedEffect` | `useEffect` hook or `initState()` |

### Key Porting Steps

1. **Create Flutter widgets** for `HomeScreen`, `WorkoutCard`, `HomeActiveProgramCard`
2. **Set up Riverpod providers** to replicate StateFlow behavior
3. **Implement animation** for card press using `TweenAnimationBuilder` or `animate_do`
4. **Create theme system** with gradients and color schemes
5. **Build routing** using GoRouter or Navigator 2.0
6. **Implement error/loading overlays** for connection states
7. **Test with actual data** from MainViewModel equivalent

---

## 19. VALIDATION CHECKLIST

- [x] Layout hierarchy documented completely
- [x] All colors with hex codes identified
- [x] All fonts and sizes specified
- [x] All spacing/padding values documented
- [x] All interactions and animations detailed
- [x] State management flows mapped
- [x] Navigation destinations identified
- [x] Conditional rendering logic explained
- [x] Active program card logic detailed
- [x] Weight formatting logic included
- [x] Workout streak calculation explained
- [x] Progress percentage calculation explained
- [x] All four workout cards documented with unique gradients
- [x] Press animation timeline detailed
- [x] Connection flow documented
- [x] Error handling flow documented
- [x] Responsive behavior considerations noted
- [x] Accessibility features identified
- [x] Performance considerations noted
- [x] Material 3 integration detailed

---

## 20. QUICK REFERENCE TABLE

| Aspect | Value |
|--------|-------|
| **Screen Name** | HomeScreen |
| **File Path** | presentation/screen/HomeScreen.kt |
| **Primary Purpose** | Workout mode selection hub |
| **Main Components** | Header + Active Program Card + 4 Workout Cards |
| **Animation Style** | Spring bounce on card press |
| **Color Scheme** | Purple/Violet gradients, Material 3 dynamic colors |
| **Main StateFlows** | activeProgram, routines, connectionState, isAutoConnecting |
| **Navigation Targets** | 4 routes (JustLift, SingleExercise, DailyRoutines, WeeklyPrograms) |
| **Card Shape** | 16dp rounded corners |
| **Icon Size** | 64x64dp container, 32x32dp icon |
| **Screen Padding** | 20dp uniform |
| **Item Spacing** | 18dp |
| **Elevation** | 4dp (default), 2dp (pressed) |
| **Responsive** | Full-width cards, adapts to screen width |
| **Dark Mode** | Yes, fully supported with gradient variants |

---

**Document Generated**: 2025-11-12
**Analysis Depth**: Extreme Detail
**Source Version**: VitruvianRedux (Kotlin/Compose)
**Target Version**: VPP_Flutter_Port (Flutter/Dart)
