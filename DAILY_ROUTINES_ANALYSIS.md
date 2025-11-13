# Daily Routines Screen - Comprehensive Analysis

**Source File:** `C:\Users\dasbl\AndroidStudioProjects\VitruvianRedux\app\src\main\java\com\example\vitruvianredux\presentation\screen\DailyRoutinesScreen.kt`

**Supporting Files:**
- `RoutinesTab.kt` - Main tab content with routine list
- `RoutineBuilderDialog.kt` - Create/edit routine dialog
- `RoutineCard` composable - Individual routine card
- `ExerciseListItem` composable - Exercise item in builder

**Analysis Date:** 2025-11-12

---

## 1. Overview

The Daily Routines Screen is a **wrapper screen** that provides a dedicated route for viewing and managing workout routines. The actual functionality is implemented in the reusable `RoutinesTab` composable, which is also used in the main tabbed interface.

**Key Features:**
- View all saved workout routines
- Create new routines with multiple exercises
- Edit existing routines
- Duplicate routines (smart naming: "Copy", "Copy 2", etc.)
- Delete routines
- Start workouts from routines
- Configure exercises with sets, reps, weight, rest time
- Reorder exercises within routines
- Empty state for first-time users

---

## 2. Architecture & Data Flow

### State Management

**ViewModel:** `MainViewModel` (shared across app)

**StateFlows (collected in screen):**
```kotlin
val routines by viewModel.routines.collectAsState()
val weightUnit by viewModel.weightUnit.collectAsState()
val enableVideoPlayback by viewModel.enableVideoPlayback.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()
```

**State Properties:**
- `routines: List<Routine>` - All saved workout routines
- `weightUnit: WeightUnit` - User's preferred unit (LB/KG)
- `enableVideoPlayback: Boolean` - Video setting for exercise library
- `isAutoConnecting: Boolean` - BLE connection in progress
- `connectionError: String?` - Connection error message

### ViewModel Actions

```kotlin
// Routine management
viewModel.loadRoutine(routine: Routine)
viewModel.saveRoutine(routine: Routine)
viewModel.updateRoutine(routine: Routine)
viewModel.deleteRoutine(routineId: String)

// Workout control
viewModel.startWorkout()
viewModel.ensureConnection(onConnected, onFailed)

// Connection management
viewModel.cancelAutoConnecting()
viewModel.clearConnectionError()

// Utility functions
viewModel.formatWeight(weight: Float, unit: WeightUnit): String
viewModel.kgToDisplay(kg: Float, unit: WeightUnit): Float
viewModel.displayToKg(display: Float, unit: WeightUnit): Float
```

### Domain Models

**Routine:**
```kotlin
data class Routine(
    val id: String,                     // UUID
    val name: String,                   // Routine name
    val description: String = "",       // Optional description
    val exercises: List<RoutineExercise>,
    val createdAt: Long,                // Timestamp
    val lastUsed: Long? = null,         // Last workout timestamp
    val useCount: Int = 0               // Times used
)
```

**RoutineExercise:**
```kotlin
data class RoutineExercise(
    val id: String,                     // UUID
    val exercise: Exercise,             // Exercise reference
    val cableConfig: CableConfiguration, // SINGLE or DOUBLE
    val orderIndex: Int,                // Position in routine
    val setReps: List<Int>,             // Reps per set [10,10,10]
    val weightPerCableKg: Float,        // Default weight per cable
    val setWeightsPerCableKg: List<Float>, // Per-set weights (optional)
    val workoutType: WorkoutType,       // Program/Echo mode
    val progressionKg: Float,           // Weight progression per rep
    val restSeconds: Int,               // Rest between sets
    val notes: String,                  // Exercise notes
    val eccentricLoad: EccentricLoad,   // Eccentric load setting
    val echoLevel: EchoLevel            // Echo difficulty
)
```

---

## 3. Screen Structure

### DailyRoutinesScreen (Wrapper)

**Layout Hierarchy:**
```
Scaffold
├── TopAppBar
│   ├── NavigationIcon (Back arrow)
│   └── Title ("Daily Routines")
└── Content (with padding)
    ├── Box (Gradient background)
    │   └── RoutinesTab (Main content)
    ├── ConnectingOverlay (conditional)
    └── ConnectionErrorDialog (conditional)
```

**Gradient Background:**
```kotlin
// Dark theme
Color(0xFF0F172A) // slate-900
Color(0xFF1E1B4B) // indigo-950
Color(0xFF172554) // blue-950

// Light theme
Color(0xFFE0E7FF) // indigo-200 (soft lavender)
Color(0xFFFCE7F3) // pink-100 (soft pink)
Color(0xFFDDD6FE) // violet-200 (soft violet)
```

**Theme Logic:**
- Respects `ThemeMode` (SYSTEM/LIGHT/DARK)
- Uses `isSystemInDarkTheme()` for SYSTEM mode
- Applies consistent gradients across app

---

## 4. RoutinesTab Component

### Layout Structure

```
Box (Gradient background)
├── Column (Main content)
│   ├── Text ("My Routines" header)
│   ├── Spacer (16dp)
│   └── [Conditional content]
│       ├── EmptyState (if no routines)
│       └── LazyColumn (if routines exist)
│           └── RoutineCard items
└── ExtendedFloatingActionButton ("New Routine")
```

### Empty State

**Component:** `EmptyState` (reusable component)

**Properties:**
```kotlin
icon = Icons.Default.FitnessCenter
title = "No Routines Yet"
message = "Create your first workout routine to get started"
actionText = "Create Your First Routine"
onAction = { showRoutineBuilder = true }
```

### LazyColumn

**List Configuration:**
```kotlin
LazyColumn(
    verticalArrangement = Arrangement.spacedBy(Spacing.small)
) {
    items(routines, key = { it.id }) { routine ->
        RoutineCard(...)
    }
}
```

**Key Features:**
- Stable keys for performance (`key = { it.id }`)
- Consistent spacing between items
- Supports reordering/updates efficiently

### Floating Action Button

**Type:** `ExtendedFloatingActionButton`

**Design:**
```kotlin
containerColor = MaterialTheme.colorScheme.primary
contentColor = MaterialTheme.colorScheme.onPrimary
position = BottomEnd
padding = Spacing.medium (16dp)
```

