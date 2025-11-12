# Routines Tab - Extreme Detail Analysis for Flutter Porting

**Source File:** `C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/example/vitruvianredux/presentation/screen/RoutinesTab.kt`

**Analysis Date:** 2025-11-12

**Purpose:** Complete pixel-perfect specification for Flutter implementation of the Routines Tab screen.

---

## 1. FILE IDENTIFICATION

### Main Files
- **Screen:** `RoutinesTab.kt` (440 lines)
- **Dialog:** `RoutineBuilderDialog.kt` (396 lines)
- **Model:** `Routine.kt`, `RoutineExercise.kt`
- **Component:** `EmptyStateComponent.kt` (empty state)
- **Theme:** `Spacing.kt`, `Color.kt`

### Dependencies
- ExerciseRepository (for exercise data)
- PersonalRecordRepository (for PRs)
- RoutineBuilderDialog (full-screen dialog)
- ExercisePickerDialog (exercise selection)
- EmptyState component

---

## 2. COMPLETE LAYOUT HIERARCHY

### RoutinesTab Structure

```
Box (fillMaxSize + gradient background)
└── Column (fillMaxSize + 20dp padding)
    ├── Text("My Routines") - headlineMedium, Bold
    ├── Spacer(Spacing.medium = 16dp)
    └── [CONDITIONAL CONTENT]
        ├── IF routines.isEmpty():
        │   └── EmptyState(
        │       icon: FitnessCenter,
        │       title: "No Routines Yet",
        │       message: "Create your first workout routine to get started",
        │       actionText: "Create Your First Routine",
        │       onAction: open RoutineBuilderDialog
        │       )
        │
        └── ELSE:
            └── LazyColumn(verticalArrangement: spacedBy(Spacing.small = 8dp))
                └── items(routines) { routine ->
                    RoutineCard(...)
                    }

├── ExtendedFloatingActionButton (Alignment.BottomEnd + Spacing.medium padding)
    ├── Icon(Icons.Default.Add)
    ├── Spacer(Spacing.small = 8dp)
    └── Text("New Routine")

└── IF showRoutineBuilder:
    └── RoutineBuilderDialog(...)
```

### RoutineCard Structure

```
Card (fillMaxWidth, scale animated, clickable)
└── Column
    ├── Row (fillMaxWidth + 16dp padding, spacedBy(16dp))
    │   ├── Box (64dp gradient icon container)
    │   │   └── Icon(FitnessCenter, 32dp)
    │   ├── Column (weight(1f), spacedBy(4dp)) - CONTENT
    │   │   ├── Text(routine.name) - titleMedium, Bold
    │   │   ├── Text(description OR "${exercises.size} exercises") - bodySmall
    │   │   ├── Column (exercise preview list, spacedBy(2dp))
    │   │   │   ├── Text(exercise details) - labelSmall, for first 4 exercises
    │   │   │   └── IF remainingCount > 0:
    │   │   │       └── Text("+ $remainingCount more") - labelSmall, primary color
    │   │   └── Text("${exercises.size} exercises • ${duration}") - bodySmall, primary
    │   └── Surface (36dp circle arrow button)
    │       └── Icon(ArrowForward, 16dp)
    │
    └── Box (overlay for overflow menu - TOP RIGHT)
        ├── IconButton(MoreVert)
        └── DropdownMenu
            ├── DropdownMenuItem("Edit" + Edit icon)
            ├── DropdownMenuItem("Duplicate" + ContentCopy icon)
            └── DropdownMenuItem("Delete" + Delete icon, error color)
```

### EmptyState Structure

```
Box (fillMaxSize, centered)
└── Column (centered, spacedBy(Spacing.medium = 16dp), 24dp padding)
    ├── Icon(icon, 64dp, onSurfaceVariant @ 60% alpha)
    ├── Text(title) - titleLarge, Bold
    ├── Text(message) - bodyMedium, onSurfaceVariant
    └── IF actionText != null:
        ├── Spacer(Spacing.small = 8dp)
        └── Button(actionText, primary color, Spacing.medium top padding)
```

---

## 3. EVERY UI ELEMENT (EXACT PROPERTIES)

### Screen Header

| Element | Property | Value |
|---------|----------|-------|
| Container | Type | Column |
| Container | Padding | 20dp all sides |
| Container | Background | Gradient (see Section 4) |
| Title Text | Content | "My Routines" |
| Title Text | Style | MaterialTheme.typography.headlineMedium |
| Title Text | FontWeight | FontWeight.Bold |
| Title Text | Color | MaterialTheme.colorScheme.onSurface |
| Spacer | Height | Spacing.medium (16dp) |

### Floating Action Button (FAB)

| Element | Property | Value |
|---------|----------|-------|
| Type | - | ExtendedFloatingActionButton |
| Position | Alignment | Alignment.BottomEnd |
| Padding | - | Spacing.medium (16dp) |
| Container Color | - | MaterialTheme.colorScheme.primary |
| Content Color | - | MaterialTheme.colorScheme.onPrimary |
| Icon | ImageVector | Icons.Default.Add |
| Icon | contentDescription | null (decorative) |
| Spacer | Width | Spacing.small (8dp) |
| Text | Content | "New Routine" |

