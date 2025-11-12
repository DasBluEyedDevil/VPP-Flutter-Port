# Just Lift Screen - Comprehensive Analysis

**Source File:** `C:\Users\dasbl\AndroidStudioProjects\VitruvianRedux\app\src\main\java\com\example\vitruvianredux\presentation\screen\JustLiftScreen.kt`

**Last Updated:** 2025-11-12

---

## Overview

The Just Lift Screen is a quick workout configuration interface that enables **auto-start** and **auto-stop** functionality for seamless workout experiences. Users select workout parameters (mode, weight, progression/regression) and the app automatically detects when they grab the handles (auto-start) and release them for 3+ seconds (auto-stop).

**Key Features:**
- Auto-start detection via handle position + velocity monitoring
- Auto-stop detection via handle rest position (3-second countdown)
- Three workout modes: Old School, Pump, Echo
- Mode-specific parameters (weight, eccentric load, progression/regression)
- Real-time workout status display
- Seamless navigation to active workout screen

---

## 1. Complete Layout Hierarchy

```
Scaffold
├─ TopAppBar
│  ├─ Title: "Just Lift"
│  └─ NavigationIcon: Back arrow (Icons.AutoMirrored.Filled.ArrowBack)
│
└─ Content (Box with gradient background)
   ├─ Column (scrollable, main content)
   │  ├─ AutoStartStopCard (unified auto-start/auto-stop indicator)
   │  ├─ Mode Selection Card (FilterChips: Old School, Pump, Echo)
   │  ├─ [Conditional: Old School / Pump]
   │  │  ├─ Weight per Cable Card (CompactNumberPicker)
   │  │  └─ Weight Change Per Rep Card (CompactNumberPicker + description)
   │  ├─ [Conditional: Echo]
   │  │  ├─ Eccentric Load Card (Slider: 0%, 50%, 75%, 100%, 125%, 150%)
   │  │  └─ Echo Level Card (FilterChips: Hard, Harder, Hardest, Epic)
   │  ├─ [Conditional: Workout Active]
   │  │  ├─ HorizontalDivider
   │  │  └─ ActiveStatusCard (reps, load, stop button)
   │
   ├─ ConnectingOverlay (if auto-connecting)
   └─ ConnectionErrorDialog (if connection error)
```

---

## 2. Every UI Element

### TopAppBar
- **Title:** Text("Just Lift")
- **NavigationIcon:** IconButton with ArrowBack icon
- **Colors:** MaterialTheme.colorScheme.surface (container), onSurface (text/icon)

### AutoStartStopCard (Unified Card for Idle/Active States)
**Displays when:** `workoutState is Idle OR Active`

**Layout:**
- Card with dynamic background color
- Icon + Title (row, centered)
- LinearProgressIndicator (when countdown active)
- Instruction text (centered)

**Icons:**
- Idle: `Icons.Default.PlayCircle` (size: 32.dp)
- Active: `Icons.Default.PanTool` (size: 32.dp)

**Titles:**
- "Starting..." (when auto-start countdown active)
- "Stopping in {X}s..." (when auto-stop countdown active)
- "Auto-Stop Ready" (when active, no countdown)
- "Auto-Start Ready" (when idle, no countdown)

**Instructions:**
- Idle: "Grab and hold handles briefly (~1s) to start"
- Active: "Put handles down for 3 seconds to stop"

**Progress Bars:**
- Auto-start: Indeterminate LinearProgressIndicator (smooth feel, ~1s hold)
- Auto-stop: Determinate LinearProgressIndicator with progress (3s countdown)
- Height: 8.dp

### Mode Selection Card
**Layout:**
- Title: "Workout Mode" (titleMedium, Bold)
- Row of FilterChips (3 modes)
- Description text (bodySmall, onSurfaceVariant)

**FilterChips:**
1. **Old School:** "Old School" + Check icon when selected
2. **Pump:** "Pump" + Check icon when selected
3. **Echo:** "Echo" + Check icon when selected

**Descriptions:**
- Old School: "Constant resistance throughout the movement."
- Pump: "Resistance increases the faster you go."
- Echo: "Adaptive resistance with echo feedback."

**Interaction:**
- Spring animation on click (scale 0.99f, dampingRatio: MediumBouncy, stiffness: 400f)
- Pressed state changes elevation (4.dp → 2.dp)

