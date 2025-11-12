# Programs Tab - Extreme Detail Analysis for Flutter Porting

**Document Version:** 1.0
**Analysis Date:** 2025-11-12
**Analyzed Files:**
- `WeeklyProgramsScreen.kt` (Main screen)
- `ProgramBuilderScreen.kt` (Program editor screen)
- `RoutinesTab.kt` (Comparison reference)
- `MainViewModel.kt` (State management)
- `WorkoutDao.kt` (Database operations)
- `WorkoutEntities.kt` (Data models)

**Screen Position:** 7/16 in systematic UI matching
**Previous Screen:** Routines Tab (completed)

---

## 1. SCREEN IDENTIFICATION

### Primary Screen Components

#### WeeklyProgramsScreen.kt
- **Purpose:** View and manage weekly workout programs
- **Location:** `presentation/screen/WeeklyProgramsScreen.kt`
- **Lines:** 469 lines
- **Main Composable:** `WeeklyProgramsScreen()` (lines 38-244)
- **Related Composables:**
  - `ActiveProgramCard()` (lines 250-347) - Shows active program with today's workout
  - `ProgramListItem()` (lines 353-454) - List item for each program

#### ProgramBuilderScreen.kt
- **Purpose:** Create or edit a weekly program (assign routines to days)
- **Location:** `presentation/screen/ProgramBuilderScreen.kt`
- **Lines:** 476 lines
- **Main Composable:** `ProgramBuilderScreen()` (lines 41-400)
- **Related Composables:**
  - `DayRoutineCard()` (lines 406-475) - Card for each day of the week

### Data Models

#### WeeklyProgramEntity
```kotlin
@Entity(tableName = "weekly_programs")
data class WeeklyProgramEntity(
    @PrimaryKey val id: String = UUID.randomUUID().toString(),
    val title: String,
    val notes: String? = null,
    val isActive: Boolean = false,
    val lastUsed: Long? = null,
    val createdAt: Long = System.currentTimeMillis()
)
```

#### ProgramDayEntity
```kotlin
@Entity(
    tableName = "program_days",
    foreignKeys = [
        ForeignKey(entity = WeeklyProgramEntity::class, ...),
        ForeignKey(entity = RoutineEntity::class, ...)
    ]
)
data class ProgramDayEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val programId: String,
    val dayOfWeek: Int, // 1=Monday, 7=Sunday (DayOfWeek.value)
    val routineId: String
)
```

#### WeeklyProgramWithDays
```kotlin
data class WeeklyProgramWithDays(
    @Embedded val program: WeeklyProgramEntity,
    @Relation(parentColumn = "id", entityColumn = "programId")
    val days: List<ProgramDayEntity>
)
```

### ViewModel State (MainViewModel.kt)

```kotlin
// Lines 128-134
val weeklyPrograms: StateFlow<List<WeeklyProgramWithDays>> =
    workoutRepository.getAllPrograms()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = emptyList()
        )

// Lines 136-141
val activeProgram: StateFlow<WeeklyProgramWithDays?> =
    workoutRepository.getActiveProgram()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = null
        )

// Methods
fun saveProgram(program: WeeklyProgramWithDays) // Line 1665
fun deleteProgram(programId: String) // Line 1679
fun activateProgram(programId: String) // Line 1693
```

---

## 2. COMPLETE LAYOUT HIERARCHY

### WeeklyProgramsScreen Layout Tree

```
Scaffold
├── TopAppBar
│   ├── navigationIcon: IconButton
│   │   └── Icon (ArrowBack)
│   └── title: Text ("Weekly Programs")
└── Content (padding applied)
    └── Box (fillMaxSize, backgroundGradient)
        ├── LazyColumn (fillMaxSize, padding: medium, spacing: medium)
        │   ├── item: ActiveProgramCard OR NoActiveProgramCard
        │   │   └── Card (surface, 16dp radius, 4dp elevation)
        │   │       └── Column (padding: large/medium)
        │   │           ├── Row (title + edit button)
        │   │           ├── HorizontalDivider
        │   │           ├── Text ("Today: {day}")
        │   │           └── Button ("Start Today's Workout") OR Text ("Rest day")
        │   │
        │   ├── item: Programs List Header
        │   │   └── Column (spacing: medium)
        │   │       ├── Text ("All Programs")
        │   │       └── OutlinedButton ("Create Program")
        │   │
        │   └── items: ProgramListItem (foreach program)
        │       └── Card (clickable, surface, 16dp radius, 4dp elevation)
        │           ├── Row (padding: medium)
        │           │   ├── Column (weight 1f)
        │           │   │   ├── Text (program title)
        │           │   │   └── Text ("{n} workout days")
        │           │   └── Row (actions)
        │           │       ├── IconButton (Delete)
        │           │       └── TextButton ("Activate") OR Surface ("Active")
        │           └── AlertDialog (delete confirmation, if shown)
        │
        ├── ConnectingOverlay (if isAutoConnecting)
        └── ConnectionErrorDialog (if connectionError != null)
```

### ProgramBuilderScreen Layout Tree

```
Scaffold
├── TopAppBar
│   ├── navigationIcon: IconButton (ArrowBack)
│   ├── title: TextField (if editing) OR Text (program name)
│   └── actions
│       ├── IconButton (Edit/Check name)
│       └── IconButton (Done - save program)
└── Content (padding applied)
    └── Box (fillMaxSize, backgroundGradient)
        ├── LazyColumn (fillMaxSize, padding: medium, spacing: medium)
        │   ├── item: Text ("Schedule workouts for each day")
        │   │
        │   ├── itemsIndexed: DayRoutineCard (7 cards, one per day)
        │   │   └── Card (clickable, surface, 16dp radius, 4dp elevation)
        │   │       └── Row (padding: medium)
        │   │           ├── Column (weight 1f)
        │   │           │   ├── Text (day name - "Monday", "Tuesday", etc.)
        │   │           │   ├── Text (routine name) OR Text ("Rest day")
        │   │           │   └── Text ("{n} exercises") [if routine assigned]
        │   │           └── IconButton (Clear) OR Icon (Add)
        │   │
        │   └── item: Summary Card
        │       └── Card (surface, 16dp radius, 4dp elevation)
        │           └── Column (padding: medium)
        │               ├── Text ("Program Summary")
        │               └── Text ("{n} workout days, {m} rest days")
        │
        ├── Box (bottom gradient scroll indicator, if canScrollDown)
        │   └── Surface (rounded, bottom-centered)
        │       └── Icon (KeyboardArrowDown)
        │
        ├── AlertDialog (routine picker, if shown)
        │   └── LazyColumn (list of routines)
        │       └── Card (foreach routine, clickable)
        │           └── Column (padding: medium)
        │               ├── Text (routine name)
        │               └── Text ("{n} exercises")
        │
        ├── ConnectingOverlay (if isAutoConnecting)
        └── ConnectionErrorDialog (if connectionError != null)
```

---

## 3. ALL UI ELEMENTS WITH EXACT PROPERTIES

### WeeklyProgramsScreen Elements

#### TopAppBar (Lines 52-66)
```kotlin
TopAppBar(
    title = { Text("Weekly Programs") },
    navigationIcon = {
        IconButton(onClick = { navController.navigateUp() }) {
            Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
        }
    },
    colors = TopAppBarDefaults.topAppBarColors(
        containerColor = MaterialTheme.colorScheme.surface,
        titleContentColor = MaterialTheme.colorScheme.onSurface,
        navigationIconContentColor = MaterialTheme.colorScheme.onSurface,
        actionIconContentColor = MaterialTheme.colorScheme.onSurface
    )
)
```

#### Active Program Card (Lines 112-131)
```kotlin
ActiveProgramCard(
    program = activeProgram!!,
    onStartTodayWorkout = { /* ... */ },
    onViewProgram = { /* ... */ }
)
```

**ActiveProgramCard Details (Lines 250-347):**

1. **Container Card:**
   - Modifier: `fillMaxWidth()`
   - Colors: `containerColor = MaterialTheme.colorScheme.surface`
   - Shape: `RoundedCornerShape(16.dp)`
   - Elevation: `4.dp` default
   - Border: `1.dp, Color(0xFFF5F3FF)` (very light lavender)

2. **Header Row (Lines 276-301):**
   ```kotlin
   Row(
       modifier = Modifier.fillMaxWidth(),
       horizontalArrangement = Arrangement.SpaceBetween,
       verticalAlignment = Alignment.CenterVertically
   ) {
       Column {
           Text(
               "Active Program",
               style = MaterialTheme.typography.labelMedium,
               color = MaterialTheme.colorScheme.onPrimaryContainer.copy(alpha = 0.7f)
           )
           Text(
               program.program.title,
               style = MaterialTheme.typography.titleLarge,
               fontWeight = FontWeight.Bold,
               color = MaterialTheme.colorScheme.onPrimaryContainer
           )
       }
       IconButton(onClick = onViewProgram) {
           Icon(
               Icons.Default.Edit,
               contentDescription = "View program",
               tint = MaterialTheme.colorScheme.onPrimaryContainer
           )
       }
   }
   ```