### Empty State

| Element | Property | Value |
|---------|----------|-------|
| Container | Type | Box (fillMaxSize, centered) |
| Icon | ImageVector | Icons.Default.FitnessCenter |
| Icon | Size | 64dp |
| Icon | Tint | onSurfaceVariant @ 60% alpha |
| Title | Content | "No Routines Yet" |
| Title | Style | MaterialTheme.typography.titleLarge |
| Title | FontWeight | FontWeight.Bold |
| Title | Color | MaterialTheme.colorScheme.onSurface |
| Message | Content | "Create your first workout routine to get started" |
| Message | Style | MaterialTheme.typography.bodyMedium |
| Message | Color | MaterialTheme.colorScheme.onSurfaceVariant |
| Message | Padding | horizontal: Spacing.large (24dp) |
| Button | Text | "Create Your First Routine" |
| Button | Container Color | MaterialTheme.colorScheme.primary |
| Button | Top Padding | Spacing.medium (16dp) |
| Spacing | Between Elements | Spacing.medium (16dp) |

### Routine List (LazyColumn)

| Element | Property | Value |
|---------|----------|-------|
| Type | - | LazyColumn |
| Arrangement | Vertical | spacedBy(Spacing.small = 8dp) |
| Items | Key | routine.id |

### Routine Card - Container

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Card |
| Width | - | fillMaxWidth() |
| Shape | - | RoundedCornerShape(16.dp) |
| Container Color | - | MaterialTheme.colorScheme.surface |
| Elevation | Default | 4.dp |
| Elevation | Pressed | 2.dp |
| Border | Width | 1.dp |
| Border | Color | Color(0xFFF5F3FF) |
| Scale | Normal | 1f |
| Scale | Pressed | 0.99f |
| Scale Animation | Spec | spring(dampingRatio: MediumBouncy, stiffness: 400f) |
| onClick | Action | onStartWorkout(routine) |

### Routine Card - Content Row

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Row |
| Width | - | fillMaxWidth() |
| Padding | - | 16dp all sides |
| Horizontal Arrangement | - | spacedBy(16dp) |
| Vertical Alignment | - | CenterVertically |

### Routine Card - Gradient Icon Box

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Box |
| Size | - | 64dp × 64dp |
| Shape | - | RoundedCornerShape(12.dp) |
| Shadow | - | 4.dp elevation |
| Background | Type | Brush.linearGradient |
| Background | Colors | [Color(0xFF9333EA), Color(0xFF7E22CE)] |
| Background | Direction | Linear (purple gradient) |
| Icon | ImageVector | Icons.Default.FitnessCenter |
| Icon | Size | 32dp |
| Icon | Tint | MaterialTheme.colorScheme.onPrimary |
| Icon | contentDescription | null |

### Routine Card - Content Column

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Column |
| Weight | - | 1f (fills remaining space) |
| Vertical Arrangement | - | spacedBy(4dp) |

### Routine Card - Title

| Element | Property | Value |
|---------|----------|-------|
| Content | - | routine.name |
| Style | - | MaterialTheme.typography.titleMedium |
| FontWeight | - | FontWeight.Bold |
| Color | - | MaterialTheme.colorScheme.onSurface |

### Routine Card - Description

| Element | Property | Value |
|---------|----------|-------|
| Content | IF | routine.description (if not empty) |
| Content | ELSE | "${routine.exercises.size} exercises" |
| Style | - | MaterialTheme.typography.bodySmall |
| Color | - | MaterialTheme.colorScheme.onSurfaceVariant |

### Routine Card - Exercise Preview List

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Column |
| Vertical Arrangement | - | spacedBy(2dp) |
| Items Shown | - | First 4 exercises (take(4)) |
| Exercise Text | Format | "${exercise.name} - ${formatSetReps(setReps)}" |
| Exercise Text | Style | MaterialTheme.typography.labelSmall |
| Exercise Text | Color | MaterialTheme.colorScheme.onSurfaceVariant |
| Remaining Text | Format | "+ $remainingCount more" |
| Remaining Text | Style | MaterialTheme.typography.labelSmall |
| Remaining Text | Color | MaterialTheme.colorScheme.primary |
| Remaining Text | FontWeight | FontWeight.Medium |
| Condition | - | Only show if remainingCount > 0 |

### Routine Card - Duration/Summary

| Element | Property | Value |
|---------|----------|-------|
| Format | - | "${exercises.size} exercises • ${duration}" |
| Style | - | MaterialTheme.typography.bodySmall |
| Color | - | MaterialTheme.colorScheme.primary |

### Routine Card - Arrow Button

| Element | Property | Value |
|---------|----------|-------|
| Type | - | Surface |
| Shape | - | RoundedCornerShape(50) (circle) |
| Color | - | Color(0xFFF5F3FF) |
| Size | - | 36dp × 36dp |
| Icon | ImageVector | Icons.AutoMirrored.Filled.ArrowForward |
| Icon | Size | 16dp |
| Icon | Tint | Color(0xFF9333EA) (purple) |
| Icon | contentDescription | "Navigate" |
| Alignment | - | Centered in Surface |

### Routine Card - Overflow Menu