### Weight per Cable Card (Old School / Pump)
**Layout:**
- CompactNumberPicker component
- Label: "Weight per Cable"
- Suffix: "kg" or "lbs" (based on weightUnit)
- Range: 1-100 kg OR 1-220 lbs

### Weight Change Per Rep Card (Old School / Pump)
**Layout:**
- CompactNumberPicker component
- Label: "Weight Change Per Rep"
- Suffix: "kg" or "lbs"
- Range: -10 to +10 (in selected unit)
- Description: "Negative = Regression, Positive = Progression" (bodySmall, padding top: Spacing.small)

### Eccentric Load Card (Echo)
**Layout:**
- Title: "Eccentric Load: {percentage}%" (titleMedium, Bold)
- Slider with 6 discrete values (0%, 50%, 75%, 100%, 125%, 150%)
- Steps: 4 (6 values total)
- Description: "Load percentage applied during eccentric (lowering) phase" (bodySmall)

### Echo Level Card (Echo)
**Layout:**
- Title: "Echo Level" (titleMedium, Bold)
- Row of FilterChips (4 levels): Hard, Harder, Hardest, Epic
- Each chip: weight(1f), bodySmall text, maxLines=1

### ActiveStatusCard (When Workout Active)
**Layout:**
- Card with primaryContainer background
- Title: Dynamic based on workoutState
  - Countdown: "Get Ready: {X}s"
  - Active: "Workout Active"
  - Resting: "Resting: {X}s"
  - Completed: "Workout Complete"
- Reps: "Reps: {totalReps}" (bodyLarge)
- Load: "Load: {formatted weight}" (bodyMedium)
- Stop Button: "Stop Workout" (error color, Close icon + text)

### Overlays
- **ConnectingOverlay:** Shows when `isAutoConnecting = true`
  - Cancel button to abort connection
- **ConnectionErrorDialog:** Shows when `connectionError != null`
  - Displays error message
  - Dismiss button

---

## 3. All Colors

### Background
**Dark Mode Gradient (Vertical):**
- Top: `Color(0xFF0F172A)` - slate-900
- Middle: `Color(0xFF1E1B4B)` - indigo-950
- Bottom: `Color(0xFF172554)` - blue-950

**Light Mode Gradient (Vertical):**
- Top: `Color(0xFFE0E7FF)` - indigo-200 (soft lavender)
- Middle: `Color(0xFFFCE7F3)` - pink-100 (soft pink)
- Bottom: `Color(0xFFDDD6FE)` - violet-200 (soft violet)

### Card Colors
- **Standard Cards:** `MaterialTheme.colorScheme.surface`
- **AutoStartStopCard (dynamic):**
  - Auto-start countdown: `primaryContainer`
  - Auto-stop countdown: `errorContainer`
  - Active (no countdown): `surfaceVariant`
  - Idle (no countdown): `tertiaryContainer`
- **ActiveStatusCard:** `primaryContainer`

### Text Colors
- **Primary Text:** `MaterialTheme.colorScheme.onSurface`
- **Secondary Text:** `MaterialTheme.colorScheme.onSurfaceVariant`
- **AutoStartStopCard Text (dynamic):**
  - Auto-start: `onPrimaryContainer`
  - Auto-stop: `onErrorContainer`
  - Active: `onSurfaceVariant`
  - Idle: `onTertiaryContainer`
- **ActiveStatusCard Text:** `onPrimaryContainer`

### Icon Colors
- **TopBar:** `MaterialTheme.colorScheme.onSurface`
- **Mode Selection Check:** Default (follows FilterChip theme)
- **AutoStartStopCard Icon:** Matches text color (see above)

### Button Colors
- **Stop Workout Button:** `MaterialTheme.colorScheme.error` (container)

### Border Colors
- **Card Borders:** `MaterialTheme.colorScheme.outlineVariant` (1.dp)
- **AutoStartStopCard Border:**
  - Idle: `MaterialTheme.colorScheme.tertiary` (2.dp)
  - Active: `MaterialTheme.colorScheme.outline` (2.dp)

### Progress Bar Colors
- **Auto-start Progress:** `MaterialTheme.colorScheme.primary`
- **Auto-stop Progress:** `MaterialTheme.colorScheme.error`

---

## 4. Typography Details

### Title Styles
- **Screen Title (TopBar):** Default Text (Material theme)
- **Card Titles:** `MaterialTheme.typography.titleMedium`, `FontWeight.Bold`
- **AutoStartStopCard Title:** `MaterialTheme.typography.titleLarge`, `FontWeight.Bold`

