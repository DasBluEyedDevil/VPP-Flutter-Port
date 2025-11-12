# Kotlin WorkoutTab Implementation - Extreme Detail Analysis

**Source File**: `C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/example/vitruvianredux/presentation/screen/WorkoutTab.kt`

**Analysis Date**: 2025-11-12
**Status**: Complete Active Workout Display System

---

## Overview

The `WorkoutTab` is the primary user interface for conducting workouts in the Vitruvian fitness app. It's a comprehensive Jetpack Compose implementation that manages the entire workout lifecycle from setup through completion. The tab displays real-time BLE data, handles user interactions, and provides visual feedback throughout the workout experience.

**Key Characteristics**:
- Full-screen immersive experience with edge position bars
- Dynamically adapts to multiple workout states (Idle, Active, Countdown, Rest, Summary, Completed, Error)
- Supports both single exercises (Just Lift) and multi-exercise routines
- Real-time metric streaming at 100Hz polling rate
- Comprehensive workout setup dialog with multiple configuration options
- Haptic feedback integration for tactile confirmation

---

## Root Container Architecture

### Main Composable Signature
```kotlin
@Composable
fun WorkoutTab(
    // Connection & Workout State Management
    connectionState: ConnectionState,
    workoutState: WorkoutState,
    currentMetric: WorkoutMetric?,

    // Workout Configuration
    workoutParameters: WorkoutParameters,
    repCount: RepCount,
    repRanges: RepRanges?,
    autoStopState: AutoStopUiState,
    weightUnit: WeightUnit,

    // Optional Features
    enableVideoPlayback: Boolean,
    exerciseRepository: ExerciseRepository,
    isWorkoutSetupDialogVisible: Boolean = false,
    hapticEvents: SharedFlow<HapticEvent>? = null,

    // Routine Data
    loadedRoutine: Routine? = null,
    currentExerciseIndex: Int = 0,

    // Conversion Functions
    kgToDisplay: (Float, WeightUnit) -> Float,
    displayToKg: (Float, WeightUnit) -> Float,
    formatWeight: (Float, WeightUnit) -> String,

    // Callbacks
    onScan: () -> Unit,
    onDisconnect: () -> Unit,
    onStartWorkout: () -> Unit,
    onStopWorkout: () -> Unit,
    onSkipRest: () -> Unit,
    onProceedFromSummary: () -> Unit = {},
    onResetForNewWorkout: () -> Unit,
    onStartNextExercise: () -> Unit = {},
    onUpdateParameters: (WorkoutParameters) -> Unit,
    onShowWorkoutSetupDialog: () -> Unit = {},
    onHideWorkoutSetupDialog: () -> Unit = {},

    // Display Options
    modifier: Modifier = Modifier,
    showConnectionCard: Boolean = true,
    showWorkoutSetupCard: Boolean = true
)
```

### Root Box Container
- **Type**: `Box` with `Modifier.fillMaxSize()`
- **Background**: Gradient brush (light/dark mode aware)
  - **Light Mode**: Slate-50 → Purple-50 → Blue-50 gradient
  - **Dark Mode**: Slate-950 → Purple-950 → Slate-900 gradient
- **Z-Order Structure**: Position bars (edges) → Center content column (scrollable) → Overlay cards (always visible)

---

## Layout Structure - Complete Hierarchy

### Level 1: Root Box
```
Box (fillMaxSize)
├── Background: Vertical Gradient Brush
└── Child Elements (3 layers):
    1. Left Position Bar (VerticalCablePositionBar)
    2. Center Column (scrollable content)
    3. Right Position Bar (VerticalCablePositionBar)
    4. Overlay Cards (floating on top)
```

### Level 2: Center Content Column
```
Column (fillMaxSize, verticalScroll)
├── Padding:
│   ├── Horizontal: 56dp (with position bars) or 20dp (without)
│   ├── Vertical: 0dp
│   └── Purpose: Avoid overlapping with edge position bars
├── Vertical Arrangement: spacedBy(16.dp)
│
└── Conditional Sections:
    1. Connection Card (if showConnectionCard && not disabled by routing)
    2. State-Specific Card (Idle/Error/Completed/Active)
    3. Active Workout Details (if state is Active)
    4. Live Metrics (if Active && has current metric && warmup complete)
```

---

## Visual Components - Complete List

### 1. Position Bars (Edge Display)

**Visibility Logic**:
- Only shown when ALL conditions met:
  - Connection state is `Connected`
  - Workout state is `Active`
  - Current metric is available

**Left Position Bar (Cable A / Left Hand)**
- **Position**: `Alignment.CenterStart`
- **Dimensions**: 40dp width × fillMaxHeight()
- **Padding**: 8dp vertical, 4dp horizontal
- **Component**: `VerticalCablePositionBar`
- **Label**: "L" (Left)
- **Data Binding**:
  - `currentPosition`: `metric.positionA`
  - `minPosition`: `repRanges?.minPosA`
  - `maxPosition`: `repRanges?.maxPosA`
  - `isActive`: `positionA > 0`

**Right Position Bar (Cable B / Right Hand)**
- **Position**: `Alignment.CenterEnd`
- **Dimensions**: 40dp width × fillMaxHeight()
- **Padding**: 8dp vertical, 4dp horizontal
- **Component**: `VerticalCablePositionBar`
- **Label**: "R" (Right)
- **Data Binding**:
  - `currentPosition`: `metric.positionB`
  - `minPosition`: `repRanges?.minPosB`
  - `maxPosition`: `repRanges?.maxPosB`
  - `isActive`: `positionB > 0`

**VerticalCablePositionBar Internal Structure**:
```
Column (fillMaxHeight)
├── Label "L"/"R" (top, labelSmall, bold)
├── Spacer (4dp)
├── BoxWithConstraints (weight=1f, 40dp width, rounded 20dp)
│   ├── Background: surfaceVariant
│   ├── Range Zone Box (if min/max available)
│   │   └── Background: primary @ 30% alpha
│   ├── Current Position Fill (from bottom up)
│   │   └── Background: primary (if active) or outline @ 50% alpha
│   └── Range Markers (min & max markers, 2dp height)
│       └── Background: primary @ 60% alpha
└── Position Value (bottom, labelSmall)
    └── Text: "${currentPosition / 10}%"
```