**Content:**
- Add icon (Icons.Default.Add)
- Text: "New Routine"
- Opens RoutineBuilderDialog on click

---

## 5. RoutineCard Component

### Visual Design

**Card Specifications:**
```kotlin
Card(
    shape = RoundedCornerShape(16.dp)
    elevation = 4.dp (default), 2.dp (pressed)
    backgroundColor = MaterialTheme.colorScheme.surface
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
)
```

**Animation:**
```kotlin
// Press animation
val scale by animateFloatAsState(
    targetValue = if (isPressed) 0.99f else 1f,
    animationSpec = spring(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = 400f
    )
)
```

### Layout Structure

```
Card (onClick = onStartWorkout)
├── Row (padding 16dp, spacing 16dp)
│   ├── Box (64dp gradient icon)
│   │   └── Icon (FitnessCenter, 32dp)
│   ├── Column (weight 1f)
│   │   ├── Text (routine.name) - titleMedium, Bold
│   │   ├── Text (description or exercise count) - bodySmall
│   │   ├── Column (exercise preview)
│   │   │   ├── Text (first 4 exercises with set/rep)
│   │   │   └── Text ("+ N more") - if more than 4
│   │   └── Text (exercise count • duration) - bodySmall, primary
│   └── Surface (36dp arrow icon)
│       └── Icon (ArrowForward)
└── Box (Overlay - top right)
    └── IconButton (MoreVert) + DropdownMenu
        ├── Edit
        ├── Duplicate
        └── Delete
```

### Icon Gradient

**64dp Icon Box:**
```kotlin
Box(
    size = 64.dp,
    shape = RoundedCornerShape(12.dp),
    shadow = 4.dp,
    background = Brush.linearGradient(
        colors = listOf(
            Color(0xFF9333EA), // purple-600
            Color(0xFF7E22CE)  // purple-700
        )
    )
)
```

### Exercise Preview

**Logic:**
- Shows first 4 exercises
- Each shows: "Exercise Name - Sets×Reps"
- Format: "3×10, 2×8" (groups consecutive identical reps)
- If more than 4: shows "+ N more" in primary color

**Example:**
```
Bench Press - 3×10
Squat - 4×8
Rows - 3×10, 2×8
+ 2 more
```

### Set/Rep Formatting

**Algorithm:**
```kotlin
private fun formatSetReps(setReps: List<Int>): String {
    // Groups consecutive identical reps
    // [10,10,10,8,8] -> "3×10, 2×8"

    val groups = mutableListOf<Pair<Int, Int>>()
    var currentReps = setReps[0]
    var currentCount = 1

    for (i in 1 until setReps.size) {
        if (setReps[i] == currentReps) {
            currentCount++
        } else {
            groups.add(Pair(currentCount, currentReps))
            currentReps = setReps[i]
            currentCount = 1
        }
    }
    groups.add(Pair(currentCount, currentReps))

    return groups.joinToString(", ") { (count, reps) -> "${count}×${reps}" }
}
```

### Duration Estimation

**Algorithm:**
```kotlin
private fun formatEstimatedDuration(routine: Routine): String {
    val totalSets = routine.exercises.sumOf { it.setReps.size }
    val totalReps = routine.exercises.sumOf { it.setReps.sum() }
    val totalRestSeconds = routine.exercises.sumOf {
        it.restSeconds * (it.setReps.size - 1)
    }

    // 3 seconds per rep + rest time
    val estimatedSeconds = (totalReps * 3) + totalRestSeconds
    val minutes = estimatedSeconds / 60

    return if (minutes < 60) {
        "$minutes min"
    } else {
        val hours = minutes / 60
        val remainingMinutes = minutes % 60
        "${hours}h ${remainingMinutes}m"
    }
}
```

**Estimate:** 3 seconds per rep + configured rest time between sets

### Dropdown Menu

**Menu Items:**
```kotlin
DropdownMenu {
    DropdownMenuItem(
        text = "Edit",
        icon = Icons.Default.Edit,
        onClick = onEdit
    )
    DropdownMenuItem(
        text = "Duplicate",
        icon = Icons.Default.ContentCopy,
        onClick = onDuplicate
    )
    DropdownMenuItem(
        text = "Delete",
        icon = Icons.Default.Delete (error color),
        onClick = onDelete
    )
}
```

### Duplicate Logic (Smart Naming)

**Algorithm:**
```kotlin
// Extract base name (remove " (Copy)" or " (Copy N)")
val baseName = routine.name.replace(Regex(""" \(Copy( \d+)?\)$"""), "")

// Find all existing copy numbers
val copyPattern = Regex("""^${Regex.escape(baseName)} \(Copy( (\d+))?\)$""")
val existingCopyNumbers = routines.mapNotNull { r ->
    when {
        r.name == baseName -> 0          // Original
        r.name == "$baseName (Copy)" -> 1 // First copy
        else -> copyPattern.find(r.name)?.groups?.get(2)?.value?.toIntOrNull()
    }
}

// Generate next copy number
val nextCopyNumber = (existingCopyNumbers.maxOrNull() ?: 0) + 1
val newName = if (nextCopyNumber == 1) {
    "$baseName (Copy)"
} else {
    "$baseName (Copy $nextCopyNumber)"
}
```

**Example Sequence:**
```
"Push Day" -> "Push Day (Copy)" -> "Push Day (Copy 2)" -> "Push Day (Copy 3)"
```

**Deep Copy Logic:**
```kotlin
// Generate new IDs for all entities
val newRoutineId = UUID.randomUUID().toString()
val newExercises = routine.exercises.map { exercise ->
    exercise.copy(
        id = UUID.randomUUID().toString(),
        exercise = exercise.exercise.copy() // Deep copy Exercise
    )
}

// Reset usage stats
val duplicated = routine.copy(
    id = newRoutineId,
    name = newName,
    createdAt = System.currentTimeMillis(),
    useCount = 0,
    lastUsed = null,
    exercises = newExercises
)
```

---

## 6. RoutineBuilderDialog Component

### Dialog Specifications

```kotlin
Dialog(onDismissRequest = onDismiss)
└── Surface
    ├── modifier = fillMaxWidth(), fillMaxHeight(0.9f)
    ├── shape = RoundedCornerShape(16.dp)
    └── background = Gradient (theme-dependent)
```