### Body Styles
- **Mode Description:** `MaterialTheme.typography.bodySmall`
- **Weight Change Description:** `MaterialTheme.typography.bodySmall`
- **Eccentric Load Description:** `MaterialTheme.typography.bodySmall`
- **AutoStartStopCard Instructions:** `MaterialTheme.typography.bodyMedium`, `FontWeight.Medium`, `TextAlign.Center`
- **ActiveStatusCard Reps:** `MaterialTheme.typography.bodyLarge`
- **ActiveStatusCard Load:** `MaterialTheme.typography.bodyMedium`

### Font Sizes (Material 3 Defaults)
- **titleLarge:** 22.sp
- **titleMedium:** 16.sp
- **bodyLarge:** 16.sp
- **bodyMedium:** 14.sp
- **bodySmall:** 12.sp

### Font Weights
- **Bold:** `FontWeight.Bold` (used for all card titles)
- **Medium:** `FontWeight.Medium` (used for AutoStartStopCard instructions)
- **Normal:** Default (body text)

---

## 5. Spacing Values

### Padding
- **Content Padding:** `Spacing.large` (24.dp) - applied to main Column
- **Card Internal Padding:** `Spacing.medium` (16.dp)
- **TopBar Title Padding:** Default Material padding

### Margins / Gaps
- **Column Vertical Spacing:** `Arrangement.spacedBy(Spacing.medium)` (16.dp)
- **FilterChip Horizontal Spacing:** `Arrangement.spacedBy(Spacing.small)` (8.dp)
- **Icon-to-Text Spacing:** `Spacer(Modifier.width(Spacing.small))` (8.dp)
- **Section Internal Spacers:**
  - `Spacer(Modifier.height(Spacing.small))` (8.dp)
  - `Spacer(Modifier.height(Spacing.medium))` (16.dp)

### Card Spacing
- **Card Elevation:** 4.dp (default), 2.dp (pressed)
- **Card Corner Radius:** `RoundedCornerShape(16.dp)`
- **Card Border Width:** 1.dp (standard), 2.dp (AutoStartStopCard)

### Spacing Constants (from Spacing.kt)
```kotlin
object Spacing {
    val extraSmall = 4.dp
    val small = 8.dp       // Used heavily
    val medium = 16.dp     // Used heavily
    val large = 24.dp      // Main content padding
    val extraLarge = 32.dp
    val huge = 48.dp
}
```

---

## 6. Interaction Logic

### Auto-Start Detection Mechanism
**Entry Point:** `enableHandleDetection()` called when screen shown + connected

**Detection Flow:**
1. **BLE Manager starts monitor polling** (100Hz)
2. **Position Check:** `positionA > HANDLE_GRABBED_THRESHOLD` (8.0)
3. **Velocity Check:** `velocityA > VELOCITY_THRESHOLD` (100.0 units/s)
4. **Confirmation:** Both conditions met = handles grabbed
5. **Hold Timer:** 3-second hold countdown starts
   - Countdown displayed: 3 → 2 → 1
   - Implemented with coroutine delays (1000ms each)
6. **Auto-Start Triggered:** After 3s hold, `startWorkout(isJustLiftMode = true)`
7. **Navigation:** Automatically navigate to `ActiveWorkout` screen

**Thresholds (from VitruvianBleManager.kt):**
```kotlin
private val HANDLE_GRABBED_THRESHOLD = 8.0  // Position > 8.0 = grabbed
private val VELOCITY_THRESHOLD = 100.0      // Velocity > 100 = moving
```

### Auto-Stop Detection Mechanism
**Active During:** `workoutState is Active` AND `isJustLift = true`

**Detection Flow:**
1. **Position Check:** `positionA < HANDLE_REST_THRESHOLD` (2.5)
2. **Timer Start:** When handles at rest, 3-second countdown begins
3. **Progress Updates:** UI updated every 100ms (BLE polling rate)
   - Progress: 0.0 → 1.0 (linear)
   - SecondsRemaining: 3 → 2 → 1 → 0
4. **Auto-Stop Triggered:** After 3s at rest, `triggerAutoStop()` called
5. **Workout Completion:** Just Lift mode auto-resets to Idle (no completion screen)
6. **Re-enable Detection:** Auto-start detection re-enabled for next exercise

**Reset Conditions:**
- Handles picked up again (position > 2.5) → timer resets

**Auto-Stop Duration Constant:**
```kotlin
private const val AUTO_STOP_DURATION_SECONDS = 3f  // Official app: 3 seconds
```