3. **Divider (Line 305):**
   ```kotlin
   HorizontalDivider(color = MaterialTheme.colorScheme.outlineVariant)
   ```

4. **Today Section (Lines 309-344):**
   ```kotlin
   Text(
       "Today: ${today.getDisplayName(TextStyle.FULL, Locale.getDefault())}",
       style = MaterialTheme.typography.titleSmall,
       fontWeight = FontWeight.Medium,
       color = MaterialTheme.colorScheme.onSurface
   )

   if (hasWorkoutToday) {
       Text(
           "Workout scheduled",
           style = MaterialTheme.typography.bodyLarge,
           color = MaterialTheme.colorScheme.onSurface
       )
       Button(
           onClick = onStartTodayWorkout,
           modifier = Modifier.fillMaxWidth(),
           colors = ButtonDefaults.buttonColors(
               containerColor = MaterialTheme.colorScheme.primary
           )
       ) {
           Icon(Icons.Default.PlayArrow, contentDescription = null)
           Spacer(modifier = Modifier.width(Spacing.small))
           Text("Start Today's Workout")
       }
   } else {
       Text(
           "Rest day",
           style = MaterialTheme.typography.bodyMedium,
           color = MaterialTheme.colorScheme.onSurfaceVariant
       )
   }
   ```

#### No Active Program Card (Lines 134-166)
```kotlin
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
    shape = RoundedCornerShape(16.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(Spacing.large), // 24.dp
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Icon(
            Icons.Default.Info,
            contentDescription = null,
            tint = MaterialTheme.colorScheme.onSurfaceVariant,
            modifier = Modifier.size(48.dp)
        )
        Spacer(modifier = Modifier.height(Spacing.small)) // 8.dp
        Text(
            "No active program",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold
        )
        Text(
            "Create a program or activate an existing one",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}
```

#### Programs List Header (Lines 170-192)
```kotlin
Column(
    modifier = Modifier.fillMaxWidth(),
    verticalArrangement = Arrangement.spacedBy(Spacing.medium) // 16.dp
) {
    Text(
        "All Programs",
        style = MaterialTheme.typography.titleMedium,
        fontWeight = FontWeight.Bold
    )
    OutlinedButton(
        onClick = { navController.navigate(...) },
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp)
    ) {
        Icon(Icons.Default.Add, contentDescription = "Create program", modifier = Modifier.size(20.dp))
        Spacer(modifier = Modifier.width(Spacing.small)) // 8.dp
        Text("Create Program")
    }
}
```

#### Empty State (Lines 196-207)
```kotlin
EmptyState(
    icon = Icons.Default.DateRange,
    title = "No Programs Yet",
    message = "Create your first weekly program to follow a structured training schedule",
    actionText = "Create Your First Program",
    onAction = { navController.navigate(...) },
    modifier = Modifier.fillMaxWidth()
)
```

#### Program List Item (Lines 210-226, 353-454)
```kotlin
ProgramListItem(
    program = program,
    isActive = program.program.id == activeProgram?.program?.id,
    onClick = { /* navigate to builder */ },
    onActivate = { viewModel.activateProgram(program.program.id) },
    onDelete = { viewModel.deleteProgram(program.program.id) }
)
```

**ProgramListItem Details:**

1. **Container Card:**
   ```kotlin
   Card(
       modifier = Modifier
           .fillMaxWidth()
           .clickable(onClick = onClick),
       colors = CardDefaults.cardColors(
           containerColor = MaterialTheme.colorScheme.surface
       ),
       shape = RoundedCornerShape(16.dp),
       elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
       border = BorderStroke(1.dp, Color(0xFFF5F3FF))
   )
   ```

2. **Content Row (Lines 373-425):**
   ```kotlin
   Row(
       modifier = Modifier
           .fillMaxWidth()
           .padding(Spacing.medium), // 16.dp
       horizontalArrangement = Arrangement.SpaceBetween,
       verticalAlignment = Alignment.CenterVertically
   ) {
       Column(modifier = Modifier.weight(1f)) {
           Text(
               program.program.title,
               style = MaterialTheme.typography.titleMedium,
               fontWeight = FontWeight.Bold
           )
           Text(
               "${program.days.size} workout days",
               style = MaterialTheme.typography.bodySmall,
               color = MaterialTheme.colorScheme.onSurfaceVariant
           )
       }

       Row(
           horizontalArrangement = Arrangement.spacedBy(Spacing.small), // 8.dp
           verticalAlignment = Alignment.CenterVertically
       ) {
           // Delete button
           IconButton(onClick = { showDeleteDialog = true }) {
               Icon(
                   Icons.Default.Delete,
                   contentDescription = "Delete program",
                   tint = MaterialTheme.colorScheme.error
               )
           }

           // Activate/Active status
           if (!isActive) {
               TextButton(onClick = onActivate) {
                   Text("Activate")
               }
           } else {
               Surface(
                   color = MaterialTheme.colorScheme.primary,
                   shape = RoundedCornerShape(8.dp)
               ) {
                   Text(
                       "Active",
                       modifier = Modifier.padding(horizontal = 12.dp, vertical = 6.dp),
                       style = MaterialTheme.typography.labelMedium,
                       color = MaterialTheme.colorScheme.onPrimary
                   )
               }
           }
       }
   }
   ```

3. **Delete Confirmation Dialog (Lines 429-453):**
   ```kotlin
   AlertDialog(
       onDismissRequest = { showDeleteDialog = false },
       title = { Text("Delete Program") },
       text = { Text("Are you sure you want to delete \"${program.program.title}\"? This action cannot be undone.") },
       confirmButton = {
           TextButton(
               onClick = { onDelete(); showDeleteDialog = false },
               colors = ButtonDefaults.textButtonColors(
                   contentColor = MaterialTheme.colorScheme.error
               )
           ) {
               Text("Delete")
           }
       },
       dismissButton = {
           TextButton(onClick = { showDeleteDialog = false }) {
               Text("Cancel")
           }
       }
   )
   ```

### ProgramBuilderScreen Elements

#### TopAppBar (Lines 95-166)
```kotlin
TopAppBar(
    title = {
        if (isEditingName) {
            TextField(
                value = programName,
                onValueChange = { programName = it },
                singleLine = true,
                colors = TextFieldDefaults.colors(
                    focusedContainerColor = MaterialTheme.colorScheme.primary,
                    unfocusedContainerColor = MaterialTheme.colorScheme.primary,
                    focusedTextColor = MaterialTheme.colorScheme.onPrimary,
                    unfocusedTextColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        } else {
            Text(programName)
        }
    },
    navigationIcon = {
        IconButton(onClick = { navController.navigateUp() }) {
            Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
        }
    },
    actions = {
        IconButton(onClick = { isEditingName = !isEditingName }) {
            Icon(
                if (isEditingName) Icons.Default.Check else Icons.Default.Edit,
                contentDescription = if (isEditingName) "Save name" else "Edit name"
            )
        }
        IconButton(onClick = { /* Save program logic (lines 127-155) */ }) {
            Icon(Icons.Default.Done, contentDescription = "Save program")
        }
    },
    colors = TopAppBarDefaults.topAppBarColors(
        containerColor = MaterialTheme.colorScheme.surface,
        titleContentColor = MaterialTheme.colorScheme.onSurface,
        navigationIconContentColor = MaterialTheme.colorScheme.onSurface,
        actionIconContentColor = MaterialTheme.colorScheme.onSurface
    )
)
```

#### Header Text (Lines 222-228)
```kotlin
Text(
    "Schedule workouts for each day",
    style = MaterialTheme.typography.titleMedium,
    fontWeight = FontWeight.Bold
)
```

#### Day Routine Card (Lines 232-245, 406-475)
```kotlin
DayRoutineCard(
    day = day,
    routine = dailyRoutines[day],
    onSelectRoutine = { selectedDay = day; showRoutinePicker = true },
    onClearRoutine = { dailyRoutines = dailyRoutines.toMutableMap().apply { put(day, null) } }
)
```

**DayRoutineCard Details:**