**Position Bar Features**:
- Fills from bottom to top based on normalized position (0-1000)
- Shows calibrated range zone (min/max positions) with semi-transparent overlay
- Active state changes color (primary vs outline)
- Displays percentage value at bottom

---

### 2. Connection Card

**Conditions**: `showConnectionCard == true` && appears first in column

**Container**:
- Type: `Card`
- Width: `fillMaxWidth()`
- Colors: `surface` background
- Shape: `RoundedCornerShape(16.dp)`
- Elevation: `4.dp`
- Border: `1.dp primary @ 10% alpha`

**Header Section**:
- Text: "Connection" (titleMedium, bold)
- Spacing: `Spacing.small` below header
- Padding: `Spacing.medium` around entire card

**Content States**:

#### Disconnected
```
Row (fillMaxWidth)
├── Text("Not connected", onSurfaceVariant)
└── Button("Scan")
    └── Icon: Icons.Default.Search
```

#### Scanning
```
Row (fillMaxWidth, center alignment)
├── CircularProgressIndicator (24.dp)
└── Text("Scanning for devices...")
```

#### Connecting
```
Row (fillMaxWidth, center alignment)
├── CircularProgressIndicator (24.dp)
└── Text("Connecting...")
```

#### Connected
```
Column (fillMaxWidth)
└── Row (fillMaxWidth)
    ├── Column
    │   ├── Text(deviceName, bodyLarge, bold)
    │   └── Text(deviceAddress, bodySmall, onSurfaceVariant)
    └── IconButton
        └── Icon(Icons.Default.Close)
```

#### Error
```
Text("Error: ${message}", color=error)
```

---

### 3. Idle State Card (Setup Card)

**Conditions**:
- `connectionState is Connected`
- `workoutState is Idle`
- `showWorkoutSetupCard == true`

**Container**:
- Type: `Card`
- Width: `fillMaxWidth()`
- Colors: `surface` background
- Shape: `RoundedCornerShape(16.dp)`
- Elevation: `4.dp`
- Border: `1.dp primary @ 10% alpha`
- Padding: `Spacing.medium`

**Content**:
```
Column
├── Text("Workout Setup", titleMedium, bold)
├── Spacer(height=Spacing.small)
└── Button("Setup Workout", fillMaxWidth)
    └── Icon: Icons.Default.Settings
```

---

### 4. Error State Card

**Conditions**:
- `connectionState is Connected`
- `workoutState is Error`

**Container**:
- Type: `Card`
- Width: `fillMaxWidth()`
- Colors: `errorContainer` background
- Shape: `RoundedCornerShape(16.dp)`
- Elevation: `4.dp`
- Border: `1.dp error @ 50% alpha`
- Padding: `Spacing.medium`

**Content**:
```
Column (fillMaxWidth, center-aligned)
├── Icon(Icons.Default.Warning, size=48.dp, tint=error)
├── Spacer(Spacing.small)
├── Text("Workout Failed to Start", titleLarge, bold, onErrorContainer)
├── Spacer(Spacing.small)
├── Text(workoutState.message, bodyMedium, onErrorContainer, center-aligned)
├── Spacer(Spacing.small)
└── Text("Returning to previous screen...", bodySmall, onErrorContainer@70%)
```

---

### 5. Completed State Card

**Conditions**:
- `connectionState is Connected`
- `workoutState is Completed`

**Container**: Same as Idle card

**Content Structure**:
```
Column (fillMaxWidth, center-aligned)
├── Icon(Icons.Default.CheckCircle, size=48.dp, tint=primary)
├── Spacer(Spacing.small)
├── Text("Workout Completed!", titleLarge, primary, bold)
├── Spacer(Spacing.small)
│
├── [ONE OF]:
│   A) Next Exercise Preview (if more exercises in routine)
│   │   └── Card (primaryContainer)
│   │       ├── Text("Next Exercise", titleMedium, bold, onPrimaryContainer)
│   │       ├── Spacer(Spacing.small)
│   │       ├── Text(nextExerciseName, headlineSmall, onPrimaryContainer)
│   │       ├── Text("X sets x Y reps", bodyMedium, onPrimaryContainer)
│   │       ├── Spacer(Spacing.medium)
│   │       └── Button("Start Next Exercise", fillMaxWidth)
│   │
│   B) Start New Workout Button (last exercise or not a routine)
│       └── Button(fillMaxWidth)
│           ├── Icon(Icons.Default.Refresh)
│           └── Text("Start New Workout")
```

---

### 6. Active State Card (Workout Control)

**Conditions**:
- `connectionState is Connected`
- `workoutState is Active`

**Container**: Same as Idle card

**Content**:
```
Column (fillMaxWidth, padding=Spacing.medium)
├── Text("Workout Active", titleMedium, bold)
├── Spacer(Spacing.small)
│
├── [IF Just Lift Mode]:
│   └── JustLiftAutoStopCard
│       ├── Spacing.medium
│
└── Button("Stop Workout", fillMaxWidth)
    ├── Background: error
    ├── Icon(Icons.Default.Close)
    └── Text("Stop Workout")
```

**JustLiftAutoStopCard Structure**:
```
Card
├── Colors: errorContainer (if active) or surfaceVariant
├── Shape: RoundedCornerShape(16.dp)
├── Elevation: 2.dp
├── Padding: Spacing.medium
│
└── Column (fillMaxWidth, center-aligned)
    ├── Row (center-aligned)
    │   ├── Icon(Icons.Default.PanTool, size=default)
    │   ├── Spacer(Spacing.small)
    │   └── Text(
    │       if (active) "Stopping in ${seconds}s..."
    │       else "Auto-Stop Ready",
    │       titleMedium, bold
    │   )
    ├── Spacer(Spacing.small)
    ├── LinearProgressIndicator
    │   ├── progress: autoStopState.progress
    │   ├── height: 8.dp
    │   ├── Color: error (if active) or outline
    ├── Spacer(Spacing.small)
    └── Text("Put handles down for 5 seconds to stop")
```

---

### 7. Active State Details (Shown when workoutState is Active)

#### Rep Counter Card
```
Card (fillMaxWidth)
├── Colors: surface
├── Shape: RoundedCornerShape(16.dp)
├── Elevation: 4.dp
├── Border: 1.dp primary @ 10% alpha
├── Padding: Spacing.large
│
└── Column (fillMaxWidth, center-aligned)
    ├── Text(
    │   if (warmupComplete) "REPS" else "WARMUP",
    │   titleLarge, bold
    │ )
    ├── Spacer(Spacing.medium)
    └── Text(
        if (warmupComplete) workingReps else "${warmupReps} / ${targetWarmupReps}",
        displayLarge, bold, primary
    )
```