| Element | Property | Value |
|---------|----------|-------|
| Type | - | IconButton + DropdownMenu |
| Position | - | Alignment.TopEnd (overlaid) |
| Icon | ImageVector | Icons.Default.MoreVert |
| Icon | contentDescription | "Menu" |

#### Dropdown Menu Items

| Item | Text | Icon | Color | Action |
|------|------|------|-------|--------|
| Edit | "Edit" | Icons.Default.Edit | Default | Open RoutineBuilderDialog with routine |
| Duplicate | "Duplicate" | Icons.Default.ContentCopy | Default | Duplicate routine with "(Copy N)" naming |
| Delete | "Delete" | Icons.Default.Delete | error | Delete routine (onDeleteRoutine) |

---

## 4. ALL COLORS (WITH HEX CODES)

### Background Gradients

#### Dark Mode (themeMode == ThemeMode.DARK)
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFF0F172A), // slate-900
        Color(0xFF1E1B4B), // indigo-950
        Color(0xFF172554)  // blue-950
    )
)
```

#### Light Mode (themeMode != ThemeMode.DARK)
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFFE0E7FF), // indigo-200 - soft lavender
        Color(0xFFFCE7F3), // pink-100 - soft pink
        Color(0xFFDDD6FE)  // violet-200 - soft violet
    )
)
```

### Card Colors

| Element | Color | Hex Code |
|---------|-------|----------|
| Card Background | surface | MaterialTheme.colorScheme.surface |
| Card Border | - | #F5F3FF (lavender white) |
| Card Elevation | - | 4dp (2dp when pressed) |

### Icon Gradient (Routine Card)

| Position | Color Name | Hex Code |
|----------|-----------|----------|
| Start | Purple-500 | #9333EA |
| End | Purple-700 | #7E22CE |

### Text Colors

| Element | Theme Property | Notes |
|---------|---------------|-------|
| Screen Title | onSurface | Bold headlineMedium |
| Card Title | onSurface | Bold titleMedium |
| Card Description | onSurfaceVariant | bodySmall |
| Exercise Details | onSurfaceVariant | labelSmall |
| Duration/Summary | primary | bodySmall |
| "X more" Text | primary | labelSmall, Medium weight |
| Empty State Title | onSurface | Bold titleLarge |
| Empty State Message | onSurfaceVariant | bodyMedium |
| Empty State Icon | onSurfaceVariant | 60% alpha |

### Button/Icon Colors

| Element | Container | Content | Notes |
|---------|-----------|---------|-------|
| FAB | primary | onPrimary | Extended FAB |
| Arrow Button Surface | #F5F3FF | #9333EA | 36dp circle |
| Delete Menu Item | - | error | DropdownMenuItem icon |
| Empty State Button | primary | onPrimary | Standard Button |

---

## 5. ALL TYPOGRAPHY

### Typography Table

| Element | Material Style | Font Weight | Font Size | Use Case |
|---------|---------------|-------------|-----------|----------|
| Screen Title | headlineMedium | Bold | ~28sp | "My Routines" |
| Card Title | titleMedium | Bold | ~16sp | Routine name |
| Card Description | bodySmall | Regular | ~12sp | Description text |
| Exercise Details | labelSmall | Regular | ~11sp | Exercise preview |
| Duration/Summary | bodySmall | Regular | ~12sp | Exercise count + duration |
| "X more" Text | labelSmall | Medium | ~11sp | Remaining exercises |
| FAB Text | labelLarge | Medium | ~14sp | "New Routine" |
| Empty State Title | titleLarge | Bold | ~22sp | "No Routines Yet" |
| Empty State Message | bodyMedium | Regular | ~14sp | Helper message |
| Empty State Button | labelLarge | Medium | ~14sp | Action button text |

### Typography Usage Notes
- All text uses MaterialTheme.typography for consistency
- FontWeight.Bold for titles (screen, cards, empty state)
- FontWeight.Medium for emphasis ("X more", button labels)
- FontWeight.Regular (default) for body/description text

---

## 6. ALL SPACING VALUES

### Spacing Constants (from Spacing.kt)

| Constant | Value | Usage |
|----------|-------|-------|
| Spacing.extraSmall | 4dp | Vertical spacing in content column |
| Spacing.small | 8dp | List item spacing, FAB icon spacer, empty state spacer |
| Spacing.medium | 16dp | Screen padding, FAB padding, empty state element spacing |
| Spacing.large | 24dp | Empty state content padding |
| Spacing.extraLarge | 32dp | (not used in this screen) |
| Spacing.huge | 48dp | (not used in this screen) |

### Element-Specific Spacing

| Element | Spacing Type | Value | Notes |
|---------|-------------|-------|-------|
| Screen Column | Padding | 20dp | All sides |
| Screen Header Spacer | Height | 16dp | After "My Routines" |
| LazyColumn | Item Spacing | 8dp | Between routine cards |
| Card Content Row | Padding | 16dp | All sides |
| Card Content Row | Horizontal | 16dp | Between elements |
| Card Content Column | Vertical | 4dp | Between text elements |
| Exercise Preview | Vertical | 2dp | Between exercise lines |
| Icon Box | Size | 64dp | Square gradient box |
| Icon Box | Corner Radius | 12dp | Rounded corners |
| Icon | Size | 32dp | Inside 64dp box |
| Arrow Surface | Size | 36dp | Circle button |
| Arrow Icon | Size | 16dp | Inside 36dp surface |
| FAB | Padding | 16dp | From screen edge |
| FAB Icon Spacer | Width | 8dp | Between icon and text |
| Empty State Icon | Size | 64dp | Large centered icon |
| Empty State Padding | Horizontal | 24dp | Message text |
| Card Border | Width | 1dp | Subtle border |
| Card Corner Radius | - | 16dp | Rounded corners |