```kotlin
Card(
    modifier = Modifier
        .fillMaxWidth()
        .clickable(onClick = onSelectRoutine),
    colors = CardDefaults.cardColors(
        containerColor = MaterialTheme.colorScheme.surface
    ),
    shape = RoundedCornerShape(16.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(Spacing.medium), // 16.dp
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column(modifier = Modifier.weight(1f)) {
            Text(
                day.getDisplayName(TextStyle.FULL, Locale.getDefault()),
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold
            )

            if (routine != null) {
                Spacer(modifier = Modifier.height(Spacing.extraSmall)) // 4.dp
                Text(
                    routine.name,
                    style = MaterialTheme.typography.bodyMedium
                )
                Text(
                    "${routine.exercises.size} exercises",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            } else {
                Spacer(modifier = Modifier.height(Spacing.extraSmall)) // 4.dp
                Text(
                    "Rest day",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }

        if (routine != null) {
            IconButton(onClick = onClearRoutine) {
                Icon(
                    Icons.Default.Clear,
                    contentDescription = "Clear routine",
                    tint = MaterialTheme.colorScheme.error
                )
            }
        } else {
            Icon(
                Icons.Default.Add,
                contentDescription = "Add routine",
                tint = MaterialTheme.colorScheme.primary
            )
        }
    }
}
```

#### Summary Card (Lines 250-281)
```kotlin
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
    shape = RoundedCornerShape(16.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
    border = BorderStroke(1.dp, Color(0xFFF5F3FF))
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(Spacing.medium) // 16.dp
    ) {
        Text(
            "Program Summary",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold,
            color = MaterialTheme.colorScheme.onSurface
        )
        Spacer(modifier = Modifier.height(Spacing.small)) // 8.dp

        val workoutDays = dailyRoutines.values.filterNotNull().size
        val restDays = 7 - workoutDays

        Text(
            "$workoutDays workout days, $restDays rest days",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurface
        )
    }
}
```

#### Scroll Indicator (Lines 285-321)
```kotlin
if (canScrollDown) {
    val bottomColor = if (useDarkColors) Color(0xFF172554) else Color(0xFFDFF6FF)
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(80.dp)
            .align(Alignment.BottomCenter)
            .background(
                Brush.verticalGradient(
                    colors = listOf(
                        Color.Transparent,
                        bottomColor.copy(alpha = 0.85f),
                        bottomColor
                    )
                )
            )
            .zIndex(1f)
    ) {
        Surface(
            modifier = Modifier
                .align(Alignment.BottomCenter)
                .padding(bottom = 12.dp),
            shape = RoundedCornerShape(20.dp),
            color = MaterialTheme.colorScheme.primary.copy(alpha = 0.15f)
        ) {
            Icon(
                imageVector = Icons.Default.KeyboardArrowDown,
                contentDescription = "Scroll down for more",
                modifier = Modifier
                    .padding(8.dp)
                    .size(28.dp),
                tint = MaterialTheme.colorScheme.primary
            )
        }
    }
}
```

#### Routine Picker Dialog (Lines 326-385)
```kotlin
AlertDialog(
    onDismissRequest = { showRoutinePicker = false },
    title = { Text("Select Routine for ${selectedDay!!.getDisplayName(TextStyle.FULL, Locale.getDefault())}") },
    text = {
        LazyColumn(
            modifier = Modifier.fillMaxWidth(),
            verticalArrangement = Arrangement.spacedBy(Spacing.small) // 8.dp
        ) {
            if (routines.isEmpty()) {
                item {
                    Text(
                        "No routines available. Create a routine first.",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            } else {
                itemsIndexed(routines) { _, routine ->
                    Card(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable {
                                dailyRoutines = dailyRoutines.toMutableMap().apply {
                                    put(selectedDay!!, routine)
                                }
                                showRoutinePicker = false
                            },
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceVariant),
                        shape = RoundedCornerShape(12.dp)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(Spacing.medium) // 16.dp
                        ) {
                            Text(
                                routine.name,
                                style = MaterialTheme.typography.bodyLarge,
                                fontWeight = FontWeight.Medium
                            )
                            Text(
                                "${routine.exercises.size} exercises",
                                style = MaterialTheme.typography.bodySmall,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }
                }
            }
        }
    },
    confirmButton = {},
    dismissButton = {
        TextButton(onClick = { showRoutinePicker = false }) {
            Text("Cancel")
        }
    }
)
```

---

## 4. ALL COLORS (WITH HEX CODES)

### Background Gradients