**Occupies 90% of screen height** for full-screen-like experience.

### Layout Structure

```
Surface (90% height)
└── Box (Gradient background)
    └── Column (padding: Spacing.medium)
        ├── Row (Header)
        │   ├── Text ("Create/Edit Routine")
        │   └── IconButton (Close)
        ├── Column (Scrollable content, weight 1f)
        │   ├── OutlinedTextField (Routine Name) *
        │   ├── [Error text if validation fails]
        │   ├── OutlinedTextField (Description, 100dp, 4 lines)
        │   ├── Text ("Exercises" header + count)
        │   ├── [Error text if no exercises]
        │   ├── [Conditional content]
        │   │   ├── Card (Empty state) - if no exercises
        │   │   └── Column (ExerciseListItem cards) - if exercises exist
        │   └── OutlinedButton ("Add Exercise")
        └── Row (Action buttons)
            ├── OutlinedButton ("Cancel", weight 1f)
            └── Button ("Save", weight 1f, 56dp height)
```

### State Management

**Local State:**
```kotlin
var name by remember { mutableStateOf(routine?.name ?: "") }
var description by remember { mutableStateOf(routine?.description ?: "") }
var exercises by remember { mutableStateOf(routine?.exercises ?: emptyList()) }
var showError by remember { mutableStateOf(false) }
var showExercisePicker by remember { mutableStateOf(false) }
var exerciseToEdit by remember { mutableStateOf<Pair<Int, RoutineExercise>?>(null) }
```

### Form Fields

**Routine Name:**
```kotlin
OutlinedTextField(
    value = name,
    label = "Routine Name *",
    singleLine = true,
    isError = showError && name.isBlank(),
    modifier = Modifier.fillMaxWidth()
)
```

**Description:**
```kotlin
OutlinedTextField(
    value = description,
    label = "Description (optional)",
    maxLines = 4,
    height = 100.dp,
    modifier = Modifier.fillMaxWidth()
)
```

### Validation

**Required Fields:**
1. `name.isNotBlank()` - Routine name required
2. `exercises.isNotEmpty()` - At least one exercise required

**Error Display:**
```kotlin
if (showError && name.isBlank()) {
    Text(
        "Routine name is required",
        color = MaterialTheme.colorScheme.error,
        style = MaterialTheme.typography.bodySmall,
        modifier = Modifier.padding(start: Spacing.medium, top: Spacing.extraSmall)
    )
}
```

### Exercise List Empty State

```kotlin
if (exercises.isEmpty()) {
    Card(
        containerColor = surface,
        shape = RoundedCornerShape(16.dp),
        elevation = 4.dp,
        border = BorderStroke(1.dp, Color(0xFFF5F3FF))
    ) {
        Box(padding = Spacing.large, alignment = Center) {
            Text(
                "No exercises added yet",
                color = onSurfaceVariant,
                style = bodyMedium
            )
        }
    }
}
```

### Add Exercise Button

```kotlin
OutlinedButton(
    onClick = { showExercisePicker = true },
    modifier = Modifier.fillMaxWidth(),
    colors = outlinedButtonColors(contentColor = primary),
    shape = RoundedCornerShape(12.dp)
) {
    Icon(Icons.Default.Add, "Add exercise")
    Spacer(width = Spacing.small)
    Text("Add Exercise")
}
```

### Action Buttons

**Cancel Button:**
```kotlin
OutlinedButton(
    onClick = onDismiss,
    modifier = Modifier.weight(1f),
    colors = outlinedButtonColors(contentColor = onSurfaceVariant)
) {
    Text("Cancel")
}
```

**Save Button:**
```kotlin
Button(
    onClick = { /* validation + save */ },
    modifier = Modifier.weight(1f).height(56dp),
    colors = buttonColors(containerColor = primary),
    shape = RoundedCornerShape(16.dp)
) {
    Text("Save", style = titleSmall, fontWeight = Bold)
}
```

### Save Logic

```kotlin
onClick = {
    if (name.isBlank() || exercises.isEmpty()) {
        showError = true
    } else {
        val newRoutine = Routine(
            id = routine?.id ?: UUID.randomUUID().toString(),
            name = name.trim(),
            description = description.trim(),
            exercises = exercises,
            createdAt = routine?.createdAt ?: System.currentTimeMillis(),
            lastUsed = routine?.lastUsed,
            useCount = routine?.useCount ?: 0
        )

        if (routineToEdit != null) {
            onUpdateRoutine(newRoutine)
        } else {
            onSaveRoutine(newRoutine)
        }
    }
}
```

### Exercise Picker Integration

```kotlin
if (showExercisePicker) {
    ExercisePickerDialog(
        showDialog = true,
        onDismiss = { showExercisePicker = false },
        onExerciseSelected = { selectedExercise ->
            // Create Exercise from selected library exercise
            val exercise = Exercise(
                name = selectedExercise.name,
                muscleGroup = selectedExercise.muscleGroups.split(",").first().trim(),
                equipment = selectedExercise.equipment.split(",").first().trim(),
                defaultCableConfig = CableConfiguration.DOUBLE,
                id = selectedExercise.id
            )

            // Create RoutineExercise with defaults
            val newRoutineExercise = RoutineExercise(
                id = UUID.randomUUID().toString(),
                exercise = exercise,
                cableConfig = exercise.resolveDefaultCableConfig(),
                orderIndex = exercises.size,
                setReps = listOf(10, 10, 10),      // Default: 3×10
                weightPerCableKg = 20f,             // Default: 20kg
                progressionKg = 0f,                 // No progression
                restSeconds = 60,                   // 60s rest
                notes = "",
                workoutType = WorkoutType.Program(ProgramMode.OldSchool),
                eccentricLoad = EccentricLoad.LOAD_100,
                echoLevel = EchoLevel.HARDER
            )

            // Open ExerciseEditBottomSheet for configuration
            exerciseToEdit = Pair(exercises.size, newRoutineExercise)
            showExercisePicker = false
        },
        exerciseRepository = exerciseRepository,
        enableVideoPlayback = enableVideoPlayback
    )
}
```

**Flow:** Pick exercise → Configure in bottom sheet → Add to list

---

## 7. ExerciseListItem Component