---

## 7. ALL INTERACTIONS

### Primary Interactions

| Element | Interaction Type | Action | Parameters |
|---------|-----------------|--------|------------|
| Routine Card | onClick | Start workout | onStartWorkout(routine) |
| Routine Card | Press Animation | Scale 1f → 0.99f | Spring animation, 100ms reset |
| FAB | onClick | Create new routine | Open RoutineBuilderDialog (routineToEdit = null) |
| Empty State Button | onClick | Create first routine | Open RoutineBuilderDialog (routineToEdit = null) |

### Menu Interactions

| Menu Item | Interaction | Action | Parameters |
|-----------|-------------|--------|------------|
| Edit | onClick | Edit routine | Open RoutineBuilderDialog with routineToEdit = routine |
| Duplicate | onClick | Duplicate routine | Create copy with smart naming: baseName + "(Copy N)" |
| Delete | onClick | Delete routine | onDeleteRoutine(routine.id) |

### Duplicate Logic (Complex)

```kotlin
// Smart naming algorithm:
1. Extract baseName by removing " (Copy N)" suffix
2. Find all existing copy numbers:
   - Original (no suffix) = 0
   - "Name (Copy)" = 1
   - "Name (Copy 2)" = 2, etc.
3. nextCopyNumber = max(existingCopyNumbers) + 1
4. If nextCopyNumber == 1: "Name (Copy)"
   Else: "Name (Copy N)"

// Deep copy requirements:
- Generate new routine ID (UUID)
- Generate new IDs for all exercises (UUID)
- Deep copy Exercise objects
- Reset useCount = 0
- Reset lastUsed = null
- Update createdAt = System.currentTimeMillis()
```

### State Changes

| Interaction | State Change | Effect |
|-------------|-------------|--------|
| Click FAB | showRoutineBuilder = true, routineToEdit = null | Opens dialog in create mode |
| Click Edit | showRoutineBuilder = true, routineToEdit = routine | Opens dialog in edit mode |
| Click Empty State | showRoutineBuilder = true, routineToEdit = null | Opens dialog in create mode |
| Save in Dialog | showRoutineBuilder = false, routineToEdit = null | Closes dialog |
| Dismiss Dialog | showRoutineBuilder = false, routineToEdit = null | Closes dialog |

---

## 8. ANIMATIONS & TRANSITIONS

### Card Press Animation

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

// Applied to Card modifier:
Modifier.scale(scale)

// Auto-reset after 100ms:
LaunchedEffect(isPressed) {
    if (isPressed) {
        delay(100)
        isPressed = false
    }
}
```

### Animation Parameters

| Parameter | Value | Effect |
|-----------|-------|--------|
| Scale Normal | 1f | Full size |
| Scale Pressed | 0.99f | Slightly smaller (1% reduction) |
| Damping Ratio | Spring.DampingRatioMediumBouncy | Bouncy spring feel |
| Stiffness | 400f | Moderate spring stiffness |
| Auto-reset | 100ms | Returns to normal after brief delay |

### Elevation Animation

| State | Elevation | Notes |
|-------|-----------|-------|
| Default | 4.dp | Normal card elevation |
| Pressed | 2.dp | Slightly lower when pressed |
| Animation | Built-in | Material3 Card handles elevation transition |

### No Other Animations
- No enter/exit transitions (immediate show/hide)
- No scroll animations beyond default LazyColumn behavior
- No loading animations (routines load instantly from state)

---

## 9. DATA DISPLAY LOGIC

### Routine Name
- Direct display of `routine.name`
- No truncation or ellipsis (assumes reasonable length)

### Description
- Shows `routine.description` if not empty
- Falls back to `"${routine.exercises.size} exercises"` if empty

### Exercise Preview List
- Shows first 4 exercises: `routine.exercises.take(4)`
- Format: `"${exercise.name} - ${formatSetReps(exercise.setReps)}"`
- Remaining count: `(routine.exercises.size - 4).coerceAtLeast(0)`
- Shows "+ X more" if remainingCount > 0

### Set/Rep Formatting (formatSetReps)

```kotlin
// Algorithm:
1. Group consecutive identical reps: [10, 10, 8, 8, 8] → [(2, 10), (3, 8)]
2. Format each group: "count×reps"
3. Join with ", ": "2×10, 3×8"

// Examples:
[10, 10, 10] → "3×10"
[10, 10, 8] → "2×10, 1×8"
[12, 10, 10, 8, 8, 8] → "1×12, 2×10, 3×8"
```

### Duration Estimation (formatEstimatedDuration)

```kotlin
// Algorithm:
totalSets = sum of all setReps.size
totalReps = sum of all setReps values
totalRestSeconds = sum of (restSeconds × (setReps.size - 1)) for each exercise
estimatedSeconds = (totalReps × 3) + totalRestSeconds  // 3 seconds per rep