#### Dark Mode (Lines 75-82)
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFF0F172A), // slate-900 (top)
        Color(0xFF1E1B4B), // indigo-950 (middle)
        Color(0xFF172554)  // blue-950 (bottom)
    )
)
```

#### Light Mode (Lines 84-90)
```kotlin
Brush.verticalGradient(
    colors = listOf(
        Color(0xFFE0E7FF), // soft indigo (top)
        Color(0xFFEDE9FE), // soft violet (middle)
        Color(0xFFDFF6FF)  // soft sky blue (bottom)
    )
)
```

### Card & Surface Colors

| Element | Color | Source |
|---------|-------|--------|
| Card container | `MaterialTheme.colorScheme.surface` | Dynamic |
| Card border | `Color(0xFFF5F3FF)` | Very light lavender |
| Surface variant | `MaterialTheme.colorScheme.surfaceVariant` | Dynamic |
| Outline variant | `MaterialTheme.colorScheme.outlineVariant` | Dynamic |

### Text Colors

| Element | Color | Source |
|---------|-------|--------|
| Primary text | `MaterialTheme.colorScheme.onSurface` | Dynamic |
| Secondary text | `MaterialTheme.colorScheme.onSurfaceVariant` | Dynamic |
| On primary container | `MaterialTheme.colorScheme.onPrimaryContainer` | Dynamic |
| On primary container (faded) | `onPrimaryContainer.copy(alpha = 0.7f)` | Dynamic + alpha |
| Primary accent | `MaterialTheme.colorScheme.primary` | Dynamic |
| On primary | `MaterialTheme.colorScheme.onPrimary` | Dynamic |
| Error | `MaterialTheme.colorScheme.error` | Dynamic |

### Button & Action Colors

| Element | Color | Source |
|---------|-------|--------|
| Primary button container | `MaterialTheme.colorScheme.primary` | Dynamic |
| Primary button text | `MaterialTheme.colorScheme.onPrimary` | Dynamic |
| Outlined button border | Theme default | Dynamic |
| Text button (error) | `MaterialTheme.colorScheme.error` | Dynamic |
| Active badge background | `MaterialTheme.colorScheme.primary` | Dynamic |
| Active badge text | `MaterialTheme.colorScheme.onPrimary` | Dynamic |

### Icon Colors

| Element | Color | Source |
|---------|-------|--------|
| Default icons | `MaterialTheme.colorScheme.onSurface` | Dynamic |
| Variant icons | `MaterialTheme.colorScheme.onSurfaceVariant` | Dynamic |
| Primary icons | `MaterialTheme.colorScheme.primary` | Dynamic |
| Error icons | `MaterialTheme.colorScheme.error` | Dynamic |
| Empty state icon | `onSurfaceVariant.copy(alpha = 0.6f)` | Dynamic + alpha |

### Scroll Indicator Colors

| Mode | Color | Hex |
|------|-------|-----|
| Dark mode bottom | `Color(0xFF172554)` | blue-950 |
| Light mode bottom | `Color(0xFFDFF6FF)` | soft sky blue |
| Indicator background | `primary.copy(alpha = 0.15f)` | Dynamic + alpha |
| Indicator icon | `MaterialTheme.colorScheme.primary` | Dynamic |

---

## 5. ALL TYPOGRAPHY

### Material 3 Typography Styles Used

| Element | Style | Font Weight | Additional Notes |
|---------|-------|-------------|------------------|
| Screen title (TopAppBar) | Default Text | Default | In TopAppBar title |
| "Active Program" label | `labelMedium` | Default | 70% opacity |
| Program title (active card) | `titleLarge` | `Bold` | OnPrimaryContainer color |
| "Today: {day}" | `titleSmall` | `Medium` | OnSurface color |
| "Workout scheduled" | `bodyLarge` | Default | OnSurface color |
| "Rest day" | `bodyMedium` / `bodySmall` | Default | OnSurfaceVariant color |
| "All Programs" header | `titleMedium` | `Bold` | OnSurface color |
| Program list title | `titleMedium` | `Bold` | OnSurface color |
| "{n} workout days" | `bodySmall` | Default | OnSurfaceVariant color |
| "Active" badge | `labelMedium` | Default | OnPrimary color |
| Dialog title | Default | Default | In AlertDialog |
| Dialog body | Default | Default | In AlertDialog |
| "Schedule workouts..." | `titleMedium` | `Bold` | Builder screen |
| Day name (card) | `titleMedium` | `Bold` | Full day name |
| Routine name (card) | `bodyMedium` | Default | OnSurface color |
| "{n} exercises" | `bodySmall` | Default | OnSurfaceVariant color |
| "Program Summary" | `titleMedium` | `Bold` | OnSurface color |
| Summary stats | `bodyMedium` | Default | OnSurface color |
| Routine picker routine name | `bodyLarge` | `Medium` | In dialog |
| No routines message | `bodyMedium` | Default | OnSurfaceVariant color |

### Font Properties (Material 3 Defaults)

Material 3 typography scale is used throughout. Exact font families depend on theme configuration, but typically:
- **Font Family:** Roboto (Android default) or system font
- **Line Height:** Automatic (based on Material 3 spec)
- **Letter Spacing:** Automatic (based on Material 3 spec)

---

## 6. ALL SPACING VALUES

### Spacing Constants (from Spacing.kt)
```kotlin
object Spacing {
    val extraSmall = 4.dp
    val small = 8.dp
    val medium = 16.dp
    val large = 24.dp
    val extraLarge = 32.dp
    val huge = 48.dp
}
```

### WeeklyProgramsScreen Spacing

| Element | Spacing Type | Value | Location |
|---------|--------------|-------|----------|
| LazyColumn padding | Padding | `medium` (16.dp) | Line 102 |
| LazyColumn item spacing | Vertical arrangement | `medium` (16.dp) | Line 103 |
| ActiveProgramCard padding | Padding | `medium` (16.dp) | Line 274 |
| Header row spacing | Height | `medium` (16.dp) | Line 303 |
| Today section spacing | Height | `small` (8.dp) | Line 316 |
| Button spacing | Height | `medium` (16.dp) | Line 325 |
| Button icon spacing | Width | `small` (8.dp) | Line 335 |
| No active card padding | Padding | `large` (24.dp) | Line 144 |
| No active card icon spacing | Height | `small` (8.dp) | Line 153 |
| Programs header spacing | Vertical arrangement | `medium` (16.dp) | Line 173 |
| Create button icon spacing | Width | `small` (8.dp) | Line 188 |
| Program list item padding | Padding | `medium` (16.dp) | Line 376 |
| Actions row spacing | Horizontal arrangement | `small` (8.dp) | Line 394 |
| Active badge padding | Padding | `12.dp` (h), `6.dp` (v) | Line 418 |

### ProgramBuilderScreen Spacing

| Element | Spacing Type | Value | Location |
|---------|--------------|-------|----------|
| LazyColumn padding | Padding | `medium` (16.dp) | Line 219 |
| LazyColumn item spacing | Vertical arrangement | `medium` (16.dp) | Line 220 |
| Summary card spacing | Height | `medium` (16.dp) | Line 248 |
| Summary card padding | Padding | `medium` (16.dp) | Line 261 |
| Summary title spacing | Height | `small` (8.dp) | Line 269 |
| DayRoutineCard padding | Padding | `medium` (16.dp) | Line 426 |
| Day card day/routine spacing | Height | `extraSmall` (4.dp) | Lines 438, 449 |
| Scroll indicator height | Height | `80.dp` | Line 290 |
| Scroll indicator icon padding | Padding | `8.dp` | Line 315 |
| Scroll indicator icon size | Size | `28.dp` | Line 316 |
| Scroll indicator bottom padding | Padding | `12.dp` | Line 307 |
| Routine picker spacing | Vertical arrangement | `small` (8.dp) | Line 333 |
| Routine card padding | Padding | `medium` (16.dp) | Line 360 |

### Corner Radius Values

| Element | Radius | Location |
|---------|--------|----------|
| Cards (standard) | `16.dp` | Throughout |
| Active badge | `8.dp` | Line 414 |
| Routine picker cards | `12.dp` | Line 355 |
| Scroll indicator | `20.dp` | Line 308 |

### Elevation Values

| Element | Elevation | Location |
|---------|-----------|----------|
| Cards (default) | `4.dp` | Throughout |
| Cards (none specified) | Default (4.dp) | Material 3 default |

---

## 7. ALL INTERACTIONS

### WeeklyProgramsScreen Interactions

#### Navigation
1. **Back Button (TopAppBar):**
   - Action: `navController.navigateUp()`
   - Location: Line 55

2. **View Program (Active Card Edit Icon):**
   - Action: Navigate to ProgramBuilder with program ID
   - Code: `navController.navigate(NavigationRoutes.ProgramBuilder.createRoute(activeProgram!!.program.id))`
   - Location: Line 126-128

3. **Create Program Button:**
   - Action: Navigate to ProgramBuilder (new program)
   - Code: `navController.navigate(NavigationRoutes.ProgramBuilder.createRoute())`
   - Location: Line 182

4. **Program List Item Click:**
   - Action: Navigate to ProgramBuilder with program ID
   - Code: `navController.navigate(NavigationRoutes.ProgramBuilder.createRoute(program.program.id))`
   - Location: Lines 214-216

#### Workout Actions
1. **Start Today's Workout:**
   - Action: Ensure BLE connection, load routine, start workout
   - Code (Lines 114-123):
   ```kotlin
   viewModel.ensureConnection(
       onConnected = {
           viewModel.loadRoutineById(routineId)
           viewModel.startWorkout()
       },
       onFailed = { /* Error shown via StateFlow */ }
   )
   ```

#### Program Management
1. **Activate Program:**
   - Action: `viewModel.activateProgram(program.program.id)`
   - Location: Line 219

2. **Delete Program (Icon Click):**
   - Action: Show delete confirmation dialog
   - Location: Line 398

3. **Delete Program (Confirm):**
   - Action: `viewModel.deleteProgram(program.program.id)`
   - Location: Lines 436-438

4. **Cancel Delete:**
   - Action: Dismiss dialog
   - Location: Line 449

#### Connection Overlays
1. **Cancel Auto-Connecting:**
   - Action: `viewModel.cancelAutoConnecting()`
   - Location: Line 232

2. **Dismiss Connection Error:**
   - Action: `viewModel.clearConnectionError()`
   - Location: Line 239

### ProgramBuilderScreen Interactions

#### Navigation
1. **Back Button:**
   - Action: `navController.navigateUp()`
   - Location: Line 115

2. **Save Program:**
   - Action: Collect program data, save to database via ViewModel, navigate back
   - Code (Lines 127-154):
   ```kotlin
   val programEntity = WeeklyProgramEntity(
       id = if (programId == "new") UUID.randomUUID().toString() else programId,
       title = programName,
       notes = null,
       isActive = false,
       createdAt = System.currentTimeMillis()
   )

   val programDays = dailyRoutines.entries
       .filter { (_, routine) -> routine != null }
       .map { (day, routine) ->
           ProgramDayEntity(
               programId = programEntity.id,
               dayOfWeek = day.value, // MONDAY=1 to SUNDAY=7
               routineId = routine!!.id
           )
       }

   viewModel.saveProgram(WeeklyProgramWithDays(program = programEntity, days = programDays))
   navController.navigateUp()
   ```

#### Name Editing
1. **Toggle Edit Name:**
   - Action: Toggle `isEditingName` state
   - Location: Line 120

2. **Edit Program Name:**
   - Action: Update `programName` state
   - Location: Line 101

#### Day Assignment
1. **Select Day for Routine:**
   - Action: Set `selectedDay`, show routine picker dialog
   - Code: `selectedDay = day; showRoutinePicker = true`
   - Location: Lines 236-237

2. **Clear Routine:**
   - Action: Remove routine from day (set to null)
   - Code: `dailyRoutines = dailyRoutines.toMutableMap().apply { put(day, null) }`
   - Location: Lines 240-242

3. **Select Routine from Picker:**
   - Action: Assign routine to selected day, close dialog
   - Code (Lines 349-352):
   ```kotlin
   dailyRoutines = dailyRoutines.toMutableMap().apply {
       put(selectedDay!!, routine)
   }
   showRoutinePicker = false
   ```

4. **Cancel Routine Picker:**
   - Action: Dismiss dialog
   - Location: Line 380

#### Connection Overlays
1. **Cancel Auto-Connecting:**
   - Action: `viewModel.cancelAutoConnecting()`
   - Location: Line 390

2. **Dismiss Connection Error:**
   - Action: `viewModel.clearConnectionError()`
   - Location: Line 397

---

## 8. ANIMATIONS & TRANSITIONS

### WeeklyProgramsScreen
- **No explicit animations** (standard Material 3 implicit animations apply)
- Card elevation changes on press (implicit)
- Dialog enter/exit animations (Material 3 default)
- Navigation transitions (NavController default)

### ProgramBuilderScreen
- **No explicit animations** (standard Material 3 implicit animations apply)
- TextField focus animations (Material 3 default)
- Dialog enter/exit animations (Material 3 default)
- Scroll indicator fade (gradient-based, not animated)
- Navigation transitions (NavController default)

### Comparison with RoutinesTab
RoutinesTab has **explicit spring animation** on card press (Lines 218-225):
```kotlin
val scale by animateFloatAsState(
    targetValue = if (isPressed) 0.99f else 1f,
    animationSpec = spring(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = 400f
    ),
    label = "scale"
)
```

**Programs screens do NOT have this animation** - simpler interaction model.

---

## 9. DATA DISPLAY LOGIC

### Weekly Program Display

#### Data Flow
1. **ViewModel exposes StateFlows:**
   ```kotlin
   val weeklyPrograms: StateFlow<List<WeeklyProgramWithDays>>
   val activeProgram: StateFlow<WeeklyProgramWithDays?>
   ```

2. **Screen collects state:**
   ```kotlin
   val programs by viewModel.weeklyPrograms.collectAsState()
   val activeProgram by viewModel.activeProgram.collectAsState()
   ```

3. **Active program check:**
   ```kotlin
   if (activeProgram != null) {
       // Show ActiveProgramCard
   } else {
       // Show "No active program" card
   }
   ```

#### Today's Workout Logic (Lines 108-111, 255-262)
```kotlin
val today = LocalDate.now().dayOfWeek
val todayDayValue = today.value // MONDAY=1, TUESDAY=2, ..., SUNDAY=7