### Card Design

```kotlin
Card(
    modifier = fillMaxWidth().scale(scale),
    colors = cardColors(containerColor = surface),
    shape = RoundedCornerShape(16.dp),
    elevation = 4.dp,
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
)
```

**Animation:** Same press animation as RoutineCard (0.99f scale)

### Layout Structure

```
Card
└── Row (padding: Spacing.medium, spacing: Spacing.small)
    ├── Column (Reorder buttons)
    │   ├── IconButton (KeyboardArrowUp, 32dp)
    │   └── IconButton (KeyboardArrowDown, 32dp)
    ├── Column (Exercise info, weight 1f)
    │   ├── Text (exercise.displayName) - titleMedium, Bold
    │   ├── Row (Set/Rep and Weight tags)
    │   │   ├── Surface (Set/Rep tag) - primary color
    │   │   └── Surface (Weight tag) - secondary color
    │   ├── Row (Optional tags)
    │   │   ├── Surface (Progression tag) - if progressionKg != 0
    │   │   └── Surface (Rest time tag) - if restSeconds > 0
    │   └── Text (notes) - if not empty
    └── Column (Action buttons)
        ├── IconButton (Edit, 36dp)
        └── IconButton (Delete, 36dp)
```

### Reorder Buttons

```kotlin
Column(
    verticalArrangement = spacedBy(2.dp),
    horizontalAlignment = CenterHorizontally
) {
    IconButton(
        onClick = onMoveUp,
        enabled = !isFirst,
        modifier = size(32dp)
    ) {
        Icon(
            Icons.Default.KeyboardArrowUp,
            tint = if (isFirst) outlineVariant else onSurfaceVariant,
            modifier = size(20dp)
        )
    }

    IconButton(
        onClick = onMoveDown,
        enabled = !isLast,
        modifier = size(32dp)
    ) {
        Icon(
            Icons.Default.KeyboardArrowDown,
            tint = if (isLast) outlineVariant else onSurfaceVariant,
            modifier = size(20dp)
        )
    }
}
```

**Logic:**
- First item: Up button disabled (grayed out)
- Last item: Down button disabled (grayed out)
- Updates `orderIndex` after reorder

### Set/Rep Display

```kotlin
private fun formatReps(setReps: List<Int>): String {
    if (setReps.isEmpty()) return "0 sets"

    val allSame = setReps.all { it == setReps.first() }
    return if (allSame) {
        "${setReps.size} x ${setReps.first()} reps"
    } else {
        "${setReps.size} sets: ${setReps.joinToString("/")}"
    }
}
```

**Examples:**
- `[10,10,10]` → "3 x 10 reps"
- `[10,8,6]` → "3 sets: 10/8/6"

**Tag Style:**
```kotlin
Surface(
    shape = RoundedCornerShape(6.dp),
    color = primary.copy(alpha = 0.15f)
) {
    Text(
        text = formatReps(exercise.setReps),
        style = bodySmall,
        color = primary,
        modifier = padding(horizontal = 8.dp, vertical = 4.dp),
        fontWeight = Medium
    )
}
```

### Weight Display

**Logic:**
```kotlin
val weightSuffix = if (weightUnit == WeightUnit.LB) "lbs" else "kg"

val weightDisplay = if (exercise.workoutType is WorkoutType.Echo) {
    "Adaptive"  // Echo mode = adaptive resistance
} else {
    // Per-set weights if configured
    if (exercise.setWeightsPerCableKg.isNotEmpty()) {
        val displayWeights = exercise.setWeightsPerCableKg.map {
            kgToDisplay(it, weightUnit).toInt()
        }
        val minWeight = displayWeights.minOrNull() ?: 0
        val maxWeight = displayWeights.maxOrNull() ?: 0

        if (minWeight == maxWeight) {
            "$minWeight$weightSuffix"
        } else {
            "$minWeight-$maxWeight$weightSuffix"  // Range
        }
    } else {
        // Single weight for all sets
        val displayWeight = kgToDisplay(exercise.weightPerCableKg, weightUnit)
        "${displayWeight.toInt()}$weightSuffix"
    }
}
```

**Examples:**
- Single weight: "100 lbs"
- Range: "90-110 kg"
- Echo mode: "Adaptive"

**Tag Style:**
```kotlin
Surface(
    shape = RoundedCornerShape(6.dp),
    color = secondary.copy(alpha = 0.15f)
) {
    Text(
        text = weightDisplay,
        style = bodySmall,
        color = secondary,
        modifier = padding(horizontal = 8.dp, vertical = 4.dp),
        fontWeight = Medium
    )
}
```

### Progression Tag (Optional)

**Display if:** `exercise.progressionKg != 0f`

```kotlin
val displayProgression = kgToDisplay(exercise.progressionKg, weightUnit)
val progressionText = if (displayProgression > 0) {
    "+${displayProgression.toInt()}$weightSuffix per rep"
} else {
    "${displayProgression.toInt()}$weightSuffix per rep"
}

Surface(
    shape = RoundedCornerShape(6.dp),
    color = if (exercise.progressionKg > 0) {
        tertiary.copy(alpha = 0.15f)
    } else {
        error.copy(alpha = 0.15f)
    }
) {
    Text(
        text = progressionText,
        style = bodySmall,
        color = if (exercise.progressionKg > 0) tertiary else error,
        modifier = padding(horizontal = 8.dp, vertical = 4.dp),
        fontWeight = Medium
    )
}
```

**Examples:**
- "+5 lbs per rep" (green/tertiary color)
- "-5 kg per rep" (red/error color)

### Rest Time Tag (Optional)

**Display if:** `exercise.restSeconds > 0`

```kotlin
Surface(
    shape = RoundedCornerShape(6.dp),
    color = surfaceVariant
) {
    Text(
        text = "${exercise.restSeconds}s rest",
        style = bodySmall,
        color = onSurfaceVariant,
        modifier = padding(horizontal = 8.dp, vertical = 4.dp),
        fontWeight = Medium
    )
}
```

### Notes Display (Optional)

**Display if:** `exercise.notes.isNotEmpty()`

```kotlin
Text(
    text = exercise.notes,
    style = bodySmall,
    color = outline,
    fontStyle = Italic,
    maxLines = 2
)
```