// Formatting:
if (minutes < 60): "${minutes} min"
else: "${hours}h ${remainingMinutes}m"

// Examples:
30 min → "30 min"
75 min → "1h 15m"
120 min → "2h 0m"
```

### Exercise Count Display
- Format: `"${routine.exercises.size} exercises • ${duration}"`
- Uses bullet point separator (•)
- Always shows both count and duration

---

## 10. STATE MANAGEMENT

### UI State Variables (in RoutinesTab)

| Variable | Type | Initial | Purpose |
|----------|------|---------|---------|
| showRoutineBuilder | Boolean | false | Controls dialog visibility |
| routineToEdit | Routine? | null | Routine to edit (null = create mode) |

### Props/Parameters (from parent)

| Parameter | Type | Purpose |
|-----------|------|---------|
| routines | List\<Routine\> | List of all user routines |
| exerciseRepository | ExerciseRepository | For exercise data |
| personalRecordRepository | PersonalRecordRepository | For PR data |
| formatWeight | (Float, WeightUnit) -> String | Weight formatting function |
| weightUnit | WeightUnit | User's preferred unit |
| enableVideoPlayback | Boolean | Video playback setting |
| kgToDisplay | (Float, WeightUnit) -> Float | Convert kg to display unit |
| displayToKg | (Float, WeightUnit) -> Float | Convert display unit to kg |
| themeMode | ThemeMode | Dark/Light theme |

### Callbacks (from parent)

| Callback | Parameters | Purpose |
|----------|-----------|---------|
| onStartWorkout | Routine | Navigate to workout screen with routine |
| onDeleteRoutine | String (id) | Delete routine by ID |
| onCreateRoutine | - | (not used - handled internally) |
| onSaveRoutine | Routine | Save new routine |
| onUpdateRoutine | Routine | Update existing routine |

### UI State Transitions

```
INITIAL STATE:
- routines: empty or loaded
- showRoutineBuilder: false
- routineToEdit: null

ACTION: Click FAB or Empty State button
→ showRoutineBuilder = true, routineToEdit = null
→ Dialog opens in CREATE mode

ACTION: Click "Edit" in card menu
→ showRoutineBuilder = true, routineToEdit = routine
→ Dialog opens in EDIT mode

ACTION: Save in dialog
→ IF routineToEdit != null: call onUpdateRoutine()
  ELSE: call onSaveRoutine()
→ showRoutineBuilder = false, routineToEdit = null
→ Dialog closes, list updates automatically

ACTION: Dismiss dialog
→ showRoutineBuilder = false, routineToEdit = null
→ Dialog closes, no changes

ACTION: Click "Delete" in card menu
→ call onDeleteRoutine(routine.id)
→ List updates automatically (parent removes from list)