#### Current Exercise Card
```
Card (fillMaxWidth)
├── Colors: surface
├── Shape: RoundedCornerShape(16.dp)
├── Elevation: 4.dp
├── Border: 1.dp primary @ 10% alpha
├── Padding: Spacing.medium
│
└── Column (fillMaxWidth)
    ├── Text(exerciseName, titleLarge, bold, onSurface)
    ├── Spacer(Spacing.small)
    │
    ├── [Exercise Details Line]:
    │   └── Text(
    │       "${reps} @ ${weight} - ${mode}",
    │       bodyLarge, onSurface
    │   )
    │
    └── [IF Video Enabled & Video Available]:
        ├── Spacer(Spacing.medium)
        └── VideoPlayer (fillMaxWidth, height=200.dp)
            └── RoundedCornerShape(12.dp)
```

**Current Exercise Card - Routine Logic**:
- Gets current exercise from `loadedRoutine[currentExerciseIndex]`
- Formats reps: "4x8" (if all equal) or "8, 8, 6, 6" (if different)
- Handles cable weights display:
  - Single weight: "45 kg"
  - Weight range: "40-50 kg" (if varies by set)
- Cable configuration suffix: "(Single)" or "/cable (Double)"

#### Live Metrics Card
```
Card (fillMaxWidth)
├── Colors: surface
├── Shape: RoundedCornerShape(16.dp)
├── Elevation: 4.dp
├── Border: 1.dp primary @ 10% alpha
├── Padding: Spacing.medium
│
└── Column (fillMaxWidth)
    ├── Text("Live Metrics", titleMedium, bold)
    ├── Spacer(Spacing.small)
    │
    ├── Text(
    │   formatWeight(metric.totalLoad / 2f),
    │   displayMedium, bold, primary
    │ )
    ├── Text("Per Cable", bodySmall, onSurfaceVariant)
    ├── Spacer(Spacing.medium)
    │
    └── Column (fillMaxWidth)
        ├── Text("Cable Positions", bodySmall, onSurfaceVariant)
        ├── Spacer(Spacing.extraSmall)
        │
        ├── [Cable A Row]:
        │   ├── Text("A", labelSmall, width=20.dp)
        │   ├── LinearProgressIndicator
        │   │   ├── progress: positionA / 1000f
        │   │   ├── height: 8.dp
        │   │   └── color: primary
        │   └── Text("${positionA}", labelSmall, width=50.dp, end-aligned)
        │
        ├── Spacer(Spacing.extraSmall)
        │
        └── [Cable B Row]:
            ├── Text("B", labelSmall, width=20.dp)
            ├── LinearProgressIndicator
            │   ├── progress: positionB / 1000f
            │   ├── height: 8.dp
            │   └── color: secondary
            └── Text("${positionB}", labelSmall, width=50.dp, end-aligned)
```

---

### 8. Overlay Cards (Always Visible, Float on Top)

These cards are positioned OUTSIDE the scrollable column to stay visible during scrolling.

#### Countdown Card
```
Box (fillMaxSize)
├── Background: Vertical gradient (background → surface → surfaceVariant)
├── Padding: 20.dp
│
└── Column (fillMaxSize, center-aligned)
    ├── Text("Get Ready!", titleLarge, onSurfaceVariant)
    ├── Spacer(12.dp)
    ├── Surface (scale animation)
    │   └── Text(
    │       "${secondsRemaining}",
    │       displayLarge(fontSize=96.sp), bold, primary
    │   )
    ├── Spacer(12.dp)
    └── Text("Starting in...", titleMedium, onSurface)
```

**Animation**: Pulsing scale effect
- Initial: 1.0
- Target: 1.08
- Duration: 1200ms
- Easing: FastOutSlowInEasing
- Mode: InfiniteRepeatable(Reverse)

#### Rest Timer Card
```
Box (fillMaxSize)
├── Background: Vertical gradient
├── Padding: 20.dp
│
└── Column (fillMaxSize, spacedBy=SpaceBetween)
    ├── Spacer(8.dp)
    │
    ├── Text("REST TIME", labelLarge, bold, onSurfaceVariant)
    │   └── Spacing: 1.5.sp letter-spacing
    │
    ├── Box (fillMaxWidth, height=220.dp, center-aligned)
    │   ├── Box (scale animation, size=220.dp, rounded)
    │   │   └── Background: surfaceContainerHighest
    │   └── Text(
    │       formatRestTime(secondsRemaining),
    │       displayLarge(fontSize=80.sp), bold, primary
    │   )
    │
    ├── Text("UP NEXT", labelMedium, bold, onSurfaceVariant)
    │
    ├── Text(
    │   if (lastExercise) "Workout Complete" else nextExerciseName,
    │   titleLarge, bold,
    │   color=(lastExercise ? primary : onSurface)
    │ )
    │
    ├── [IF not last exercise]:
    │   └── Text("Set X of Y", bodyMedium, onSurfaceVariant)
    │
    ├── [IF has parameters]:
    │   ├── Spacer(Spacing.small)
    │   └── Surface (rounded 12.dp, surfaceContainerHigh)
    │       └── Column (padding=Spacing.medium, spacedBy=Spacing.small)
    │           ├── Text("WORKOUT PARAMETERS", labelSmall, bold, onSurfaceVariant)
    │           └── Row (fillMaxWidth, spacedBy)
    │               ├── WorkoutParamItem(Weight)
    │               ├── WorkoutParamItem(Target Reps)
    │               └── WorkoutParamItem(Mode)
    │
    ├── [IF routine with multiple exercises]:
    │   ├── Spacer(Spacing.small)
    │   └── Column (fillMaxWidth, center-aligned)
    │       ├── Text("Exercise X of Y", labelMedium, onSurfaceVariant)
    │       ├── Spacer(4.dp)
    │       └── LinearProgressIndicator
    │           ├── progress: (currentIndex+1) / totalExercises
    │           ├── height: 4.dp
    │
    ├── Spacer(Spacing.medium)
    │
    └── Column (fillMaxWidth, spacedBy=Spacing.small)
        ├── Button("Skip Rest", fillMaxWidth, primary)
        │   ├── Icon(Icons.Default.PlayArrow, size=20.dp)
        │   └── Text(if (lastExercise) "Continue" else "Skip Rest")
        │
        └── TextButton("End Workout", fillMaxWidth)
            ├── Icon(Icons.Default.Close, size=18.dp, tint=error)
            └── Text("End Workout", color=error)
```