### Action Buttons

```kotlin
Column(
    verticalArrangement = spacedBy(4.dp),
    horizontalAlignment = CenterHorizontally
) {
    IconButton(
        onClick = { isPressed = true; onEdit() },
        modifier = size(36dp)
    ) {
        Icon(
            Icons.Default.Edit,
            tint = primary,
            modifier = size(20dp)
        )
    }

    IconButton(
        onClick = onDelete,
        modifier = size(36dp)
    ) {
        Icon(
            Icons.Default.Delete,
            tint = error,
            modifier = size(20dp)
        )
    }
}
```

### Reorder Logic

**Move Up:**
```kotlin
if (index > 0) {
    exercises = exercises.toMutableList().apply {
        removeAt(index).also { add(index - 1, it) }
    }.mapIndexed { i, ex -> ex.copy(orderIndex = i) }
}
```

**Move Down:**
```kotlin
if (index < exercises.lastIndex) {
    exercises = exercises.toMutableList().apply {
        removeAt(index).also { add(index + 1, it) }
    }.mapIndexed { i, ex -> ex.copy(orderIndex = i) }
}
```

**Delete:**
```kotlin
exercises = exercises.filterIndexed { i, _ -> i != index }
    .mapIndexed { i, ex -> ex.copy(orderIndex = i) }
```

---

## 8. Exercise Edit Bottom Sheet

**Component:** `ExerciseEditBottomSheet` (separate file)

**Triggered by:**
- Adding new exercise from picker
- Clicking "Edit" on existing exercise

**Properties:**
```kotlin
ExerciseEditBottomSheet(
    exercise: RoutineExercise,
    weightUnit: WeightUnit,
    enableVideoPlayback: Boolean,
    kgToDisplay: (Float, WeightUnit) -> Float,
    displayToKg: (Float, WeightUnit) -> Float,
    exerciseRepository: ExerciseRepository,
    personalRecordRepository: PersonalRecordRepository,
    formatWeight: (Float, WeightUnit) -> String,
    onSave: (RoutineExercise) -> Unit,
    onDismiss: () -> Unit
)
```

**Configuration Options:**
- Cable configuration (SINGLE/DOUBLE)
- Number of sets
- Reps per set
- Weight per cable (or per-set weights)
- Progression weight
- Rest time between sets
- Workout type (Program/Echo modes)
- Eccentric load
- Echo level (if Echo mode)
- Notes

---

## 9. Navigation & Routing

### Navigation Flow

```
DailyRoutinesScreen
├── Back button → navigateUp()
├── Start workout → ActiveWorkoutScreen
│   └── Route: NavigationRoutes.ActiveWorkout.route
└── RoutineBuilderDialog (in-place modal)
    └── ExerciseEditBottomSheet (nested modal)
```

### Start Workout Flow

**Sequence:**
1. User clicks RoutineCard
2. `ensureConnection()` called
   - If not connected: Auto-connect to device
   - Shows `ConnectingOverlay` during connection
   - Shows `ConnectionErrorDialog` if connection fails
3. On successful connection:
   - `loadRoutine(routine)` - Loads routine data
   - `startWorkout()` - Initializes workout session
   - `navController.navigate(ActiveWorkout)` - Navigates to workout screen

**Code:**
```kotlin
onStartWorkout = { routine ->
    viewModel.ensureConnection(
        onConnected = {
            viewModel.loadRoutine(routine)
            viewModel.startWorkout()
            navController.navigate(NavigationRoutes.ActiveWorkout.route)
        },
        onFailed = { /* Error shown via StateFlow */ }
    )
}
```

### Connection Overlays

**Connecting Overlay:**
```kotlin
if (isAutoConnecting) {
    ConnectingOverlay(
        onCancel = { viewModel.cancelAutoConnecting() }
    )
}
```

**Connection Error Dialog:**
```kotlin
connectionError?.let { error ->
    ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

---

## 10. Styling & Typography

### Color System

**Gradient Backgrounds:**
```kotlin
// Dark theme
val darkGradient = Brush.verticalGradient(
    colors = listOf(
        Color(0xFF0F172A), // slate-900
        Color(0xFF1E1B4B), // indigo-950
        Color(0xFF172554)  // blue-950
    )
)

// Light theme
val lightGradient = Brush.verticalGradient(
    colors = listOf(
        Color(0xFFE0E7FF), // indigo-200 (soft lavender)
        Color(0xFFFCE7F3), // pink-100 (soft pink)
        Color(0xFFDDD6FE)  // violet-200 (soft violet)
    )
)
```

**Icon Gradients:**
```kotlin
val purpleGradient = Brush.linearGradient(
    colors = listOf(
        Color(0xFF9333EA), // purple-600
        Color(0xFF7E22CE)  // purple-700
    )
)
```

**Card Borders:**
```kotlin
BorderStroke(1.dp, Color(0xFFF5F3FF)) // Very light purple
```

**Tag Colors:**
```kotlin
// Set/Rep tag
backgroundColor = primary.copy(alpha = 0.15f)
textColor = primary

// Weight tag
backgroundColor = secondary.copy(alpha = 0.15f)
textColor = secondary

// Progression tag (positive)
backgroundColor = tertiary.copy(alpha = 0.15f)
textColor = tertiary

// Progression tag (negative)
backgroundColor = error.copy(alpha = 0.15f)
textColor = error

// Rest time tag
backgroundColor = surfaceVariant
textColor = onSurfaceVariant
```

### Typography

**Headers:**
```kotlin
// Screen title
Typography.headlineMedium + FontWeight.Bold
color = onSurface

// Section title
Typography.titleMedium + FontWeight.Bold
color = onSurface

// Dialog title
Typography.headlineSmall + FontWeight.Bold
color = onSurface
```

**Body Text:**
```kotlin
// Routine name
Typography.titleMedium + FontWeight.Bold
color = onSurface

// Description / exercise count
Typography.bodySmall
color = onSurfaceVariant

// Exercise name
Typography.titleMedium + FontWeight.Bold
color = onSurface

// Tag text
Typography.bodySmall + FontWeight.Medium
color = varies by tag type