ACTION: Click "Duplicate" in card menu
→ Create duplicate with new IDs and smart naming
→ call onSaveRoutine(duplicated)
→ List updates automatically (parent adds to list)
```

### State Flow
1. Parent holds `routines: List<Routine>` in ViewModel/StateNotifier
2. Parent passes to RoutinesTab as prop
3. RoutinesTab displays list (reactive)
4. User actions trigger callbacks (onSaveRoutine, onDeleteRoutine, etc.)
5. Parent updates state, recomposes RoutinesTab
6. No local state for routines data (single source of truth in parent)

---

## 11. BEHAVIORAL DETAILS

### On Screen Open
- No special initialization logic
- Immediately displays routines if available
- Shows empty state if routines.isEmpty()
- No loading state (assumes data is ready)

### Empty State Behavior
- Shown when `routines.isEmpty()`
- Centered content with icon, title, message, button
- Clicking button opens RoutineBuilderDialog in create mode
- No special animations or transitions

### List Scrolling
- LazyColumn provides standard scrolling
- No pull-to-refresh
- No infinite scroll (all routines loaded at once)
- No scroll-to-top button

### Card Click
- Immediate navigation to workout screen
- Calls `onStartWorkout(routine)` with selected routine
- Visual feedback via scale animation
- No long-press action

### Overflow Menu
- 3-dot menu in top-right of each card
- Opens DropdownMenu with 3 options
- Menu closes automatically after selection
- Can dismiss by tapping outside

### Creating Routine
- FAB or Empty State button opens RoutineBuilderDialog
- Dialog is full-screen (fillMaxHeight(0.9f))
- Dialog has gradient background matching theme
- Requires name and at least 1 exercise
- Shows validation errors inline
- Save creates new routine, updates list

### Editing Routine
- "Edit" menu item opens RoutineBuilderDialog
- Dialog pre-populated with routine data
- Save updates existing routine
- Cancel discards changes

### Duplicating Routine
- "Duplicate" menu item creates instant copy
- Smart naming algorithm (see Section 7)
- New IDs generated (routine + all exercises)
- Deep copy to avoid reference issues
- useCount reset to 0, lastUsed reset to null
- Immediately saved and added to list

### Deleting Routine
- "Delete" menu item calls onDeleteRoutine(id)
- No confirmation dialog (immediate deletion)
- List updates automatically when parent removes item
- No undo functionality

---

## 12. FULL CODE SNIPPETS

### Main RoutinesTab Composable

```kotlin
@Composable
fun RoutinesTab(
    routines: List<Routine>,
    exerciseRepository: ExerciseRepository,
    personalRecordRepository: PersonalRecordRepository,
    formatWeight: (Float, WeightUnit) -> String,
    weightUnit: WeightUnit,
    enableVideoPlayback: Boolean,
    kgToDisplay: (Float, WeightUnit) -> Float,
    displayToKg: (Float, WeightUnit) -> Float,
    onStartWorkout: (Routine) -> Unit,
    onDeleteRoutine: (String) -> Unit,
    onCreateRoutine: () -> Unit,
    onSaveRoutine: (Routine) -> Unit,
    onUpdateRoutine: (Routine) -> Unit = onSaveRoutine,
    themeMode: ThemeMode,
    modifier: Modifier = Modifier
) {
    var showRoutineBuilder by remember { mutableStateOf(false) }
    var routineToEdit by remember { mutableStateOf<Routine?>(null) }

    val backgroundGradient = if (themeMode == ThemeMode.DARK) {
        Brush.verticalGradient(
            colors = listOf(
                Color(0xFF0F172A), // slate-900
                Color(0xFF1E1B4B), // indigo-950
                Color(0xFF172554)  // blue-950
            )
        )
    } else {
        Brush.verticalGradient(
            colors = listOf(
                Color(0xFFE0E7FF), // indigo-200 - soft lavender
                Color(0xFFFCE7F3), // pink-100 - soft pink
                Color(0xFFDDD6FE)  // violet-200 - soft violet
            )
        )
    }

    Box(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundGradient)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(20.dp)
        ) {
            Text(
                "My Routines",
                style = MaterialTheme.typography.headlineMedium,
                fontWeight = FontWeight.Bold,
                color = MaterialTheme.colorScheme.onSurface
            )
            Spacer(modifier = Modifier.height(Spacing.medium))

            if (routines.isEmpty()) {
                EmptyState(
                    icon = Icons.Default.FitnessCenter,
                    title = "No Routines Yet",
                    message = "Create your first workout routine to get started",
                    actionText = "Create Your First Routine",
                    onAction = {
                        routineToEdit = null
                        showRoutineBuilder = true
                    }
                )
            } else {
                LazyColumn(
                    verticalArrangement = Arrangement.spacedBy(Spacing.small)
                ) {
                    items(routines, key = { it.id }) { routine ->
                        RoutineCard(
                            routine = routine,
                            onStartWorkout = { onStartWorkout(routine) },
                            onEdit = {
                                routineToEdit = routine
                                showRoutineBuilder = true
                            },
                            onDelete = { onDeleteRoutine(routine.id) },
                            onDuplicate = { /* see full duplicate logic in source */ }
                        )
                    }
                }
            }
        }

        // Extended Floating Action Button for creating new routine
        ExtendedFloatingActionButton(
            onClick = {
                routineToEdit = null
                showRoutineBuilder = true
            },
            modifier = Modifier
                .align(Alignment.BottomEnd)
                .padding(Spacing.medium),
            containerColor = MaterialTheme.colorScheme.primary,
            contentColor = MaterialTheme.colorScheme.onPrimary
        ) {
            Icon(
                Icons.Default.Add,
                contentDescription = null
            )
            Spacer(modifier = Modifier.width(Spacing.small))
            Text("New Routine")
        }
    }

    // Show routine builder dialog
    if (showRoutineBuilder) {
        RoutineBuilderDialog(
            routine = routineToEdit,
            onSave = { routine ->
                if (routineToEdit != null) {
                    onUpdateRoutine(routine)
                } else {
                    onSaveRoutine(routine)
                }
                showRoutineBuilder = false
                routineToEdit = null
            },
            onDismiss = {
                showRoutineBuilder = false
                routineToEdit = null
            },
            // ... other params
        )
    }
}
```

### Routine Card Composable

```kotlin
@Composable
fun RoutineCard(
    routine: Routine,
    onStartWorkout: () -> Unit,
    onEdit: () -> Unit,
    onDelete: () -> Unit,
    onDuplicate: () -> Unit
) {
    var isPressed by remember { mutableStateOf(false) }
    val scale by animateFloatAsState(
        targetValue = if (isPressed) 0.99f else 1f,
        animationSpec = spring(
            dampingRatio = Spring.DampingRatioMediumBouncy,
            stiffness = 400f
        ),
        label = "scale"
    )

    Card(
        onClick = onStartWorkout,
        modifier = Modifier
            .fillMaxWidth()
            .scale(scale),
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = if (isPressed) 2.dp else 4.dp
        ),
        border = BorderStroke(1.dp, Color(0xFFF5F3FF))
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // 64dp Gradient Icon (purple gradient)
            Box(
                modifier = Modifier
                    .size(64.dp)
                    .shadow(4.dp, RoundedCornerShape(12.dp))
                    .background(
                        Brush.linearGradient(
                            colors = listOf(Color(0xFF9333EA), Color(0xFF7E22CE))
                        ),
                        RoundedCornerShape(12.dp)
                    ),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.FitnessCenter,
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.onPrimary,
                    modifier = Modifier.size(32.dp)
                )
            }

            // Content Column
            Column(
                modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.spacedBy(4.dp)
            ) {
                Text(
                    text = routine.name,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onSurface
                )
                Text(
                    text = routine.description.ifEmpty { "${routine.exercises.size} exercises" },
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )

                // Exercise list preview (first 4)
                val exercisesToShow = routine.exercises.take(4)
                val remainingCount = (routine.exercises.size - exercisesToShow.size).coerceAtLeast(0)

                Column(
                    verticalArrangement = Arrangement.spacedBy(2.dp)
                ) {
                    exercisesToShow.forEach { routineExercise ->
                        Text(
                            text = "${routineExercise.exercise.name} - ${formatSetReps(routineExercise.setReps)}",
                            style = MaterialTheme.typography.labelSmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                    if (remainingCount > 0) {
                        Text(
                            text = "+ $remainingCount more",
                            style = MaterialTheme.typography.labelSmall,
                            color = MaterialTheme.colorScheme.primary,
                            fontWeight = FontWeight.Medium
                        )
                    }
                }

                Text(
                    text = "${routine.exercises.size} exercises • ${formatEstimatedDuration(routine)}",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.primary
                )
            }

            // Arrow Icon
            Surface(
                shape = RoundedCornerShape(50),
                color = Color(0xFFF5F3FF),
                modifier = Modifier.size(36.dp)
            ) {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier = Modifier.fillMaxSize()
                ) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowForward,
                        contentDescription = "Navigate",
                        tint = Color(0xFF9333EA),
                        modifier = Modifier.size(16.dp)
                    )
                }
            }
        }

        // Overflow menu (top-right) for edit/duplicate/delete
        var showMenu by remember { mutableStateOf(false) }
        Box(modifier = Modifier.fillMaxWidth()) {
            IconButton(
                onClick = { showMenu = !showMenu },
                modifier = Modifier.align(Alignment.TopEnd)
            ) {
                Icon(Icons.Default.MoreVert, contentDescription = "Menu")
            }

            DropdownMenu(
                expanded = showMenu,
                onDismissRequest = { showMenu = false }
            ) {
                DropdownMenuItem(
                    text = { Text("Edit") },
                    onClick = { showMenu = false; onEdit() },
                    leadingIcon = { Icon(Icons.Default.Edit, null) }
                )
                DropdownMenuItem(
                    text = { Text("Duplicate") },
                    onClick = { showMenu = false; onDuplicate() },
                    leadingIcon = { Icon(Icons.Default.ContentCopy, null) }
                )
                DropdownMenuItem(
                    text = { Text("Delete") },
                    onClick = { showMenu = false; onDelete() },
                    leadingIcon = { Icon(Icons.Default.Delete, null, tint = MaterialTheme.colorScheme.error) }
                )
            }
        }
    }

    LaunchedEffect(isPressed) {
        if (isPressed) {
            kotlinx.coroutines.delay(100)
            isPressed = false
        }
    }
}
```

### Helper Functions

```kotlin
// Format set/rep display: [10, 10, 8] → "2×10, 1×8"
private fun formatSetReps(setReps: List<Int>): String {
    if (setReps.isEmpty()) return "0 sets"

    // Group consecutive identical reps
    val groups = mutableListOf<Pair<Int, Int>>() // Pair of (count, reps)
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

    // Format as "3×10, 2×8"
    return groups.joinToString(", ") { (count, reps) -> "${count}×${reps}" }
}