### Manual Controls
**Stop Workout Button (in ActiveStatusCard):**
- Only visible when `workoutState is Active`
- Calls `viewModel.stopWorkout()`
- Red error-colored button with Close icon

### State Transitions
```
Idle → [Handles Grabbed + Hold 3s] → Countdown(3) → Active
Active → [Handles at Rest 3s] → Completed → [Auto-reset] → Idle (Just Lift)
Active → [Manual Stop] → Completed
```

**Just Lift Auto-Reset Behavior:**
- After auto-stop: Immediately return to Idle (skip Completed state)
- Re-enable handle detection
- Enable "velocity wake-up mode" for instant next-exercise detection
- User can start next set without leaving the screen

---

## 7. Animations and Transitions

### Card Press Animation
**Effect:** Scale down on press, bounce back on release

**Implementation:**
```kotlin
val modeScale by animateFloatAsState(
    targetValue = if (isModePressed) 0.99f else 1f,
    animationSpec = spring(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = 400f
    )
)
```
**Applied To:** Mode Selection Card

**Trigger:** Card `onClick` sets `isModePressed = true`, LaunchedEffect resets after 100ms

**Elevation Change:** 4.dp (default) → 2.dp (pressed)

### Progress Bar Animations
**Auto-Start Progress:**
- Type: Indeterminate LinearProgressIndicator
- Smooth, continuous animation during ~1s hold

**Auto-Stop Progress:**
- Type: Determinate LinearProgressIndicator
- Progress: 0.0 → 1.0 over 3 seconds
- Updated continuously via state flow

### Navigation Transition
**Trigger:** `workoutState` changes to `Active`

**Implementation:**
```kotlin
LaunchedEffect(workoutState) {
    if (workoutState is WorkoutState.Active) {
        navController.navigate(NavigationRoutes.ActiveWorkout.route)
    }
}
```

**No explicit animation specified** (uses default navigation transition)

### Loading States
**ConnectingOverlay:**
- Appears when `isAutoConnecting = true`
- Likely contains indeterminate progress indicator (not shown in this file)

---

## 8. Data Display Logic

### Timer Format
**Auto-Start Countdown:**
- Format: "{X}s" (e.g., "3s", "2s", "1s")
- Display: In AutoStartStopCard title: "Starting..."
- Values: 3 → 2 → 1 → null (start workout)

**Auto-Stop Countdown:**
- Format: "{X}s" (e.g., "Stopping in 3s...")
- Display: In AutoStartStopCard title
- Values: 3 → 2 → 1 → 0 (stop workout)

**Resting Timer (if used in ActiveStatusCard):**
- Format: "{X}s" (e.g., "Resting: 60s")
- Display: In status title

### Metrics Displayed

#### Just Lift Configuration (Before Start)
- **Weight per Cable:** Displayed in kg or lbs (converted 2.20462 ratio)
- **Weight Change Per Rep:** -10 to +10 in selected unit
- **Eccentric Load:** 0%, 50%, 75%, 100%, 125%, 150%
- **Echo Level:** Hard, Harder, Hardest, Epic

#### Real-Time Workout (ActiveStatusCard)
- **Reps:** `repCount.totalReps` (integer, no decimals)
- **Load:** Formatted via `viewModel.formatWeight(metric.totalLoad, weightUnit)`
  - Format: Likely "{value} {unit}" (e.g., "50.0 kg")

### Units of Measurement
- **Weight Unit:** kg or lbs (user preference)
- **Conversion Ratio:** 1 kg = 2.20462 lbs
- **Position:** Raw units (threshold: 8.0 grabbed, 2.5 at rest)
- **Velocity:** Raw units (threshold: 100.0)

### Workout Summary Format
**Not displayed on Just Lift screen** - Just Lift auto-resets to Idle after auto-stop, bypassing the completion summary screen.

**Completion Data Still Saved:**
- Session saved to database
- Metrics collected during workout
- Available in workout history

---

## 9. State Management

### ViewModel Integration
**ViewModel:** `MainViewModel` (passed as parameter)

**State Flows Collected:**
```kotlin
val workoutState by viewModel.workoutState.collectAsState()
val workoutParameters by viewModel.workoutParameters.collectAsState()
val currentMetric by viewModel.currentMetric.collectAsState()
val repCount by viewModel.repCount.collectAsState()
val autoStopState by viewModel.autoStopState.collectAsState()
val weightUnit by viewModel.weightUnit.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()
val connectionState by viewModel.connectionState.collectAsState()
val autoStartCountdown by viewModel.autoStartCountdown.collectAsState()
```