// Notes
Typography.bodySmall + FontStyle.Italic
color = outline
maxLines = 2
```

### Spacing

**Constants from theme:**
```kotlin
Spacing.extraSmall = 4.dp
Spacing.small = 8.dp
Spacing.medium = 16.dp
Spacing.large = 24.dp
```

**Card Spacing:**
- Card padding: 16dp
- Card spacing in list: Spacing.small (8dp)
- Icon-text spacing: Spacing.small (8dp)
- Tag spacing: Spacing.small (8dp)

**Layout Spacing:**
- Screen padding: 20dp
- Section spacing: Spacing.medium (16dp)
- Header to content: Spacing.medium (16dp)

### Shapes

```kotlin
// Cards
RoundedCornerShape(16.dp)

// Tags
RoundedCornerShape(6.dp)

// Buttons
RoundedCornerShape(12.dp)  // Outlined
RoundedCornerShape(16.dp)  // Filled

// Icon boxes
RoundedCornerShape(12.dp)

// Circular icons
RoundedCornerShape(50)
```

### Elevation

```kotlin
// Cards (default)
elevation = 4.dp

// Cards (pressed)
elevation = 2.dp

// Icon gradient box
shadow = 4.dp
```

---

## 11. Animations

### Press Animation (Cards)

```kotlin
var isPressed by remember { mutableStateOf(false) }
val scale by animateFloatAsState(
    targetValue = if (isPressed) 0.99f else 1f,
    animationSpec = spring(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = 400f
    ),
    label = "scale"
)

// Apply to card
Card(modifier = Modifier.scale(scale))

// Auto-reset after 100ms
LaunchedEffect(isPressed) {
    if (isPressed) {
        delay(100)
        isPressed = false
    }
}
```

**Effect:** Bouncy scale down (99%) on press, then bounce back

### Elevation Change on Press

```kotlin
Card(
    elevation = CardDefaults.cardElevation(
        defaultElevation = if (isPressed) 2.dp else 4.dp
    )
)
```

**Effect:** Elevation reduces from 4dp to 2dp on press

---

## 12. Edge Cases & Error Handling

### Empty States

**No Routines:**
- Shows `EmptyState` component
- Icon: FitnessCenter
- Message: "No Routines Yet"
- Action: "Create Your First Routine"
- Opens RoutineBuilderDialog on action

**No Exercises in Builder:**
- Shows empty card with message
- "No exercises added yet"
- Validation prevents saving

### Validation

**Routine Builder:**
1. Name required: `name.isNotBlank()`
2. At least one exercise: `exercises.isNotEmpty()`
3. Shows inline error messages
4. Prevents save until valid

**Error Display:**
```kotlin
if (showError && name.isBlank()) {
    Text(
        "Routine name is required",
        color = error,
        style = bodySmall,
        padding = start: Spacing.medium, top: Spacing.extraSmall
    )
}