// Find today's routine ID from program days
val todayRoutineId = program.days.find { it.dayOfWeek == todayDayValue }?.routineId
val hasWorkoutToday = todayRoutineId != null
```

#### Program List Display (Lines 209-226)
```kotlin
items(programs) { program ->
    ProgramListItem(
        program = program,
        isActive = program.program.id == activeProgram?.program?.id,
        onClick = { /* ... */ },
        onActivate = { /* ... */ },
        onDelete = { /* ... */ }
    )
}
```

#### Workout Days Count (Lines 387-390)
```kotlin
Text(
    "${program.days.size} workout days",
    style = MaterialTheme.typography.bodySmall,
    color = MaterialTheme.colorScheme.onSurfaceVariant
)
```

### Program Builder Display

#### Loading Existing Program (Lines 64-92)
```kotlin
LaunchedEffect(programId, programs, routines) {
    if (programId != "new") {
        val existingProgram = programs.find { it.program.id == programId }
        existingProgram?.let { program ->
            programName = program.program.title

            val routineMap = mutableMapOf<DayOfWeek, Routine?>()

            // Initialize all days as rest days
            DayOfWeek.entries.forEach { day ->
                routineMap[day] = null
            }

            // Fill in workout days from program
            program.days.forEach { programDay ->
                val dayOfWeek = DayOfWeek.of(programDay.dayOfWeek)
                val routine = routines.find { it.id == programDay.routineId }
                routineMap[dayOfWeek] = routine
            }

            dailyRoutines = routineMap
        }
    }
}
```

#### Day Assignment State
```kotlin
var dailyRoutines by remember {
    mutableStateOf<Map<DayOfWeek, Routine?>>(
        DayOfWeek.entries.associateWith { null }
    )
}
```

#### Summary Calculation (Lines 271-278)
```kotlin
val workoutDays = dailyRoutines.values.filterNotNull().size
val restDays = 7 - workoutDays

Text(
    "$workoutDays workout days, $restDays rest days",
    style = MaterialTheme.typography.bodyMedium,
    color = MaterialTheme.colorScheme.onSurface
)
```

#### Scroll Detection (Lines 197-207)
```kotlin
val canScrollDown by remember {
    derivedStateOf {
        val layoutInfo = listState.layoutInfo
        val lastVisibleItem = layoutInfo.visibleItemsInfo.lastOrNull()

        lastVisibleItem?.let {
            it.index < layoutInfo.totalItemsCount - 1
        } ?: false
    }
}
```

---

## 10. STATE MANAGEMENT

### WeeklyProgramsScreen State

#### ViewModel StateFlows (Collected)
```kotlin
val programs by viewModel.weeklyPrograms.collectAsState()
val activeProgram by viewModel.activeProgram.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()
```

#### Local Component State (ProgramListItem)
```kotlin
var showDeleteDialog by remember { mutableStateOf(false) }
```

### ProgramBuilderScreen State

#### ViewModel StateFlows (Collected)
```kotlin
val routines by viewModel.routines.collectAsState()
val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
val connectionError by viewModel.connectionError.collectAsState()
val programs by viewModel.weeklyPrograms.collectAsState()
```

#### Local Screen State
```kotlin
var programName by remember { mutableStateOf("New Program") }
var isEditingName by remember { mutableStateOf(false) }
var showRoutinePicker by remember { mutableStateOf(false) }
var selectedDay by remember { mutableStateOf<DayOfWeek?>(null) }