// Estimate workout duration: 3 seconds per rep + rest time
private fun formatEstimatedDuration(routine: Routine): String {
    val totalSets = routine.exercises.sumOf { it.setReps.size }
    val totalReps = routine.exercises.sumOf { exercise -> exercise.setReps.sum() }
    val totalRestSeconds = routine.exercises.sumOf { it.restSeconds * (it.setReps.size - 1) }

    val estimatedSeconds = (totalReps * 3) + totalRestSeconds // 3 seconds per rep estimate
    val minutes = estimatedSeconds / 60

    return if (minutes < 60) {
        "${minutes} min"
    } else {
        val hours = minutes / 60
        val remainingMinutes = minutes % 60
        "${hours}h ${remainingMinutes}m"
    }
}
```

### Duplicate Logic (Complete)

```kotlin
onDuplicate = {
    // Generate new IDs explicitly and create deep copies
    val newRoutineId = java.util.UUID.randomUUID().toString()
    val newExercises = routine.exercises.map { exercise ->
        exercise.copy(
            id = java.util.UUID.randomUUID().toString(),
            // Deep copy the Exercise object to avoid any shared references
            exercise = exercise.exercise.copy()
        )
    }

    // Smart duplicate naming: extract base name and find next copy number
    val baseName = routine.name.replace(Regex(""" \(Copy( \d+)?\)$"""), "")
    val copyPattern = Regex("""^${Regex.escape(baseName)} \(Copy( (\d+))?\)$""")
    val existingCopyNumbers = routines
        .mapNotNull { r ->
            when {
                r.name == baseName -> 0 // Original has number 0
                r.name == "$baseName (Copy)" -> 1 // First copy is 1
                else -> copyPattern.find(r.name)?.groups?.get(2)?.value?.toIntOrNull()
            }
        }
    val nextCopyNumber = (existingCopyNumbers.maxOrNull() ?: 0) + 1
    val newName = if (nextCopyNumber == 1) {
        "$baseName (Copy)"
    } else {
        "$baseName (Copy $nextCopyNumber)"
    }

    val duplicated = routine.copy(
        id = newRoutineId,
        name = newName,
        createdAt = System.currentTimeMillis(),
        useCount = 0,
        lastUsed = null,
        exercises = newExercises
    )
    onSaveRoutine(duplicated)
}
```

### Domain Models

```kotlin
data class Routine(
    val id: String,
    val name: String,
    val description: String = "",
    val exercises: List<RoutineExercise> = emptyList(),
    val createdAt: Long = System.currentTimeMillis(),
    val lastUsed: Long? = null,
    val useCount: Int = 0
)