**Animation**: Pulsing background scale
- Initial: 1.0
- Target: 1.06
- Duration: 1600ms
- Easing: FastOutSlowInEasing
- Mode: InfiniteRepeatable(Reverse)

**Time Format**: Converts seconds to "M:SS" format
- Example: 90 seconds → "1:30"

#### Set Summary Card
```
Card (fillMaxWidth)
├── Colors: surface
├── Shape: RoundedCornerShape(16.dp)
├── Elevation: 4.dp
├── Border: 1.dp primary @ 10% alpha
├── Padding: Spacing.medium
│
└── Column (fillMaxWidth, center-aligned, spacedBy=Spacing.medium)
    ├── Row (fillMaxWidth, center-aligned)
    │   ├── Icon(Icons.Default.CheckCircle, size=32.dp, primary)
    │   ├── Spacer(Spacing.small)
    │   └── Text("Set Complete!", headlineSmall, primary, bold)
    │
    ├── Row (fillMaxWidth, spacedBy)
    │   ├── StatCard("Peak", formatWeight(peakPower))
    │   ├── Spacer(Spacing.small)
    │   ├── StatCard("Average", formatWeight(averagePower))
    │   ├── Spacer(Spacing.small)
    │   └── StatCard("Reps", "${repCount}")
    │
    ├── [IF metrics available]:
    │   ├── Text("Force Over Time", titleMedium, onSurface)
    │   └── ForceGraph (fillMaxWidth, height=200.dp)
    │
    └── Button("Continue", fillMaxWidth, primary)
        ├── Text("Continue")
        ├── Spacer(Spacing.small)
        └── Icon(Icons.AutoMirrored.Filled.KeyboardArrowRight)
```

**StatCard Structure**:
```
Card (radius=12.dp)
├── Colors: primaryContainer
└── Column (center-aligned, padding=Spacing.small)
    ├── Text(label, labelMedium, onPrimaryContainer)
    ├── Spacer(4.dp)
    └── Text(value, titleLarge, bold, onPrimaryContainer)
```