### State Classes

#### WorkoutState (sealed class)
```kotlin
sealed class WorkoutState {
    object Idle
    object Initializing
    data class Countdown(val secondsRemaining: Int)
    object Active
    data class SetSummary(...)
    object Paused
    object Completed
    data class Error(val message: String)
    data class Resting(
        val restSecondsRemaining: Int,
        val nextExerciseName: String,
        val isLastExercise: Boolean,
        val currentSet: Int,
        val totalSets: Int
    )
}
```

#### AutoStopUiState (data class)
```kotlin
data class AutoStopUiState(
    val isActive: Boolean = false,
    val progress: Float = 0f,
    val secondsRemaining: Int = 3
)
```

#### WorkoutParameters (data class)
```kotlin
data class WorkoutParameters(
    val workoutType: WorkoutType,
    val reps: Int,
    val weightPerCableKg: Float = 0f,
    val progressionRegressionKg: Float = 0f,
    val isJustLift: Boolean = false,
    val useAutoStart: Boolean = false,
    val stopAtTop: Boolean = false,
    val warmupReps: Int = 3,
    val selectedExerciseId: String? = null
)
```

#### RepCount (data class)
```kotlin
data class RepCount(
    val warmupReps: Int = 0,
    val workingReps: Int = 0,
    val totalReps: Int = workingReps,
    val isWarmupComplete: Boolean = false
)
```

### Event Handling

#### LaunchedEffects (Side Effects)
1. **EccentricLoad Sync (lines 59-65):**
   - Syncs local eccentricLoad/echoLevel state when workoutParameters.workoutType changes

2. **Navigation on Active (lines 67-71):**
   - Navigates to ActiveWorkout screen when workoutState becomes Active

3. **Enable Handle Detection on Connect (lines 74-79):**
   - Enables handle detection when connectionState becomes Connected

4. **Reset State on Entry (lines 82-87):**
   - Calls `prepareForJustLift()` if entering screen with non-Idle/non-Active state

5. **Update Parameters (lines 89-104):**
   - Updates workoutParameters in ViewModel whenever selectedMode, weightPerCable, weightChangePerRep, or restTime changes
   - Sets `isJustLift = true` and `useAutoStart = true`

#### ViewModel Methods Called
- `viewModel.enableHandleDetection()` - Start monitor polling
- `viewModel.prepareForJustLift()` - Reset to Idle if needed
- `viewModel.updateWorkoutParameters(params)` - Update workout config
- `viewModel.stopWorkout()` - Manual stop button
- `viewModel.cancelAutoConnecting()` - Cancel connection attempt
- `viewModel.clearConnectionError()` - Dismiss error dialog

### Local State (remember)
```kotlin
var selectedMode by remember { mutableStateOf(...) }
var weightPerCable by remember { mutableStateOf(...) }
var weightChangePerRep by remember { mutableStateOf(...) }
var restTime by remember { mutableStateOf(60) }
var eccentricLoad by remember { mutableStateOf(EccentricLoad.LOAD_100) }
var echoLevel by remember { mutableStateOf(EchoLevel.HARDER) }
var isModePressed by remember { mutableStateOf(false) }
```

---

## 10. Auto-Detection Details

### Handle Position Thresholds
**Defined in:** `VitruvianBleManager.kt`

```kotlin
private val HANDLE_GRABBED_THRESHOLD = 8.0  // Position > 8.0 = handles grabbed
private val HANDLE_REST_THRESHOLD = 2.5     // Position < 2.5 = handles at rest
private val VELOCITY_THRESHOLD = 100.0      // Velocity > 100 units/s = significant movement
```

**Position Range Observed in Testing:**
- Min Position: ~0.0 (fully extended/at rest)
- Max Position: ~60-80 (fully contracted/pulled)
- Grabbed Detection: > 8.0 (very low threshold - early detection)
- Rest Detection: < 2.5 (very low threshold - only at full rest)

### Polling Frequency
**BLE Polling Rate:** 100Hz (every 10ms)
- Defined in `VitruvianBleManager` as monitor polling interval
- Matches official Vitruvian app protocol

### Detection Algorithms