var dailyRoutines by remember {
    mutableStateOf<Map<DayOfWeek, Routine?>>(
        DayOfWeek.entries.associateWith { null }
    )
}
```

#### Derived State
```kotlin
val listState = rememberLazyListState()
val canScrollDown by remember { derivedStateOf { /* scroll logic */ } }
```

### State Transitions

#### Program Activation Flow
1. User clicks "Activate" on program → `viewModel.activateProgram(programId)`
2. ViewModel updates database (sets all programs inactive, then activates selected)
3. `activeProgram` StateFlow emits new value
4. UI recomposes to show new active program in ActiveProgramCard
5. Program list items update to show/hide "Active" badge

#### Program Creation/Edit Flow
1. User navigates to ProgramBuilder (new or edit)
2. If editing: `LaunchedEffect` loads existing data into local state
3. User modifies program name and day assignments (local state updates)
4. User clicks save icon → creates entities, calls `viewModel.saveProgram()`
5. ViewModel saves to database via repository
6. Navigate back to WeeklyProgramsScreen
7. `weeklyPrograms` StateFlow emits updated list
8. UI recomposes to show new/updated program

#### Program Deletion Flow
1. User clicks delete icon → `showDeleteDialog = true` (local state)
2. Dialog appears
3. User confirms → `viewModel.deleteProgram(programId)`, dialog dismissed
4. ViewModel deletes from database
5. `weeklyPrograms` StateFlow emits updated list (minus deleted program)
6. If deleted program was active: `activeProgram` emits null
7. UI recomposes to show updated list and "No active program" card

---

## 11. BEHAVIORAL DETAILS

### WeeklyProgramsScreen Behavior

#### On Screen Open
1. Scaffold with TopAppBar renders immediately
2. Background gradient applies based on theme mode
3. ViewModel StateFlows are collected (programs, activeProgram, connection states)
4. If `activeProgram != null`:
   - Display ActiveProgramCard
   - Calculate today's day of week
   - Check if today has a routine assigned
   - Show "Start Today's Workout" button if workout scheduled, else "Rest day"
5. If `activeProgram == null`:
   - Display "No active program" info card
6. Display "All Programs" header and "Create Program" button
7. If programs list is empty:
   - Display EmptyState component
8. Else:
   - Display LazyColumn with ProgramListItem for each program
   - Each item shows title, workout days count, delete button, activate/active badge
9. Connection overlays render conditionally based on state

#### Empty State
- Icon: `Icons.Default.DateRange`
- Title: "No Programs Yet"
- Message: "Create your first weekly program to follow a structured training schedule"
- Action Button: "Create Your First Program" → Navigate to ProgramBuilder (new)

#### Error Handling
- Connection errors shown via `ConnectionErrorDialog` (if `connectionError != null`)
- User can dismiss to clear error
- BLE connection failures during "Start Today's Workout" handled by auto-connect overlay

#### Pull-to-Refresh
- **NOT IMPLEMENTED** (no SwipeRefresh/PullRefresh)

#### Data Loading
- Data loads automatically via StateFlow (Room Flow → Repository → ViewModel → UI)
- No explicit loading state shown (assumes data is always available from local database)

### ProgramBuilderScreen Behavior

#### On Screen Open (New Program)
1. Scaffold renders with TopAppBar showing "New Program" title
2. `dailyRoutines` state initialized with all days as rest (null routine)
3. Display header text "Schedule workouts for each day"
4. Display 7 DayRoutineCards (Monday-Sunday)
5. Each card shows day name and "Rest day" (since no routines assigned)
6. Display summary card showing "0 workout days, 7 rest days"
7. No scroll indicator shown (content fits on screen initially)

#### On Screen Open (Edit Existing Program)
1. Same as above, but:
2. `LaunchedEffect(programId, programs, routines)` executes
3. Finds program by ID in `programs` list
4. Loads `programName` from program entity
5. Loads `dailyRoutines` by mapping `program.days` to `Map<DayOfWeek, Routine?>`
6. UI recomposes to show existing program name and day assignments
7. Summary card updates to show actual workout/rest day counts

#### Day Assignment Flow
1. User clicks on DayRoutineCard
2. `selectedDay` = clicked day
3. `showRoutinePicker = true`
4. AlertDialog appears with list of available routines
5. If no routines: "No routines available. Create a routine first."
6. User selects routine from list
7. `dailyRoutines` updated (mutable map with new routine for selected day)
8. Dialog dismissed
9. DayRoutineCard recomposes to show selected routine
10. Summary card updates workout/rest counts

#### Clear Routine Flow
1. User clicks "Clear" icon on DayRoutineCard (if routine assigned)
2. `dailyRoutines` updated (mutable map with null for that day)
3. DayRoutineCard recomposes to show "Rest day"
4. Summary card updates workout/rest counts

#### Name Editing Flow
1. User clicks edit icon in TopAppBar
2. `isEditingName = true`
3. Title switches from Text to TextField
4. User types new name (updates `programName` state)
5. User clicks check icon
6. `isEditingName = false`
7. Title switches back to Text displaying new name

#### Save Flow
1. User clicks done icon in TopAppBar
2. Collect program data:
   - Create `WeeklyProgramEntity` with current `programName`, `programId` (new UUID or existing)
   - Create list of `ProgramDayEntity` for each day with assigned routine
   - Map `day.value` (MONDAY=1, ..., SUNDAY=7) to `dayOfWeek` field
3. Wrap in `WeeklyProgramWithDays`
4. Call `viewModel.saveProgram(programWithDays)`
5. Navigate back to WeeklyProgramsScreen
6. New/updated program appears in list

#### Scroll Behavior
1. LazyColumn tracks scroll state with `rememberLazyListState()`
2. `canScrollDown` derived state checks if last visible item is not the last item
3. If `canScrollDown == true`:
   - Display gradient fade at bottom (80dp height)
   - Display down arrow icon in rounded surface
4. User scrolls down
5. `canScrollDown` becomes false when all items visible
6. Gradient and icon disappear

#### Error Handling
- No explicit error handling for save operations (assumes success)
- Connection errors handled via overlays (same as WeeklyProgramsScreen)
- If user tries to save without assigning any routines: Program saves with empty `days` list (valid state)

---

## 12. CODE SNIPPETS

### WeeklyProgramsScreen Main Composable
```kotlin
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WeeklyProgramsScreen(
    navController: NavController,
    viewModel: MainViewModel,
    themeMode: com.example.vitruvianredux.ui.theme.ThemeMode
) {
    // Get programs from ViewModel's database StateFlows
    val programs by viewModel.weeklyPrograms.collectAsState()
    val activeProgram by viewModel.activeProgram.collectAsState()

    val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
    val connectionError by viewModel.connectionError.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Weekly Programs") },
                navigationIcon = {
                    IconButton(onClick = { navController.navigateUp() }) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.surface,
                    titleContentColor = MaterialTheme.colorScheme.onSurface,
                    navigationIconContentColor = MaterialTheme.colorScheme.onSurface,
                    actionIconContentColor = MaterialTheme.colorScheme.onSurface
                )
            )
        }
    ) { padding ->
        // Determine actual theme (matching Theme.kt logic)
        val useDarkColors = when (themeMode) {
            com.example.vitruvianredux.ui.theme.ThemeMode.SYSTEM -> isSystemInDarkTheme()
            com.example.vitruvianredux.ui.theme.ThemeMode.LIGHT -> false
            com.example.vitruvianredux.ui.theme.ThemeMode.DARK -> true
        }

        val backgroundGradient = if (useDarkColors) {
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
                    Color(0xFFE0E7FF), // soft indigo
                    Color(0xFFEDE9FE), // soft violet
                    Color(0xFFDFF6FF)  // soft sky blue
                )
            )
        }

        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(backgroundGradient)
        ) {
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(padding)
                    .padding(Spacing.medium),
                verticalArrangement = Arrangement.spacedBy(Spacing.medium)
            ) {
            // Active Program Card
            if (activeProgram != null) {
                item {
                    val today = java.time.LocalDate.now().dayOfWeek
                    val todayDayValue = today.value
                    val todayRoutineId = activeProgram!!.days.find { it.dayOfWeek == todayDayValue }?.routineId

                    ActiveProgramCard(
                        program = activeProgram!!,
                        onStartTodayWorkout = {
                            todayRoutineId?.let { routineId ->
                                viewModel.ensureConnection(
                                    onConnected = {
                                        viewModel.loadRoutineById(routineId)
                                        viewModel.startWorkout()
                                    },
                                    onFailed = { /* Error shown via StateFlow */ }
                                )
                            }
                        },
                        onViewProgram = {
                            navController.navigate(
                                NavigationRoutes.ProgramBuilder.createRoute(activeProgram!!.program.id)
                            )
                        }
                    )
                }
            } else {
                item {
                    Card(
                        modifier = Modifier.fillMaxWidth(),
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        shape = RoundedCornerShape(16.dp),
                        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
                        border = androidx.compose.foundation.BorderStroke(1.dp, Color(0xFFF5F3FF))
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(Spacing.large),
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Icon(
                                Icons.Default.Info,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.onSurfaceVariant,
                                modifier = Modifier.size(48.dp)
                            )
                            Spacer(modifier = Modifier.height(Spacing.small))
                            Text(
                                "No active program",
                                style = MaterialTheme.typography.titleMedium,
                                fontWeight = FontWeight.Bold
                            )
                            Text(
                                "Create a program or activate an existing one",
                                style = MaterialTheme.typography.bodySmall,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }
                }
            }

            // Programs List Header
            item {
                Column(
                    modifier = Modifier.fillMaxWidth(),
                    verticalArrangement = Arrangement.spacedBy(Spacing.medium)
                ) {
                    Text(
                        "All Programs",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold
                    )
                    OutlinedButton(
                        onClick = {
                            navController.navigate(NavigationRoutes.ProgramBuilder.createRoute())
                        },
                        modifier = Modifier.fillMaxWidth(),
                        shape = RoundedCornerShape(16.dp)
                    ) {
                        Icon(Icons.Default.Add, contentDescription = "Create program", modifier = Modifier.size(20.dp))
                        Spacer(modifier = Modifier.width(Spacing.small))
                        Text("Create Program")
                    }
                }
            }

            // Programs List
            if (programs.isEmpty()) {
                item {
                    EmptyState(
                        icon = Icons.Default.DateRange,
                        title = "No Programs Yet",
                        message = "Create your first weekly program to follow a structured training schedule",
                        actionText = "Create Your First Program",
                        onAction = {
                            navController.navigate(NavigationRoutes.ProgramBuilder.createRoute())
                        },
                        modifier = Modifier.fillMaxWidth()
                    )
                }
            } else {
                items(programs) { program ->
                    ProgramListItem(
                        program = program,
                        isActive = program.program.id == activeProgram?.program?.id,
                        onClick = {
                            navController.navigate(
                                NavigationRoutes.ProgramBuilder.createRoute(program.program.id)
                            )
                        },
                        onActivate = {
                            viewModel.activateProgram(program.program.id)
                        },
                        onDelete = {
                            viewModel.deleteProgram(program.program.id)
                        }
                    )
                }
            }
            }

            // Auto-connect UI overlays
            if (isAutoConnecting) {
                com.example.vitruvianredux.presentation.components.ConnectingOverlay(
                    onCancel = { viewModel.cancelAutoConnecting() }
                )
            }

            connectionError?.let { error ->
                com.example.vitruvianredux.presentation.components.ConnectionErrorDialog(
                    message = error,
                    onDismiss = { viewModel.clearConnectionError() }
                )
            }
        }
    }
}
```

### ActiveProgramCard Composable
```kotlin
@Composable
fun ActiveProgramCard(
    program: com.example.vitruvianredux.data.local.WeeklyProgramWithDays,
    onStartTodayWorkout: () -> Unit,
    onViewProgram: () -> Unit
) {
    val today = LocalDate.now().dayOfWeek
    val todayDayValue = today.value
    val todayRoutineId = program.days.find { it.dayOfWeek == todayDayValue }?.routineId
    val hasWorkoutToday = todayRoutineId != null

    Card(
        modifier = Modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, Color(0xFFF5F3FF))
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(Spacing.medium)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        "Active Program",
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.onPrimaryContainer.copy(alpha = 0.7f)
                    )
                    Text(
                        program.program.title,
                        style = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.onPrimaryContainer
                    )
                }
                IconButton(onClick = onViewProgram) {
                    Icon(
                        Icons.Default.Edit,
                        contentDescription = "View program",
                        tint = MaterialTheme.colorScheme.onPrimaryContainer
                    )
                }
            }

            Spacer(modifier = Modifier.height(Spacing.medium))
            HorizontalDivider(color = MaterialTheme.colorScheme.outlineVariant)
            Spacer(modifier = Modifier.height(Spacing.medium))

            Text(
                "Today: ${today.getDisplayName(TextStyle.FULL, Locale.getDefault())}",
                style = MaterialTheme.typography.titleSmall,
                fontWeight = FontWeight.Medium,
                color = MaterialTheme.colorScheme.onSurface
            )

            Spacer(modifier = Modifier.height(Spacing.small))

            if (hasWorkoutToday) {
                Text(
                    "Workout scheduled",
                    style = MaterialTheme.typography.bodyLarge,
                    color = MaterialTheme.colorScheme.onSurface
                )

                Spacer(modifier = Modifier.height(Spacing.medium))

                Button(
                    onClick = onStartTodayWorkout,
                    modifier = Modifier.fillMaxWidth(),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = MaterialTheme.colorScheme.primary
                    )
                ) {
                    Icon(Icons.Default.PlayArrow, contentDescription = null)
                    Spacer(modifier = Modifier.width(Spacing.small))
                    Text("Start Today's Workout")
                }
            } else {
                Text(
                    "Rest day",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }
    }
}
```

### ProgramBuilderScreen Main Composable (Excerpt)
```kotlin
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProgramBuilderScreen(
    navController: NavController,
    viewModel: MainViewModel,
    programId: String,
    exerciseRepository: ExerciseRepository,
    themeMode: com.example.vitruvianredux.ui.theme.ThemeMode
) {
    val routines by viewModel.routines.collectAsState()
    val isAutoConnecting by viewModel.isAutoConnecting.collectAsState()
    val connectionError by viewModel.connectionError.collectAsState()

    var programName by remember { mutableStateOf("New Program") }
    var isEditingName by remember { mutableStateOf(false) }
    var showRoutinePicker by remember { mutableStateOf(false) }
    var selectedDay by remember { mutableStateOf<DayOfWeek?>(null) }

    var dailyRoutines by remember {
        mutableStateOf<Map<DayOfWeek, Routine?>>(
            DayOfWeek.entries.associateWith { null }
        )
    }

    // Load existing program data if editing
    val programs by viewModel.weeklyPrograms.collectAsState()
    LaunchedEffect(programId, programs, routines) {
        if (programId != "new") {
            val existingProgram = programs.find { it.program.id == programId }
            existingProgram?.let { program ->
                programName = program.program.title

                val routineMap = mutableMapOf<DayOfWeek, Routine?>()
                DayOfWeek.entries.forEach { day -> routineMap[day] = null }

                program.days.forEach { programDay ->
                    val dayOfWeek = DayOfWeek.of(programDay.dayOfWeek)
                    val routine = routines.find { it.id == programDay.routineId }
                    routineMap[dayOfWeek] = routine
                }

                dailyRoutines = routineMap
            }
        }
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    if (isEditingName) {
                        TextField(
                            value = programName,
                            onValueChange = { programName = it },
                            singleLine = true,
                            colors = TextFieldDefaults.colors(
                                focusedContainerColor = MaterialTheme.colorScheme.primary,
                                unfocusedContainerColor = MaterialTheme.colorScheme.primary,
                                focusedTextColor = MaterialTheme.colorScheme.onPrimary,
                                unfocusedTextColor = MaterialTheme.colorScheme.onPrimary
                            )
                        )
                    } else {
                        Text(programName)
                    }
                },
                navigationIcon = {
                    IconButton(onClick = { navController.navigateUp() }) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
                    }
                },
                actions = {
                    IconButton(onClick = { isEditingName = !isEditingName }) {
                        Icon(
                            if (isEditingName) Icons.Default.Check else Icons.Default.Edit,
                            contentDescription = if (isEditingName) "Save name" else "Edit name"
                        )
                    }
                    IconButton(onClick = {
                        val programEntity = WeeklyProgramEntity(
                            id = if (programId == "new") UUID.randomUUID().toString() else programId,
                            title = programName,
                            notes = null,
                            isActive = false,
                            createdAt = System.currentTimeMillis()
                        )

                        val programDays = dailyRoutines.entries
                            .filter { (_, routine) -> routine != null }
                            .map { (day, routine) ->
                                ProgramDayEntity(
                                    programId = programEntity.id,
                                    dayOfWeek = day.value,
                                    routineId = routine!!.id
                                )
                            }

                        viewModel.saveProgram(WeeklyProgramWithDays(program = programEntity, days = programDays))
                        navController.navigateUp()
                    }) {
                        Icon(Icons.Default.Done, contentDescription = "Save program")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.surface,
                    titleContentColor = MaterialTheme.colorScheme.onSurface,
                    navigationIconContentColor = MaterialTheme.colorScheme.onSurface,
                    actionIconContentColor = MaterialTheme.colorScheme.onSurface
                )
            )
        }
    ) { padding ->
        // ... (content follows same pattern as WeeklyProgramsScreen)
    }
}
```

### DayRoutineCard Composable
```kotlin
@Composable
fun DayRoutineCard(
    day: DayOfWeek,
    routine: Routine?,
    onSelectRoutine: () -> Unit,
    onClearRoutine: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onSelectRoutine),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        ),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, Color(0xFFF5F3FF))
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(Spacing.medium),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    day.getDisplayName(TextStyle.FULL, Locale.getDefault()),
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold
                )

                if (routine != null) {
                    Spacer(modifier = Modifier.height(Spacing.extraSmall))
                    Text(
                        routine.name,
                        style = MaterialTheme.typography.bodyMedium
                    )
                    Text(
                        "${routine.exercises.size} exercises",
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                } else {
                    Spacer(modifier = Modifier.height(Spacing.extraSmall))
                    Text(
                        "Rest day",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }

            if (routine != null) {
                IconButton(onClick = onClearRoutine) {
                    Icon(
                        Icons.Default.Clear,
                        contentDescription = "Clear routine",
                        tint = MaterialTheme.colorScheme.error
                    )
                }
            } else {
                Icon(
                    Icons.Default.Add,
                    contentDescription = "Add routine",
                    tint = MaterialTheme.colorScheme.primary
                )
            }
        }
    }
}
```

---

## 13. COMPARISON WITH ROUTINES TAB

### Similarities

1. **Screen Structure:**
   - Both use Scaffold + TopAppBar + LazyColumn
   - Both have gradient backgrounds with theme-based colors
   - Both use Material 3 components throughout

2. **Card Design:**
   - Same card styling (16.dp radius, 4.dp elevation, 0xFFF5F3FF border)
   - Same surface container color
   - Same padding (Spacing.medium = 16.dp)

3. **Empty State:**
   - Both use EmptyState component
   - Same layout pattern

4. **Typography:**
   - Same Material 3 typography styles
   - Same font weights (Bold for titles, Medium for labels)

5. **Spacing System:**
   - Both use Spacing constants (extraSmall, small, medium, large)
   - Consistent 8dp grid system

6. **Background Gradients:**
   - **DIFFERENT COLORS** but same structure:
   - RoutinesTab light: indigo-200, pink-100, violet-200
   - Programs light: soft indigo, soft violet, soft sky blue
   - RoutinesTab dark: Same as Programs (slate-900, indigo-950, blue-950)

### Differences

| Aspect | RoutinesTab | Programs Screens |
|--------|-------------|------------------|
| **Main Purpose** | Manage workout routines | Manage weekly programs |
| **Card Animation** | Spring animation on press | No animation (simpler) |
| **List Item Actions** | Edit, Duplicate, Delete menu | Activate/Active badge + Delete |
| **Extended FAB** | Yes ("New Routine") | No (OutlinedButton instead) |
| **Complex State** | Routine builder dialog (inline) | Separate screen (ProgramBuilder) |
| **Icon Design** | 64dp gradient box with icon | None (text-only list items) |
| **Arrow Icon** | Yes (on routine cards) | No |
| **Active/Selected State** | None | Active program badge |
| **Today Context** | None | Active program shows today's workout |
| **Day Assignment** | N/A | 7-day schedule UI |
| **Scroll Indicator** | None | Gradient fade + down arrow (ProgramBuilder) |
| **Derived State** | None | `canScrollDown` (ProgramBuilder) |
| **Name Editing** | In dialog | Inline in TopAppBar (ProgramBuilder) |

### UI Complexity
- **RoutinesTab:** Single screen with inline dialog, focus on individual routines
- **Programs:** Two screens (list + builder), focus on weekly schedule management
- **Builder Screen:** More complex with 7-day assignment UI, scroll detection, summary card

---

## 14. NOTES ON COMPLEX LOGIC & EDGE CASES

### Day of Week Mapping (CRITICAL)
```kotlin
// DayOfWeek enum in Java: MONDAY=1, TUESDAY=2, ..., SUNDAY=7
val dayOfWeek = day.value // Returns 1-7
```

**Edge Cases:**
- Database stores `dayOfWeek` as Int (1-7)
- Must convert back to `DayOfWeek` enum: `DayOfWeek.of(programDay.dayOfWeek)`
- Today detection: `LocalDate.now().dayOfWeek.value` matches against `program.days[].dayOfWeek`

### Active Program Logic
- **Only ONE program can be active** at a time
- `activateProgram()` sets all programs inactive, then activates selected
- UI checks: `program.program.id == activeProgram?.program?.id`

### Program Saving (ProgramBuilder)
- **NEW PROGRAM:** `programId == "new"` → Generate new UUID
- **EDIT PROGRAM:** `programId != "new"` → Use existing ID
- **Days:** Only save days with assigned routines (filter out null)
- **Routine Deletion:** If routine is deleted, program day still references it (foreign key cascade)

### Routine Picker Edge Cases
- **No routines available:** Show message "No routines available. Create a routine first."
- **Already assigned routine:** User can change it by selecting new routine
- **Cancel:** Closes dialog without changing assignment

### Today's Workout Logic
```kotlin
val today = LocalDate.now().dayOfWeek
val todayDayValue = today.value
val todayRoutineId = program.days.find { it.dayOfWeek == todayDayValue }?.routineId
val hasWorkoutToday = todayRoutineId != null
```

**Edge Cases:**
- If no routine assigned for today: Show "Rest day"
- If routine assigned but routine was deleted: `todayRoutineId` won't match any routine (potential bug - not handled)
- If BLE not connected: `ensureConnection()` triggers auto-connect flow

### Connection Flow (Start Today's Workout)
1. Check if connected
2. If not: Show connecting overlay, attempt connection
3. On success: Load routine by ID, start workout
4. On failure: Show error dialog
5. User can cancel connecting

### Scroll Detection (ProgramBuilder)
```kotlin
val canScrollDown by remember {
    derivedStateOf {
        val layoutInfo = listState.layoutInfo
        val lastVisibleItem = layoutInfo.visibleItemsInfo.lastOrNull()

        lastVisibleItem?.let {
            it.index < layoutInfo.totalItemsCount - 1
        } ?: false
    }
}
```

**Edge Cases:**
- If content fits on screen: `canScrollDown = false`, no indicator shown
- If user scrolls to bottom: `canScrollDown` becomes false, indicator disappears
- If content grows (e.g., keyboard appears): `canScrollDown` may change

### Delete Confirmation
- **No undo** - Permanent deletion
- Confirmation dialog prevents accidental deletion
- If active program deleted: `activeProgram` becomes null, UI shows "No active program"

### LaunchedEffect Dependencies (ProgramBuilder)
```kotlin
LaunchedEffect(programId, programs, routines) { ... }
```

**Triggers:**
- Initial composition
- `programId` changes (shouldn't happen in this screen)
- `programs` list changes (if program updated elsewhere)
- `routines` list changes (if routines added/deleted)

**Why routines dependency?** To reload program data when routines change (e.g., routine deleted while editing program)

---

## 15. FLUTTER PORTING RECOMMENDATIONS

### State Management (Riverpod)
- **ViewModel → StateNotifier:**
  - `weeklyPrograms` → `StateProvider<List<WeeklyProgramWithDays>>`
  - `activeProgram` → `StateProvider<WeeklyProgramWithDays?>`
  - Use `StreamProvider` for database Flow → Stream conversion

- **Local State → useState:**
  - `showDeleteDialog`, `isEditingName`, `dailyRoutines` → `useState()`
  - `canScrollDown` → Compute in build (or use separate state)

### Database (Drift)
- **WeeklyProgramEntity → WeeklyPrograms table**
- **ProgramDayEntity → ProgramDays table** (with foreign keys)
- **WeeklyProgramWithDays → Join query** with `@UseRowClass`

### BLE Integration
- `ensureConnection()` → Similar auto-connect flow
- `startWorkout()` → Load routine, navigate to workout screen

### UI Components
- **Scaffold + AppBar:** flutter_riverpod `ConsumerWidget`
- **LazyColumn → ListView.builder** or **ListView.separated**
- **Card → Card widget** with BorderRadius, elevation, border
- **AlertDialog → showDialog** with AlertDialog widget
- **TextField → TextField** with InputDecoration
- **Button → ElevatedButton / OutlinedButton / TextButton**

### Animations
- Programs screens have NO explicit animations (simpler than RoutinesTab)
- Optional: Add implicit animations for card press (AnimatedScale)

### Day of Week
- Dart `DateTime.weekday`: MONDAY=1, SUNDAY=7 (same as Java DayOfWeek.value)
- Use `DateFormat.EEEE()` for full day name (locale-aware)

### Gradient Backgrounds
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: useDarkColors
        ? [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF172554)]
        : [Color(0xFFE0E7FF), Color(0xFFEDE9FE), Color(0xFFDFF6FF)],
    ),
  ),
)
```