if (showError && exercises.isEmpty()) {
    Text(
        "Add at least one exercise",
        color = error,
        style = bodySmall,
        padding = top: Spacing.extraSmall
    )
}
```

### Connection Handling

**Auto-Connect Flow:**
1. User starts workout
2. If not connected: `isAutoConnecting = true`
3. Shows `ConnectingOverlay` with cancel button
4. On success: Navigates to workout
5. On failure: Shows `ConnectionErrorDialog`

**Error Dialog:**
```kotlin
connectionError?.let { error ->
    ConnectionErrorDialog(
        message = error,
        onDismiss = { viewModel.clearConnectionError() }
    )
}
```

### Exercise Reordering

**Boundary Checks:**
- Move Up: Disabled if `index == 0`
- Move Down: Disabled if `index == lastIndex`
- Updates `orderIndex` after every reorder
- Maintains list integrity

### Duplicate Naming

**Collision Handling:**
- Smart copy numbering: "Copy", "Copy 2", "Copy 3"
- Handles existing copies correctly
- Extracts base name (removes copy suffix)
- Finds next available number

### Weight Display

**Echo Mode:**
- Shows "Adaptive" instead of weight
- Prevents confusion with fixed weight

**Variable Weights:**
- Shows range if per-set weights differ: "90-110 kg"
- Shows single value if all sets same: "100 kg"

---

## 13. Dependencies

### Repository Dependencies

```kotlin
// Injected into screen
exerciseRepository: ExerciseRepository
personalRecordRepository: PersonalRecordRepository
```

**Used for:**
- Loading exercise library for picker
- Loading PRs for exercise edit sheet

### ViewModel Dependencies

```kotlin
MainViewModel: HiltViewModel
├── routines: StateFlow<List<Routine>>
├── weightUnit: StateFlow<WeightUnit>
├── enableVideoPlayback: StateFlow<Boolean>
├── isAutoConnecting: StateFlow<Boolean>
└── connectionError: StateFlow<String?>
```

### Component Dependencies

```kotlin
// Reusable components
EmptyState(...)
ConnectingOverlay(...)
ConnectionErrorDialog(...)
ExercisePickerDialog(...)
ExerciseEditBottomSheet(...)
```

---

## 14. Flutter Port - Widget Estimate

### Widget Hierarchy Breakdown

**DailyRoutinesScreen (wrapper):**
- Scaffold (1)
- AppBar (1)
- IconButton + Icon (2)
- Text (1)
- Container/Box (1)
- ConnectingOverlay (conditional, ~10 widgets)
- ConnectionErrorDialog (conditional, ~15 widgets)

**RoutinesTab:**
- Container/Box (1)
- Column (1)
- Text (1) - header
- SizedBox (1)
- ListView.builder OR EmptyState (1)
  - If empty: EmptyState (~10 widgets)
  - If not empty: ListView with RoutineCards
- FloatingActionButton.extended (1)

**RoutineCard (per routine):**
- Card (1)
- InkWell (1)
- Row (1)
- Container (gradient icon) (1)
- Icon (1)
- Column (1)
- Text × 2 (2) - name, description
- Column (exercise preview) (1)
- Text × 4-5 (5) - exercises
- Text (1) - duration
- Surface/Container (arrow) (1)
- IconButton + DropdownMenu (10) - menu

**Total per RoutineCard:** ~27 widgets

**RoutineBuilderDialog:**
- Dialog (1)
- Container/Card (1)
- Column (1)
- Row (header) (1)
- Text (1)
- IconButton (1)
- SingleChildScrollView (1)
- Column (1)
- TextField × 2 (2)
- Text × 2 (error messages, conditional) (2)
- Text (section header) (1)
- Card (empty state, conditional) (1)
- Column (exercise list) (1)
- ExerciseListItem × N
- OutlinedButton (1)
- Row (actions) (1)
- OutlinedButton (1)
- ElevatedButton (1)

**Total RoutineBuilderDialog:** ~20 base + N×ExerciseListItems

**ExerciseListItem:**
- Card (1)
- Row (1)
- Column (reorder buttons) (1)
- IconButton × 2 (2)
- Column (exercise info) (1)
- Text (1) - name
- Row (1)
- Container × 2 (tags) (2)
- Text × 2 (tag text) (2)
- Row (optional tags) (1)
- Container × 2 (conditional) (2)
- Text × 2 (conditional) (2)
- Text (notes, conditional) (1)
- Column (actions) (1)
- IconButton × 2 (2)

**Total per ExerciseListItem:** ~23 widgets

### Total Widget Count Estimate

**Base DailyRoutinesScreen:** ~20 widgets

**With 5 Routines:** ~20 + (5 × 27) = **155 widgets**

**RoutineBuilderDialog (open):** ~20 base widgets

**With 5 Exercises in Builder:** ~20 + (5 × 23) = **135 widgets**

**Total (screen + open dialog):** ~155 + 135 = **~290 widgets**

**Peak (with all modals):** ~290 + 10 (overlay) + 15 (error) = **~315 widgets**

---

## 15. Complexity Assessment

### Overall Complexity: **HIGH** (8/10)

**Reasons:**
1. **Multiple nested modals** (Dialog → Bottom Sheet)
2. **Complex state management** (routine editing, exercise list, validation)
3. **Duplicate logic** (smart naming algorithm)
4. **Reordering logic** (move up/down with orderIndex updates)
5. **Variable weight display** (per-set vs. single weight, Echo mode)
6. **Connection flow** (auto-connect, overlays, error handling)
7. **Multiple animations** (press, scale, elevation)
8. **Deep data structures** (Routine → RoutineExercise → Exercise)

### Component Complexity

**RoutineCard:** Medium (4/10)
- Press animation
- Dropdown menu
- Exercise preview formatting
- Duplicate logic (complex)

**RoutinesTab:** Medium (5/10)
- List vs. empty state
- FAB positioning
- Dialog state management

**RoutineBuilderDialog:** High (8/10)
- Multiple state variables
- Validation logic
- Exercise list management
- Nested modal (ExerciseEditBottomSheet)
- Reordering logic

**ExerciseListItem:** High (7/10)
- Variable weight display logic
- Echo mode handling
- Optional tags (conditional rendering)
- Reorder buttons with boundary checks

---

## 16. Kotlin → Dart Translation Notes

### StateFlow → StreamProvider

**Kotlin:**
```kotlin
val routines by viewModel.routines.collectAsState()
```

**Dart (Riverpod):**
```dart
final routines = ref.watch(routinesProvider);
```

### Coroutines → Async/Await

**Kotlin:**
```kotlin
LaunchedEffect(isPressed) {
    if (isPressed) {
        delay(100)
        isPressed = false
    }
}
```

**Dart:**
```dart
if (isPressed) {
  Future.delayed(Duration(milliseconds: 100), () {
    setState(() => isPressed = false);
  });
}
```

### UUID Generation

**Kotlin:**
```kotlin
java.util.UUID.randomUUID().toString()
```

**Dart:**
```dart
import 'package:uuid/uuid.dart';
const Uuid().v4()
```

### Regex

**Kotlin:**
```kotlin
val baseName = routine.name.replace(Regex(""" \(Copy( \d+)?\)$"""), "")
```

**Dart:**
```dart
final baseName = routine.name.replaceAll(RegExp(r' \(Copy( \d+)?\)$'), '');
```

### Collection Operations

**Kotlin:**
```kotlin
exercises.mapIndexed { i, ex -> ex.copy(orderIndex = i) }
```

**Dart:**
```dart
exercises.asMap().entries.map((e) =>
  e.value.copyWith(orderIndex: e.key)
).toList()
```

### Animation Specs

**Kotlin:**
```kotlin
animationSpec = spring(
    dampingRatio = Spring.DampingRatioMediumBouncy,
    stiffness = 400f
)
```

**Dart:**
```dart
curve: Curves.elasticOut,
duration: Duration(milliseconds: 300)
```

---

## 17. Testing Considerations

### Unit Tests

**Test Cases:**
1. `formatSetReps()` - Test grouping logic
   - `[10,10,10]` → "3×10"
   - `[10,10,8,8]` → "3×10, 2×8"
   - `[]` → "0 sets"

2. `formatEstimatedDuration()` - Test duration calculation
   - 3 seconds per rep + rest time
   - Handle minutes vs. hours format

3. Duplicate naming algorithm
   - "Routine" → "Routine (Copy)"
   - "Routine (Copy)" → "Routine (Copy 2)"
   - "Routine (Copy 5)" → "Routine (Copy 6)"

4. Reorder logic
   - Move up/down updates orderIndex correctly
   - Boundary checks work (first/last)

5. Validation logic
   - Name required
   - At least one exercise required

### Widget Tests

**Test Cases:**
1. Empty state displays when no routines
2. Routine list displays with correct count
3. RoutineCard shows correct info
4. Dropdown menu appears on overflow button
5. RoutineBuilderDialog validates input
6. Exercise reorder buttons work
7. Add exercise opens picker
8. Save button validates before saving

### Integration Tests

**Test Cases:**
1. Create new routine → Save → Appears in list
2. Edit routine → Save → Updates in list
3. Duplicate routine → Correct naming
4. Delete routine → Removed from list
5. Start workout → Connects → Navigates to workout screen
6. Connection error → Shows error dialog

---

## 18. Database Integration

### Tables Involved

**RoutineEntity:**
```sql
CREATE TABLE routines (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT DEFAULT '',
    createdAt INTEGER NOT NULL,
    lastUsed INTEGER,
    useCount INTEGER DEFAULT 0
)
```

**RoutineExerciseEntity:**
```sql
CREATE TABLE routine_exercises (
    id TEXT PRIMARY KEY,
    routineId TEXT NOT NULL,
    exerciseName TEXT NOT NULL,
    exerciseMuscleGroup TEXT NOT NULL,
    exerciseEquipment TEXT DEFAULT '',
    exerciseDefaultCableConfig TEXT NOT NULL,
    exerciseId TEXT,
    cableConfig TEXT NOT NULL,
    orderIndex INTEGER NOT NULL,
    setReps TEXT NOT NULL,  -- JSON: "[10,10,10]"
    weightPerCableKg REAL NOT NULL,
    setWeightsPerCableKg TEXT, -- JSON: "[20.0,22.5,25.0]"
    workoutType TEXT NOT NULL,
    progressionKg REAL DEFAULT 0.0,
    restSeconds INTEGER DEFAULT 60,
    notes TEXT DEFAULT '',
    eccentricLoad TEXT NOT NULL,
    echoLevel TEXT NOT NULL,
    FOREIGN KEY (routineId) REFERENCES routines(id) ON DELETE CASCADE
)
```

### Queries

**Load All Routines:**
```sql
SELECT r.*, re.*
FROM routines r
LEFT JOIN routine_exercises re ON r.id = re.routineId
ORDER BY r.createdAt DESC, re.orderIndex ASC
```

**Insert Routine:**
```sql
INSERT INTO routines VALUES (?, ?, ?, ?, ?, ?)
```

**Insert Exercises:**
```sql
INSERT INTO routine_exercises VALUES (?, ?, ...) -- for each exercise
```

**Update Routine:**
```sql
UPDATE routines SET name=?, description=? WHERE id=?
DELETE FROM routine_exercises WHERE routineId=?
INSERT INTO routine_exercises VALUES (...) -- for each exercise
```

**Delete Routine:**
```sql
DELETE FROM routines WHERE id=?
-- CASCADE deletes routine_exercises automatically
```

---

## 19. Accessibility

### Semantic Labels

**Icons:**
- Back arrow: "Back"
- More menu: "Menu"
- Add button: "Add exercise"
- Edit button: "Edit"
- Delete button: "Delete"
- Move up: "Move Up"
- Move down: "Move Down"
- Close dialog: "Close"

**Buttons:**
- FAB: Text provides label ("New Routine")
- Start workout: Card click (routine name as label)

### Focus Order

1. Back button
2. Routine cards (focusable)
3. Floating action button
4. Dialog fields (when open)

### Screen Reader Support

- Routine cards announce: "Routine name, X exercises, Y minutes"
- Empty state announces: "No Routines Yet"
- Validation errors announced when shown

---

## 20. Performance Considerations

### List Optimization

**LazyColumn with stable keys:**
```kotlin
LazyColumn {
    items(routines, key = { it.id }) { routine ->
        RoutineCard(...)
    }
}
```

**Benefit:** Efficient recomposition on list changes

### Animation Performance

**Hardware acceleration:**
- Scale animation uses `Modifier.scale()` (GPU-accelerated)
- Elevation changes minimal recomposition

### State Management

**Scoped state:**
- Dialog state isolated to RoutinesTab
- Prevents unnecessary parent recompositions

### Database Performance

**Batched queries:**
- Load all routines + exercises in single query
- Use foreign key cascade for deletes

---

## 21. Known Issues & Quirks

### Issue #109: Echo Mode Weight Display

**Problem:** Echo mode uses adaptive resistance, not fixed weight.

**Solution:** Display "Adaptive" instead of weight for Echo mode exercises.

```kotlin
val weightDisplay = if (exercise.workoutType is WorkoutType.Echo) {
    "Adaptive"
} else {
    // Show weight...
}
```

### Duplicate Deep Copy

**Critical:** Must generate new UUIDs for all entities when duplicating.

```kotlin
val newRoutineId = UUID.randomUUID().toString()
val newExercises = routine.exercises.map { exercise ->
    exercise.copy(
        id = UUID.randomUUID().toString(),
        exercise = exercise.exercise.copy() // Deep copy!
    )
}
```

**Why:** Prevents foreign key violations in database.

### Exercise Reorder State Management

**Challenge:** Must update `orderIndex` for all exercises after reorder.

```kotlin
exercises = exercises.toMutableList().apply {
    removeAt(index).also { add(index - 1, it) }
}.mapIndexed { i, ex -> ex.copy(orderIndex = i) }
```

**Why:** Database requires consistent orderIndex for sorting.

---

## 22. Summary

### Key Takeaways

1. **Wrapper Pattern:** DailyRoutinesScreen wraps RoutinesTab for reuse
2. **Complex State:** Multiple nested modals, validation, reordering
3. **Smart Duplication:** Intelligent copy naming algorithm
4. **Variable Weight Display:** Handles per-set weights, ranges, Echo mode
5. **Connection Flow:** Auto-connect before workout with overlays
6. **High Widget Count:** ~315 widgets at peak (with all modals open)
7. **Database-Backed:** All routines persisted with cascade deletes
8. **Accessibility:** Proper labels, focus order, screen reader support

### Flutter Port Priorities

**Phase 1 (Core):**
1. Port domain models (Routine, RoutineExercise)
2. Port database schema (Drift tables)
3. Port repository methods
4. Port StateNotifiers (RoutinesProvider)

**Phase 2 (UI):**
1. Port RoutineCard (with animation)
2. Port RoutinesTab (list + empty state)
3. Port DailyRoutinesScreen (wrapper)
4. Port FAB

**Phase 3 (Builder):**
1. Port RoutineBuilderDialog
2. Port ExerciseListItem (with reorder)
3. Port validation logic
4. Port duplicate algorithm

**Phase 4 (Integration):**
1. Port ExercisePickerDialog
2. Port ExerciseEditBottomSheet
3. Wire up navigation
4. Add connection overlays

**Phase 5 (Testing):**
1. Unit tests for formatters and algorithms
2. Widget tests for all components
3. Integration tests for complete flows

---

## End of Analysis

**Total Lines Analyzed:** 440 (across 3 files)

**Estimated Port Time:** 12-16 hours

**Complexity Rating:** High (8/10)

**Dependencies:** ExerciseRepository, PersonalRecordRepository, MainViewModel, Navigation, BLE Manager

**Next Steps:** Begin Phase 1 - Port domain models and database schema.