#### Auto-Start Algorithm (Handle Grabbed)
```
1. Monitor BLE data at 100Hz
2. For each data frame:
   a. Check positionA > HANDLE_GRABBED_THRESHOLD (8.0)
   b. Check velocityA > VELOCITY_THRESHOLD (100.0)
   c. If BOTH true: Handles confirmed grabbed
3. Start 3-second hold timer
4. If timer completes: Start workout
5. If handles released before 3s: Cancel timer
```

**Handle State Machine (from BLE Manager):**
```
Released/Moving → [pos > 8.0 AND vel > 100] → Grabbed
Grabbed → [3s hold] → Auto-Start Triggered
```

#### Auto-Stop Algorithm (Handle at Rest)
```
1. Monitor BLE data at 100Hz (during active workout)
2. For each data frame:
   a. Check positionA < HANDLE_REST_THRESHOLD (2.5)
   b. If true: Start/continue 3-second countdown
   c. If false: Reset countdown
3. Update UI progress: (elapsed / 3.0) and remaining seconds
4. If countdown reaches 3.0s: Trigger auto-stop
5. Auto-reset to Idle for next exercise
```

**Progress Calculation:**
```kotlin
val elapsed = (System.currentTimeMillis() - startTime) / 1000f
val progress = (elapsed / 3f).coerceIn(0f, 1f)
val remaining = (3f - elapsed).coerceAtLeast(0f)
```

### Debounce / Delay Mechanisms

#### Auto-Start Debounce
**Hold Duration:** 3 seconds (visible countdown: 3 → 2 → 1)
- Implemented with coroutine delays (1000ms each)
- Prevents accidental starts from brief handle touches
- User receives clear visual feedback (countdown display)

**Implementation:**
```kotlin
_autoStartCountdown.value = 3
delay(1000)
_autoStartCountdown.value = 2
delay(1000)
_autoStartCountdown.value = 1
delay(1000)
_autoStartCountdown.value = null
startWorkout(isJustLiftMode = true)
```

#### Auto-Stop Debounce
**Rest Duration:** 3 seconds (with progress bar)
- Continuous tracking of elapsed time
- UI updated every frame (100Hz BLE data)
- Resets immediately if handles picked up

**No hysteresis on position** - single threshold for rest detection (2.5)

### Velocity-Based Wake-Up (Post-Workout)
**Feature:** "Just Lift Waiting Mode"
- Enabled after auto-stop completes
- Uses velocity threshold to detect next exercise start
- Allows faster detection than position-only method
- User can immediately start next set without manual reset

**Call:** `bleRepository.enableJustLiftWaitingMode()`

---

## 11. Navigation

### Entry to Just Lift
**From:** Main menu / Home screen
**Route:** `NavigationRoutes.JustLift.route` (exact route not shown in this file)

**Entry Side Effects:**
1. Check if connected → Enable handle detection
2. Check workoutState → Reset to Idle if non-Idle/non-Active

### Exit from Just Lift
**Back Button (TopBar):**
- Calls `navController.navigateUp()`
- Returns to previous screen

**Auto-Navigation on Workout Start:**
- When `workoutState` becomes `Active`
- Navigates to: `NavigationRoutes.ActiveWorkout.route`
- Implemented via LaunchedEffect observer

### Navigation to Summary
**Just Lift Mode Behavior:**
- Does NOT navigate to summary/completion screen
- Auto-resets to Idle state after auto-stop
- User remains on Just Lift screen for immediate next set

**Regular Workout Behavior (for comparison):**
- Navigates to workout summary after completion

### Back Button Behavior
**During Configuration (Idle):**
- Standard back navigation (navigateUp)

**During Workout (Active):**
- Back button press would return to Just Lift screen (based on navigation structure)
- Workout continues in background
- ActiveStatusCard displays on Just Lift screen

**No Special Handling:** No back press override in this screen

---

## 12. Connection Requirements

### BLE Connection Checks
**Connection State Flow:**
```kotlin
val connectionState by viewModel.connectionState.collectAsState()
```

**Required State:** `ConnectionState.Connected`

**Connected State Structure:**
```kotlin
data class Connected(
    val deviceName: String,
    val deviceAddress: String,
    val hardwareModel: VitruvianModel
) : ConnectionState()
```

### Connection-Dependent Features
**Handle Detection:**
- Only enabled when `connectionState is Connected`
- LaunchedEffect triggers `enableHandleDetection()` on connect

**Auto-Start:**
- Requires active BLE connection
- Requires monitor polling to be active (100Hz)