### Scroll Detection
```dart
final ScrollController _scrollController = ScrollController();

bool get canScrollDown {
  if (!_scrollController.hasClients) return false;
  return _scrollController.position.pixels < _scrollController.position.maxScrollExtent;
}

// Listen to scroll changes
_scrollController.addListener(() {
  setState(() {}); // Rebuild to update indicator
});
```

### Spacing Constants
```dart
class Spacing {
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double huge = 48.0;
}
```

### Navigation
- **NavController.navigate() → Navigator.pushNamed()** or **go_router**
- Pass program ID as route parameter

### Testing
- **Unit tests:** Day of week logic, summary calculations
- **Widget tests:** Card rendering, dialog behavior
- **Integration tests:** Full flow (create program → assign routines → save → activate)

---

## 16. FLUTTER IMPLEMENTATION CHECKLIST

### Data Layer
- [ ] Create WeeklyPrograms Drift table
- [ ] Create ProgramDays Drift table with foreign keys
- [ ] Create WeeklyProgramWithDays join class
- [ ] Add DAO methods (getAllPrograms, getActiveProgram, saveProgram, deleteProgram, activateProgram)
- [ ] Create WorkoutRepository methods
- [ ] Add unit tests for database operations

### State Management
- [ ] Create ProgramsNotifier (StateNotifier)
- [ ] Add weeklyPrograms stream provider
- [ ] Add activeProgram stream provider
- [ ] Add saveProgram, deleteProgram, activateProgram methods
- [ ] Wire up to WorkoutRepository