data class RoutineExercise(
    val id: String,
    val exercise: Exercise,
    val cableConfig: CableConfiguration,
    val orderIndex: Int,
    val setReps: List<Int> = listOf(10, 10, 10),
    val weightPerCableKg: Float,
    val setWeightsPerCableKg: List<Float> = emptyList(),
    val workoutType: WorkoutType = WorkoutType.Program(ProgramMode.OldSchool),
    val eccentricLoad: EccentricLoad = EccentricLoad.LOAD_100,
    val echoLevel: EchoLevel = EchoLevel.HARDER,
    val progressionKg: Float = 0f,
    val restSeconds: Int = 60,
    val notes: String = "",
    val duration: Int? = null
) {
    val sets: Int get() = setReps.size
    val reps: Int get() = setReps.firstOrNull() ?: 10
}
```

---

## CRITICAL IMPLEMENTATION NOTES

### 1. Duplicate Deep Copy Requirements
- **MUST** generate new UUID for routine
- **MUST** generate new UUIDs for all exercises
- **MUST** deep copy Exercise objects (use `.copy()`)
- **MUST** reset useCount = 0 and lastUsed = null
- **MUST** update createdAt to current time
- **CRITICAL:** Avoid shared references to prevent mutation bugs

### 2. Smart Naming Algorithm
- Handle base name extraction correctly (regex)
- Track existing copy numbers (0 for original, 1+ for copies)
- Generate next available number
- Format: "Name" → "Name (Copy)" → "Name (Copy 2)" → etc.

### 3. Set/Rep Formatting Logic
- Group consecutive identical values
- Display as "count×reps" format
- Handle edge cases: empty list, single set, all different

### 4. Duration Estimation
- 3 seconds per rep (reasonable estimate)
- Add rest time: restSeconds × (sets - 1) per exercise
- Format: "X min" or "Xh Ym"

### 5. Gradient Background
- Two gradients: dark mode (blue tones) and light mode (pastel tones)
- Apply to Box container, not screen itself
- Ensure text readability with Material3 color roles

### 6. Card Animation
- Spring animation with MediumBouncy damping
- 1% scale reduction (subtle)
- Auto-reset after 100ms
- Elevation also changes (4dp → 2dp)

### 7. Empty State
- Use reusable EmptyState component
- Large icon (64dp), centered
- Clear call-to-action button
- Consistent spacing (Spacing.medium = 16dp)

### 8. Overflow Menu
- Position: Alignment.TopEnd (overlaid on card)
- 3 items: Edit, Duplicate, Delete
- Delete icon uses error color
- Menu auto-closes after selection

### 9. Exercise Preview
- Show first 4 exercises only
- Display format: "Exercise Name - 3×10"
- Show "+ X more" if remainingCount > 0
- 2dp vertical spacing between lines

### 10. Material 3 Consistency
- Use MaterialTheme.typography for all text
- Use MaterialTheme.colorScheme for all colors
- Use Spacing object for all spacing
- Follow 8dp grid system

---

## FLUTTER TRANSLATION CHECKLIST

- [ ] Create Routine and RoutineExercise models with freezed
- [ ] Implement formatSetReps helper function
- [ ] Implement formatEstimatedDuration helper function
- [ ] Implement duplicate logic with smart naming
- [ ] Create EmptyState widget (if not exists)
- [ ] Implement gradient backgrounds (dark/light)
- [ ] Create RoutineCard widget with press animation
- [ ] Implement 64dp gradient icon box
- [ ] Implement exercise preview list (first 4)
- [ ] Create overflow menu (PopupMenuButton)
- [ ] Implement ExtendedFAB with icon + text
- [ ] Connect to RoutineBuilderDialog (port separately)
- [ ] Wire up all callbacks (onStartWorkout, onSaveRoutine, etc.)
- [ ] Test empty state behavior
- [ ] Test duplicate naming algorithm
- [ ] Test card press animation
- [ ] Verify all spacing values (8dp grid)
- [ ] Verify all colors match exactly
- [ ] Verify typography matches Material 3
- [ ] Test overflow menu interactions

---

**END OF ANALYSIS**

This document provides complete specifications for pixel-perfect Flutter implementation of the Routines Tab screen from the Kotlin VitruvianRedux app.