**Parameter Updates:**
- Can configure parameters while disconnected
- Parameters sent to device when workout starts

### Monitor Mode Requirements
**Monitor Polling:**
- Must be active for auto-start detection
- Started by `enableHandleDetection()` → `startMonitorPolling()`
- Polls at 100Hz (10ms intervals)

**Characteristic:**
- Uses standard Vitruvian monitor characteristic (UUID not shown in this file)
- Reads 16-byte data frame: loadA, loadB, positionA, positionB, ticks, velocityA

### Error States

#### Connection Error
**Display:** `ConnectionErrorDialog`
```kotlin
connectionError?.let { error ->
    ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

**Error Types (from ConnectionState):**
```kotlin
data class Error(val message: String, val throwable: Throwable? = null)
```

**Common Errors:**
- BLE adapter not enabled
- Device not found
- Connection timeout (15s)
- Disconnection during workout
- Characteristic read/write failures

#### Auto-Connecting State
**Display:** `ConnectingOverlay`
```kotlin
if (isAutoConnecting) {
    ConnectingOverlay(
        onCancel = { viewModel.cancelAutoConnecting() }
    )
}
```

**Purpose:** Indicates automatic connection attempt in progress

**User Action:** Can cancel via overlay button

### No Connection Fallback
**Configuration:**
- User can configure workout parameters while disconnected
- Parameters stored in local state

**Auto-Start:**
- Disabled if not connected
- AutoStartStopCard not shown if disconnected (card only shows when Idle or Active)

**Workout Start:**
- Cannot start workout without connection
- Start button (if present elsewhere) would be disabled

---

## Additional Implementation Notes

### CompactNumberPicker Component
**Not defined in this file** - Custom component used for weight selection

**Usage Pattern:**
```kotlin
CompactNumberPicker(
    value: Int,
    onValueChange: (Int) -> Unit,
    range: IntRange,
    label: String,
    suffix: String,
    modifier: Modifier
)
```

### Weight Unit Conversion
**Conversion Factor:** 1 kg = 2.20462 lbs

**Display Conversion (kg → lbs):**
```kotlin
val displayWeight = (weightPerCable * 2.20462f).toInt()
```

**Storage Conversion (lbs → kg):**
```kotlin
weightPerCable = newValue / 2.20462f
```

**Storage Format:** Always stored in kg internally

### Workout Parameters Update Behavior
**Trigger:** Any parameter change (mode, weight, progression, rest)

**Implementation:**
```kotlin
LaunchedEffect(selectedMode, weightPerCable, weightChangePerRep, restTime) {
    val weightChangeKg = if (weightUnit == WeightUnit.LB) {
        weightChangePerRep / 2.20462f
    } else {
        weightChangePerRep.toFloat()
    }

    val updatedParameters = workoutParameters.copy(
        workoutType = selectedMode.toWorkoutType(eccentricLoad),
        weightPerCableKg = weightPerCable,
        progressionRegressionKg = weightChangeKg,
        isJustLift = true,
        useAutoStart = true
    )
    viewModel.updateWorkoutParameters(updatedParameters)
}
```

**Key Flags:**
- `isJustLift = true` - Always true for this screen
- `useAutoStart = true` - Enables auto-start detection

### Theme Mode Support
**Parameter:** `themeMode: ThemeMode` (passed to composable)

**Usage:** Determines background gradient colors (dark vs light)

**Theme Values:**
- `ThemeMode.DARK` → Dark gradient
- `ThemeMode.LIGHT` → Light gradient

---

## State Flow Diagram

```
┌─────────────────────────────────────────────────────────┐
│                  JUST LIFT SCREEN                       │
│                      (Idle State)                        │
│                                                         │
│  ┌────────────────────────────────────────────────┐  │
│  │   AutoStartStopCard: "Auto-Start Ready"       │  │
│  │   Instruction: Grab and hold handles ~1s       │  │
│  └────────────────────────────────────────────────┘  │
│                                                         │
│  [Configure: Mode, Weight, Progression]                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Handles Grabbed + Velocity > 100
                          ▼
┌─────────────────────────────────────────────────────────┐
│              AutoStartStopCard: "Starting..."           │
│              Countdown: 3 → 2 → 1                       │
│              [Progress Bar: Indeterminate]              │
└─────────────────────────────────────────────────────────┘
                          │
                          │ After 3 seconds
                          ▼
┌─────────────────────────────────────────────────────────┐
│          NAVIGATE TO: ActiveWorkout Screen              │
│                    (Workout Active)                     │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Handles at Rest (pos < 2.5)
                          ▼