### UI - WeeklyProgramsScreen
- [ ] Create WeeklyProgramsScreen widget (ConsumerWidget)
- [ ] Add Scaffold + AppBar with back button
- [ ] Add gradient background container
- [ ] Create ActiveProgramCard widget
- [ ] Create NoActiveProgramCard widget
- [ ] Create ProgramListItem widget
- [ ] Add EmptyState for no programs
- [ ] Add "Create Program" button
- [ ] Add delete confirmation dialog
- [ ] Wire up navigation to ProgramBuilder
- [ ] Wire up "Start Today's Workout" action
- [ ] Add connection overlays (ConnectingOverlay, ConnectionErrorDialog)

### UI - ProgramBuilderScreen
- [ ] Create ProgramBuilderScreen widget (ConsumerWidget)
- [ ] Add Scaffold + AppBar with actions (edit name, save)
- [ ] Add inline name editing (TextField in AppBar)
- [ ] Create DayRoutineCard widget (7 cards)
- [ ] Add routine picker dialog (AlertDialog + ListView)
- [ ] Add summary card (workout/rest days count)
- [ ] Add scroll detection + gradient indicator
- [ ] Implement load existing program logic (LaunchedEffect equivalent)
- [ ] Implement save program logic
- [ ] Wire up day assignment actions
- [ ] Add connection overlays

### Styling
- [ ] Define Spacing constants
- [ ] Define color constants (card border, etc.)
- [ ] Set up Material 3 theme
- [ ] Match typography styles
- [ ] Match card styling (radius, elevation, border)
- [ ] Match gradient backgrounds (dark/light mode)

### Testing
- [ ] Unit test: Day of week conversion
- [ ] Unit test: Today's workout logic
- [ ] Unit test: Summary calculation
- [ ] Widget test: WeeklyProgramsScreen rendering
- [ ] Widget test: ProgramBuilderScreen rendering
- [ ] Widget test: ActiveProgramCard states
- [ ] Widget test: Delete confirmation
- [ ] Integration test: Create program flow
- [ ] Integration test: Activate program flow

### Documentation
- [ ] Add code comments explaining day of week mapping
- [ ] Document active program logic
- [ ] Add examples for creating programs

---

## SUMMARY

The Programs Tab consists of two screens:

1. **WeeklyProgramsScreen** - List view showing all programs with active program at top
2. **ProgramBuilderScreen** - Edit view for assigning routines to each day of the week

Key features:
- Active program badge and today's workout quick start
- 7-day weekly schedule management
- Clean Material 3 design with gradient backgrounds
- Same visual style as RoutinesTab but simpler interactions (no animations)
- Robust state management with Room/Flow → Drift/Stream in Flutter
- Critical day of week mapping (MONDAY=1 to SUNDAY=7)

This analysis provides all the detail needed for pixel-perfect Flutter implementation matching the Kotlin source.