**ForceGraph**: Line chart using MPAndroidChart
- X-axis: Time in seconds
- Y-axis: Force/Load value
- Line: Cubic Bezier interpolation
- Color: Purple (#9333EA)
- Filled: Yes, with 50% opacity
- Circles: None (cleaner look)
- Draggable, pinch-zoomable

---

## Workout Setup Dialog

**Trigger**: `onShowWorkoutSetupDialog()`
**Visibility**: `isWorkoutSetupDialogVisible`
**Dismissal**: `onHideWorkoutSetupDialog()` or confirm

**Dialog Container**:
```
AlertDialog
├── Shape: RoundedCornerShape(16.dp)
├── Container Color: surface
├── Title: Text("Workout Setup", titleLarge, bold, onSurface)
│
└── Text Content (verticalScroll):
    ├── Spacing: spacedBy(Spacing.small)
    │
    ├── SECTION 1: Exercise Selection
    │   └── Card (fillMaxWidth)
    │       ├── Padding: 16.dp horizontal, 8.dp vertical
    │       ├── Text("Exercise", titleMedium, bold)
    │       ├── Spacer(8.dp)
    │       └── OutlinedButton(fillMaxWidth)
    │           └── Text(selectedExercise?.name ?: "Select Exercise")
    │
    ├── SECTION 2: Workout Mode Dropdown
    │   └── ExposedDropdownMenuBox (fillMaxWidth)
    │       ├── Label: "Base Mode (resistance profile)" (if Just Lift)
    │       │    OR "Workout Mode"
    │       ├── Read-only OutlinedTextField
    │       └── Dropdown Menu Items:
    │           ├── "Old School"
    │           ├── "Pump"
    │           ├── "Eccentric Only"
    │           ├── "Echo Mode" → (arrow) → opens ModeSubSelectorDialog
    │           └── "TUT" → (arrow) → opens ModeSubSelectorDialog
    │
    ├── SECTION 3: Weight Picker Card
    │   └── Card (fillMaxWidth)
    │       ├── [IF Echo Mode]:
    │       │   ├── Text("Weight per cable", titleMedium, bold)
    │       │   ├── Spacer(8.dp)
    │       │   ├── Text("Adaptive", displaySmall, primary, bold)
    │       │   └── Text("Echo mode adapts weight...", bodySmall, onSurfaceVariant)
    │       │
    │       └── [ELSE]:
    │           └── CompactNumberPicker
    │               ├── Value: kgToDisplay(weightPerCableKg)
    │               ├── Range: 1..220 (LB) or 1..100 (kg)
    │               └── Label: "Weight per cable (${unit})"
    │
    ├── SECTION 4: Reps Picker Card
    │   └── Card (fillMaxWidth)
    │       ├── [IF Just Lift]:
    │       │   ├── Text("Target reps", titleMedium, bold)
    │       │   ├── Spacer(8.dp)
    │       │   ├── Text("N/A", displaySmall, onSurfaceVariant)
    │       │   └── Text("Just Lift doesn't use target reps...", bodySmall, onSurfaceVariant)
    │       │
    │       └── [ELSE]:
    │           └── CompactNumberPicker
    │               ├── Value: reps
    │               ├── Range: 1..50
    │               └── Label: "Target reps"
    │
    ├── [SECTION 5: Progression/Regression (if Program mode)]:
    │   └── Card (fillMaxWidth)
    │       ├── Text("Progression/Regression", titleMedium, bold)
    │       ├── Spacer(8.dp)
    │       ├── Row (spacedBy=8.dp)
    │       │   ├── FilterChip("Prog")
    │       │   │   └── Icon: KeyboardArrowUp (if selected)
    │       │   └── FilterChip("Regr")
    │       │       └── Icon: KeyboardArrowDown (if selected)
    │       ├── Spacer(8.dp)
    │       └── CompactNumberPicker
    │           ├── Value: kgToDisplay(|progressionRegressionKg|)
    │           ├── Range: 0..6 (LB) or 0..3 (kg)
    │           └── Label: "Amount (${unit})"
    │
    ├── SECTION 6: Just Lift Toggle
    │   └── Row (fillMaxWidth, spaceBetween)
    │       ├── Text("Just Lift")
    │       └── Switch (checked=isJustLift)
    │
    ├── SECTION 7: Finish At Top Toggle
    │   └── Row (fillMaxWidth, spaceBetween)
    │       ├── Text("Finish At Top")
    │       └── Switch
    │           ├── checked: stopAtTop
    │           └── enabled: !isJustLift
    │
    └── Buttons:
        ├── Confirm: Button("Start Workout", enabled=exerciseSelected)
        │   ├── Icon(Icons.Default.PlayArrow)
        │   ├── Text("Start Workout")
        │   └── onClick: onStartWorkout() + onHideWorkoutSetupDialog()
        │
        └── Dismiss: TextButton("Cancel")
```

---

### CompactNumberPicker Component

**Purpose**: Interactive number selection with drag support

**Dimensions**: 80dp height

**Structure**:
```
Column
├── [IF label provided]:
│   └── Text(label, labelMedium, bottom-padding=4.dp)
│
└── Row (height=80.dp, spaceBetween vertically-centered)
    ├── IconButton(minus)
    │   ├── Icon(Icons.Default.KeyboardArrowDown)
    │   ├── Enabled: value > range.first
    │   ├── Haptic: LongPress on click
    │   └── OnClick: value - 1
    │
    ├── Box (weight=1f, draggable)
    │   ├── Pointer Input: vertical drag detection
    │   ├── Drag Sensitivity: 3dp = 1 increment
    │   ├── Haptic: LongPress on increment
    │   │
    │   └── Column (center-aligned)
    │       ├── [IF dragging && value < max]:
    │       │   └── Text("${value+1}", bodySmall, onSurfaceVariant@40%)
    │       │
    │       ├── Text("${value}", displaySmall, bold, primary)
    │       │
    │       └── [IF dragging && value > min]:
    │           └── Text("${value-1}", bodySmall, onSurfaceVariant@40%)
    │
    └── IconButton(plus)
        ├── Icon(Icons.Default.KeyboardArrowUp)
        ├── Enabled: value < range.last
        ├── Haptic: LongPress on click
        └── OnClick: value + 1
```

**Interaction**:
- **Tap +/-**: Increment/decrement by 1
- **Drag Vertical**: Smooth value change (3dp = 1 step)
- **Adjacent Numbers**: Show while dragging (faded)
- **Haptic**: LongPress vibration on every change

---

### Mode Sub-Selector Dialog

**Trigger**: Echo or TUT mode selected in main dropdown

#### TUT Variant Selector
```
AlertDialog
├── Title: "Select TUT Variant"
└── Text Content:
    └── Column (spacedBy=Spacing.small)
        ├── OutlinedButton("TUT", fillMaxWidth)
        └── OutlinedButton("TUT Beast", fillMaxWidth)
```

#### Echo Configuration Dialog
```
AlertDialog
├── Title: "Echo Mode Configuration"
├── Text: "Echo adapts resistance to your output"
│
└── Column (spacedBy=Spacing.small)
    ├── ECHO LEVEL Dropdown
    │   ├── Options: HARD, HARDER, HARDEST, EPIC
    │   └── Default: HARD
    │
    ├── ECCENTRIC LOAD Dropdown
    │   ├── Options: 0%, 50%, 75%, 100%, 125%, 150%
    │   └── Default: 100%
    │
    ├── Confirm Button
    │   └── OnSelect(WorkoutMode.Echo, EccentricLoad)
    │
    └── Dismiss Button
```

---

## Color Palette

### Background Gradients
| Mode | Color 1 | Color 2 | Color 3 |
|------|---------|---------|---------|
| Light | #F8FAFC (Slate-50) | #F5F3FF (Purple-50) | #EFF6FF (Blue-50) |
| Dark | #0F172A (Slate-950) | #312E81 (Purple-950) | #0F172A (Slate-900) |

### Component Colors
- **Primary**: Material3 Theme `colorScheme.primary`
- **Surface**: Material3 Theme `colorScheme.surface`
- **Surface Variant**: Material3 Theme `colorScheme.surfaceVariant`
- **Primary Container**: Material3 Theme `colorScheme.primaryContainer`
- **Error**: Material3 Theme `colorScheme.error`
- **Error Container**: Material3 Theme `colorScheme.errorContainer`
- **On Surface**: Material3 Theme `colorScheme.onSurface`
- **On Surface Variant**: Material3 Theme `colorScheme.onSurfaceVariant`
- **On Error Container**: Material3 Theme `colorScheme.onErrorContainer`
- **Force Graph Line**: `#9333EA` (Purple-600)
- **Force Graph Fill**: `#9333EA` @ 50% opacity

### Transparency Levels
- Borders: 10% alpha on primary
- Range zones: 30% alpha on primary
- Inactive states: 50% alpha on outline
- Faded text: 40% alpha on onSurfaceVariant
- Subtle overlays: 70% alpha on onSurfaceVariant

---

## Typography & Font Sizing

### Text Styles Used (Material3)
- **displayLarge**: Countdown number (96sp), Rest timer (80sp)
- **headlineSmall**: Set complete header
- **titleLarge**: Main card headers, workout mode labels
- **titleMedium**: Section headers within cards
- **titleSmall**: Value labels in stat cards
- **bodyLarge**: Exercise details, parameter text
- **bodyMedium**: Secondary information
- **bodySmall**: Tertiary information, help text
- **labelLarge**: Prominent labels ("REST TIME", "UP NEXT")
- **labelMedium**: Field labels, parameter labels
- **labelSmall**: Inline labels, position indicators

### Font Weights
- **ExtraBold**: Countdown/timer numbers
- **Bold**: All titles, major headers, primary values
- **SemiBold**: Graph titles
- **Normal**: Body text

### Letter Spacing
- **1.5.sp**: "REST TIME" header
- **1.2.sp**: "UP NEXT" header
- **1.0.sp**: "WORKOUT PARAMETERS" section

---

## Spacing System

**Base Spacing Values** (from `Spacing` object):
- **extraSmall**: 4.dp
- **small**: 8.dp
- **medium**: 16.dp
- **large**: 24.dp

### Common Padding/Margin Usage
| Element | Horizontal | Vertical |
|---------|-----------|----------|
| Card Content | medium (16dp) | medium (16dp) |
| Column Content | medium (16dp) | 0dp (use spacedBy) |
| Edge Position Bars | 4dp | 8dp |
| Horizontal Arrangement | spacedBy(8dp) | - |
| Vertical Arrangement | - | spacedBy(16dp) |
| Dialog Padding | - | 20dp |
| Button Padding | - | implicit Material3 |

### Specific Spacing
- Column vertical gap: 16.dp (spacedBy)
- Card padding: Spacing.medium (16dp)
- Position bar padding: 4dp horizontal, 8dp vertical
- Center column horizontal padding: 56dp (with bars) or 20dp (without)
- Video player height: 200.dp
- Position bars width: 40.dp
- Rep counter top padding: Spacing.large (24dp)

---

## Interactions & State Management

### Connection State Transitions
```
Disconnected
    ↓ [onScan]
Scanning → Connecting → Connected
    ↓                      ↓
  Error              [Ready for workout]
```

### Workout State Transitions
```
Idle
  ↓ [onStartWorkout]
Countdown (pre-workout timer)
  ↓
Active (actively lifting)
  ├─ Rep counter → warmup complete
  ├─ Live metrics update @ 100Hz
  ├─ Cable position monitoring
  │
  ├─ [After set completes]
  ├→ SetSummary (overlay)
  │   ↓ [onProceedFromSummary]
  │
  └─ [Between sets]
     → Resting (overlay)
        ├─ Rest timer countdown
        ├─ Next exercise preview
        ├─ Workout parameters preview
        └─ [onSkipRest or timer expires]
           ↓
        → Active (next set/exercise)

Error → [automatic dismiss after delay]
  ↓
Return to Idle

Completed → [show completion screen]
  ├─ If more exercises: Show next exercise preview
  │  ├─ [onStartNextExercise]
  │  └─ Reset to Idle, start next
  │
  └─ Last exercise: Show "Start New Workout"
     └─ [onResetForNewWorkout] → Idle
```

### User Interactions

#### Connection Card
- **Scan Button**: `onScan()` → triggers device scan
- **Disconnect Icon**: `onDisconnect()` → closes BLE connection

#### Idle/Setup State
- **Setup Workout Button**: `onShowWorkoutSetupDialog()` → opens dialog

#### Workout Setup Dialog
- **Exercise Picker**: Opens exercise selection dialog
- **Mode Dropdown**:
  - Select mode (Old School, Pump, etc.)
  - For Echo/TUT: opens sub-selector dialog
- **Number Pickers**:
  - Tap +/- or drag to adjust
  - Range constraints enforced
- **Filter Chips** (Prog/Regr): Toggle progression/regression direction
- **Toggle Switches**: Just Lift, Finish At Top
- **Start Workout**: `onStartWorkout()` + `onHideWorkoutSetupDialog()`
- **Cancel**: `onHideWorkoutSetupDialog()`

#### Active Workout
- **Stop Workout Button**: `onStopWorkout()` → stops active workout
- **Just Lift Auto-Stop**: Shows countdown when active (requires 5s handle release)

#### Overlays
- **Rest Timer**:
  - Skip Rest: `onSkipRest()`
  - End Workout: `onStopWorkout()`
- **Set Summary**:
  - Continue: `onProceedFromSummary()`
- **Countdown**: Auto-advances when complete

#### Position Bars
- **Visibility**: Dynamic based on workout state
- **Update Frequency**: 100Hz (matches BLE polling)

---

## Animations & Transitions

### Countdown Card
```kotlin
// Pulsing scale animation
animateFloat(
    initialValue = 1f,
    targetValue = 1.08f,
    animationSpec = infiniteRepeatable(
        animation = tween(durationMillis = 1200, easing = FastOutSlowInEasing),
        repeatMode = RepeatMode.Reverse
    )
)
// Applied to: Text(displayLarge, fontSize=96sp)
```

### Rest Timer Card
```kotlin
// Pulsing background scale
animateFloat(
    initialValue = 1f,
    targetValue = 1.06f,
    animationSpec = infiniteRepeatable(
        animation = tween(durationMillis = 1600, easing = FastOutSlowInEasing),
        repeatMode = RepeatMode.Reverse
    )
)
// Applied to: Circular background Box(size=220dp)
```

### Number Picker
- Vertical drag: Smooth incremental updates
- Drag sensitivity: 3.0dp per increment
- Adjacent number indicators fade in/out during drag

### List/Card Entry
- Cards use implicit fade-in via Compose recomposition
- No explicit entry/exit animations at card level

---

## Data Display Logic

### Rep Counter Display
```kotlin
if (repCount.isWarmupComplete) {
    countText = repCount.workingReps.toString()
    labelText = "REPS"
} else {
    countText = "${repCount.warmupReps} / ${workoutParameters.warmupReps}"
    labelText = "WARMUP"
}
```

### Weight Display Conversion
- Always converts kg to display units (LB or kg)
- Uses `kgToDisplay` callback for all weight values
- Format: "45.0 kg" or "99.2 lbs" (1 decimal place)

### Exercise Reps Format
```kotlin
val repsText = if (currentExercise.setReps.all { it == currentExercise.setReps.first() }) {
    "${currentExercise.setReps.size}x${currentExercise.setReps.first()}"  // "4x8"
} else {
    currentExercise.setReps.joinToString(", ")  // "8, 8, 6, 6"
}
```

### Weight Per Cable Display
```kotlin
// For multiple sets with different weights:
val minWeight = displayWeights.minOrNull() ?: 0f
val maxWeight = displayWeights.maxOrNull() ?: 0f

if (minWeight == maxWeight) {
    "%.1f %s".format(minWeight, weightSuffix)  // "45.0 kg"
} else {
    "%.1f-%.1f %s".format(minWeight, maxWeight, weightSuffix)  // "40.0-50.0 kg"
}
```

### Cable Configuration Display
```kotlin
val weightText = when (currentExercise.cableConfig) {
    CableConfiguration.SINGLE -> "$baseWeightText (Single)"
    CableConfiguration.DOUBLE -> "$baseWeightText/cable (Double)"
    else -> baseWeightText
}
```

### Position Percentage Calculation
```kotlin
// Position bars show: currentPosition / 10 as percentage
// Range: 0-1000 → 0%-100%
val displayPercentage = "${currentPosition / 10}%"
```

### Metrics Calculation
- **Per-Cable Load**: `metric.totalLoad / 2.0` (divides between two cables)
- **Cable Position Progress**: `(position / 1000f).coerceIn(0f, 1f)`
- **Rest Time Format**: `"${minutes}:${seconds.padZero(2)}"`

### Workout Parameters Preview (in Rest Timer)
Displays:
- Weight: `formatWeight(nextExerciseWeight)`
- Target Reps: `nextExerciseReps.toString()`
- Mode: `nextExerciseMode.take(8)` (truncate to 8 chars)

---

## Video Playback

### VideoPlayer Component

**Conditions**: `enableVideoPlayback == true` AND video available for exercise

**Container**:
- Modifier: `fillMaxWidth, height=200.dp, clip(rounded 12.dp)`
- Within: `CurrentExerciseCard` below exercise details

**AndroidView Integration**:
```kotlin
VideoView(context).apply {
    layoutParams = MatchParent, MatchParent
    setVideoURI(videoUrl.toUri())

    // Listeners
    setOnPreparedListener { mp →
        isLoading = false
        mp.isLooping = true
        start()
    }
    setOnErrorListener { →
        isLoading = false
        hasError = true
        true
    }
}
```

**Display States**:
1. **Loading**: CircularProgressIndicator (32dp, primary color)
2. **Playing**: Video autoplays in loop, no controls
3. **Error**: PlayCircle icon (48dp, onSurfaceVariant @ 50%)

---

## State Management & Props Flow

### Input Props (Observables)
- `connectionState`: Flow of connection status
- `workoutState`: Flow of workout states
- `currentMetric`: Current real-time BLE metric
- `workoutParameters`: Current configuration (mutable via `onUpdateParameters`)
- `repCount`: Current rep count state
- `repRanges`: Calibrated position ranges
- `autoStopState`: Just Lift auto-stop countdown

### Output Callbacks
```kotlin
onScan()                           // Initiate BLE scan
onDisconnect()                     // Close BLE connection
onStartWorkout()                   // Begin workout countdown
onStopWorkout()                    // End active workout
onSkipRest()                       // Skip rest period
onProceedFromSummary()             // Advance past set summary
onResetForNewWorkout()             // Restart after completion
onStartNextExercise()              // Begin next routine exercise
onUpdateParameters(params)         // Update workout configuration
onShowWorkoutSetupDialog()         // Open setup dialog
onHideWorkoutSetupDialog()         // Close setup dialog
```

### Haptic Feedback
```kotlin
hapticEvents: SharedFlow<HapticEvent>?

// Applied to:
// - Number picker increments: HapticFeedbackType.LongPress
// - Manual configuration confirmations
```

---

## Error Handling & Edge Cases

### Connection Errors
- **Display**: Error message in ConnectionCard
- **Format**: "Error: ${connectionState.message}"
- **User Action**: Can retry with "Scan" button

### Workout Errors
- **Display**: Error state card with warning icon
- **Message**: From `workoutState.error.message`
- **Auto-Recovery**: Returns to Idle state after short delay
- **Examples**:
  - Device disconnected during workout
  - BLE communication failure
  - Invalid parameter configuration

### Missing Data Handling
- **No exercise selected**: Start button disabled in dialog
- **No video available**: Skips video section in card
- **No metrics**: Live metrics card doesn't appear
- **Not warmup complete**: Metrics hidden until warmup finishes
- **Null routine**: Falls back to "Just Lift" mode parameters

### Range Validation
- **Weight**: min=1, max=220 (LB) or 100 (kg)
- **Reps**: min=1, max=50
- **Progression**: min=0, max=6 (LB) or 3 (kg)
- **Position**: Clamped to 0-1000 range for display

---

## Performance Considerations

### Rendering Optimization
- Position bars only rendered when all visibility conditions met
- Live metrics only rendered when warmup complete
- Overlay cards positioned outside scrollable content
- Lazy recomposition of state-specific cards

### BLE Data Streaming
- Metrics update at 100Hz polling rate
- Position bars update real-time without recomposing entire screen
- LinearProgressIndicators use efficient progress animation

### Memory Management
- Video views properly cleanup on disposal
- Haptic feedback events consumed and discarded
- Scroll state managed efficiently with `rememberScrollState`

---

## Accessibility Considerations

### Content Descriptions
- Icons have `contentDescription` for screen readers
- Cards have semantic structure (headers, content sections)
- Navigation/action buttons clearly labeled

### Haptic Feedback
- Provides non-visual feedback for number picker interaction
- Important for users with visual impairments

### Color Contrast
- All text uses Material3 color scheme for accessibility
- Overlays respect theme mode (light/dark)
- Error states use distinct color (red) with icon

### Touch Targets
- Buttons: Implicit Material3 sizing (48dp minimum)
- Icon buttons: 48dp
- Number picker: 80dp height for easy dragging

---

## Related Components

### Imported Components
- `ConnectionCard`: Handles device connection UI
- `WorkoutSetupDialog`: Complete workout configuration dialog
- `ExercisePickerDialog`: Exercise selection (from components)
- `ModeSubSelectorDialog`: Echo/TUT mode configuration
- `RepCounterCard`: Displays current rep count
- `CurrentExerciseCard`: Shows exercise details and video
- `LiveMetricsCard`: Real-time metrics display
- `VerticalCablePositionBar`: Edge position visualization
- `VideoPlayer`: Exercise demonstration video playback
- `JustLiftAutoStopCard`: Just Lift mode auto-stop countdown
- `CountdownCard`: Pre-workout countdown display
- `RestTimerCard`: Rest period countdown and next exercise preview
- `SetSummaryCard`: Post-set metrics summary with force graph

### Referenced Data Models
```kotlin
// Connection
ConnectionState (sealed class):
  - Disconnected
  - Scanning
  - Connecting
  - Connected(deviceName, deviceAddress)
  - Error(message)

// Workout States
WorkoutState (sealed class):
  - Idle
  - Countdown(secondsRemaining)
  - Active
  - SetSummary(metrics, peakPower, averagePower, repCount)
  - Resting(restSecondsRemaining, nextExerciseName, ...)
  - Completed
  - Error(message)

// Configuration
WorkoutParameters:
  - selectedExerciseId: Long?
  - workoutType: WorkoutType
  - weightPerCableKg: Float
  - reps: Int
  - progressionRegressionKg: Float
  - isJustLift: Boolean
  - stopAtTop: Boolean
  - warmupReps: Int

WorkoutType (sealed):
  - Program(mode: ProgramMode)
  - Echo(level: EchoLevel, eccentricLoad: EccentricLoad)
  - TUT(variant: TUTVariant)
  - TUTBeast
  - Custom

// Metrics
WorkoutMetric:
  - timestamp: Long
  - totalLoad: Float (force)
  - positionA: Int (0-1000)
  - positionB: Int (0-1000)

RepCount:
  - warmupReps: Int
  - workingReps: Int
  - isWarmupComplete: Boolean

AutoStopUiState:
  - isActive: Boolean
  - secondsRemaining: Int
  - progress: Float (0f-1f)

// Exercise
Exercise:
  - id: Long
  - name: String

RoutineExercise:
  - exercise: Exercise
  - setReps: List<Int>
  - setWeightsPerCableKg: List<Float>
  - weightPerCableKg: Float
  - cableConfig: CableConfiguration
  - workoutType: WorkoutType

Routine:
  - exercises: List<RoutineExercise>
```

---

## Known Quirks & Implementation Details

1. **Position Bar Display**: Hidden during setup/idle, only shown during active workout with connected device
2. **Live Metrics Delay**: Intentionally hidden during warmup to match "official app behavior" (see comment line 393)
3. **Echo Weight Display**: Shows "Adaptive" text instead of numeric picker when in Echo mode
4. **Just Lift Mode**:
   - Hides reps picker (shows "N/A" in dialog)
   - Hides countdown timer before set
   - Shows auto-stop countdown during set
   - Disables "Finish At Top" toggle
5. **Number Picker Drag**: Requires 3dp of drag to register 1 increment (sensitivity tuning)
6. **Video Player**: Loops automatically without user controls visible
7. **Set Summary**: Only appears after warmup completes and set is finished
8. **Rest Timer**: Shows exercise progress (X of Y) only for multi-exercise routines
9. **Completion Flow**: Next exercise preview only shows if there are remaining exercises in routine
10. **Dialog Scrolling**: Entire dialog content scrolls if content exceeds screen height

---

## Dart/Flutter Port Considerations

### Key Challenges for Flutter Port
1. **Position Bars**: Will need `Stack` with `Positioned` widgets for edge bars
2. **Drag Detection**: Use `GestureDetector` with `onVerticalDragUpdate` for number picker
3. **Haptic Feedback**: Use `HapticFeedback.vibrate()` or platform channels
4. **Video Playback**: Use `chewie` or `video_player` package
5. **Chart Library**: Use `fl_chart` or `syncfusion_flutter_charts` instead of MPAndroidChart
6. **Gradient Backgrounds**: Use `LinearGradient` with proper brightness detection
7. **State Management**: Use Riverpod `StateNotifierProvider` for workout state
8. **Animation**: Use `AnimationController` or Riverpod's built-in animation support
9. **Overlay Cards**: Use `Stack` positioning or `Dialog` widgets appropriately
10. **Theme Colors**: Map Material3 colors to Flutter's `ColorScheme`

### Metric Updates
- Implement 100Hz polling via `Stream` from BLE layer
- Use `StreamProvider` from Riverpod for real-time metrics
- Update position bars without full screen recomposition (use `RepaintBoundary`)

### Dialog Management
- Use `showDialog()` for AlertDialog equivalent
- Implement proper dismiss and callback handling
- Ensure keyboard behavior matches Kotlin implementation

---

## Summary Statistics

| Aspect | Count |
|--------|-------|
| Main composable functions | 15+ |
| State variations | 7 workout states |
| Cards/Overlays | 9 unique card types |
| Dropdowns | 2 (mode selector, sub-mode selector) |
| Number pickers | 4 (weight, reps, progression, echo level) |
| Interactions | 12+ user action callbacks |
| Animations | 2 (countdown pulse, rest timer pulse) |
| Position bars | 2 (left/right edge) |
| Color gradients | 2 (light/dark backgrounds) |
| Dialogs | 3 (main setup, exercise picker, mode sub-selector) |

---

## File Dependencies

**Imports**:
- `androidx.compose.foundation.*` - Layout and basic UI
- `androidx.compose.material.icons.*` - Material Design icons
- `androidx.compose.material3.*` - Material Design 3 components
- `androidx.compose.animation.core.*` - Animation utilities
- `android.widget.VideoView` - Android video playback
- `com.example.vitruvianredux.domain.model.*` - Domain models
- `com.example.vitruvianredux.presentation.components.*` - Reusable components
- `com.example.vitruvianredux.ui.theme.*` - Theme colors and spacing

**Referenced Files**:
- `CountdownCard.kt` - Pre-workout countdown overlay
- `RestTimerCard.kt` - Rest period countdown
- `SetSummaryCard.kt` - Post-set summary with force graph
- `ExercisePickerDialog.kt` - Exercise selection
- Theme system - Colors, spacing, typography

---

## Implementation Checklist for Flutter Port

- [ ] Create main `WorkoutTab` widget (ConsumerWidget)
- [ ] Implement `Box` with background gradient
- [ ] Create `VerticalCablePositionBar` edge components
- [ ] Build center `Column` with scroll view
- [ ] Implement `ConnectionCard` state display
- [ ] Build `IdleStateCard` with setup button
- [ ] Build `ErrorStateCard` with error display
- [ ] Build `CompletedStateCard` with next exercise preview
- [ ] Build `ActiveStateCard` with stop button
- [ ] Create `JustLiftAutoStopCard` with progress indicator
- [ ] Create `RepCounterCard` with warmup/working display
- [ ] Create `CurrentExerciseCard` with video support
- [ ] Create `LiveMetricsCard` with cable position indicators
- [ ] Implement `CountdownCard` overlay with animation
- [ ] Implement `RestTimerCard` overlay with countdown
- [ ] Implement `SetSummaryCard` overlay with chart
- [ ] Create `WorkoutSetupDialog` with all fields
- [ ] Create `CompactNumberPicker` with drag support
- [ ] Create `ModeSubSelectorDialog` for Echo/TUT
- [ ] Implement all state transitions and callbacks
- [ ] Add haptic feedback integration
- [ ] Test with 100Hz metric streaming
- [ ] Validate color scheme and typography
- [ ] Implement responsive layout for different screen sizes
- [ ] Add accessibility labels and semantic descriptions