┌─────────────────────────────────────────────────────────┐
│            AutoStopCard: "Stopping in 3s..."            │
│            Progress: 0% → 100% over 3 seconds           │
│            [Linear Progress Bar]                        │
└─────────────────────────────────────────────────────────┘
                          │
                          │ After 3 seconds
                          ▼
┌─────────────────────────────────────────────────────────┐
│               Workout Auto-Stopped                      │
│               Save Session to Database                  │
│               Reset to Idle (No Summary)                │
│               Re-enable Handle Detection                │
│               Enable Velocity Wake-Up Mode              │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Back to Idle
                          ▼
                   [Ready for Next Set]
```

---

## Flutter Implementation Checklist

### UI Components to Port
- [ ] Scaffold with gradient background
- [ ] TopAppBar with back navigation
- [ ] AutoStartStopCard (unified idle/active card)
- [ ] Mode Selection Card with FilterChips
- [ ] Weight per Cable picker (conditional: Old School/Pump)
- [ ] Weight Change Per Rep picker (conditional: Old School/Pump)
- [ ] Eccentric Load slider (conditional: Echo)
- [ ] Echo Level chips (conditional: Echo)
- [ ] ActiveStatusCard (conditional: workout active)
- [ ] ConnectingOverlay
- [ ] ConnectionErrorDialog
- [ ] Card press animation (scale + spring)

### State Management (Riverpod)
- [ ] WorkoutStateNotifier (replaces ViewModel)
- [ ] WorkoutState sealed class (use freezed)
- [ ] AutoStopUiState data class
- [ ] WorkoutParameters provider
- [ ] ConnectionState provider
- [ ] Auto-start countdown provider
- [ ] Auto-stop state provider
- [ ] Weight unit preference provider

### BLE Integration
- [ ] Handle detection enable/disable
- [ ] Monitor polling at 100Hz
- [ ] Position threshold checks (8.0 grabbed, 2.5 rest)
- [ ] Velocity threshold check (100.0)
- [ ] Auto-start timer (3s hold)
- [ ] Auto-stop timer (3s rest)
- [ ] Velocity wake-up mode

### Business Logic
- [ ] Auto-start detection algorithm
- [ ] Auto-stop detection algorithm
- [ ] Weight unit conversion (kg ↔ lbs)
- [ ] Parameter validation
- [ ] Just Lift auto-reset behavior
- [ ] Handle state machine

### Navigation
- [ ] Navigate to ActiveWorkout on workout start
- [ ] Back navigation to previous screen
- [ ] No navigation to summary (Just Lift behavior)

### Testing Requirements
- [ ] Unit tests: Auto-start/stop logic
- [ ] Widget tests: UI components
- [ ] Integration tests: BLE detection (requires hardware)
- [ ] Unit tests: Weight conversion
- [ ] Unit tests: State transitions

---

## Critical Implementation Details

### Must Preserve Exactly
1. **Auto-Start Threshold:** Position > 8.0 AND Velocity > 100.0
2. **Auto-Stop Threshold:** Position < 2.5 for 3 seconds
3. **Hold Duration:** 3 seconds for both auto-start and auto-stop
4. **BLE Polling Rate:** 100Hz (10ms intervals)
5. **Weight Conversion:** 1 kg = 2.20462 lbs (exact ratio)
6. **Just Lift Flags:** `isJustLift = true`, `useAutoStart = true`
7. **Auto-Reset Behavior:** Return to Idle after auto-stop (no summary screen)

### Flutter/Dart Equivalents
- `collectAsState()` → Riverpod `watch()` or `ref.watch()`
- `LaunchedEffect` → `useEffect()` hook or `ref.listen()`
- `remember` → `useState()` hook
- `animateFloatAsState` → `AnimationController` or `TweenAnimationBuilder`
- `Spacer` → `SizedBox`
- `Modifier.fillMaxWidth()` → `Container(width: double.infinity)`
- `RoundedCornerShape(16.dp)` → `BorderRadius.circular(16)`

### Performance Considerations
1. **BLE Stream:** Use StreamProvider for 100Hz data stream
2. **UI Updates:** Throttle UI updates to 60fps (not 100Hz)
3. **State Updates:** Batch state updates when possible
4. **Memory:** Properly dispose stream subscriptions
5. **Navigation:** Use named routes for clean navigation

---

**End of Analysis**
