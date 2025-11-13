# PR Screen - Kotlin to Flutter Exact Matching Analysis

## Executive Summary

The PR (Personal Records) screen in VitruvianRedux is **embedded within the Analytics screen as a tab**, not a standalone screen. It displays the user's personal records grouped by exercise, showing the best performance (weight and reps) for each exercise. The implementation features:

- **3-tab layout**: History, Personal Bests (PRs), Trends
- **PR celebration animation**: Confetti explosion dialog shown immediately after achieving new PR during workout
- **Grouping by exercise**: PRs are grouped by exercise, showing best performance per exercise+mode combination
- **Visual charts**: Muscle group distribution and workout mode distribution
- **Export functionality**: CSV export for PRs and workout history
- **Complexity**: Medium - primarily list-based UI with chart integrations and celebration animations

**Key Finding**: PRs are NOT tracked in a dedicated screen but are part of Analytics screen's "Personal Bests" tab. The celebration animation is shown during active workouts when a new PR is achieved.

---

## 1. Screen Structure

### AnalyticsScreen Architecture
```
AnalyticsScreen (Main Container)
├── TabRow (3 tabs)
│   ├── Tab 0: History
│   ├── Tab 1: Personal Bests (PR Screen)
│   └── Tab 2: Trends
├── HorizontalPager (Swipeable content)
│   ├── Page 0: HistoryTab
│   ├── Page 1: PersonalBestsTab ⭐ THE PR SCREEN
│   └── Page 2: TrendsTab
├── FloatingActionButton (Export)
├── ConnectingOverlay (if auto-connecting)
└── ConnectionErrorDialog (if error)
```

### PersonalBestsTab Layout
```
PersonalBestsTab (LazyColumn)
├── Title: "Your Personal Records"
├── Muscle Group Distribution Chart (Card)
├── PRs by Workout Mode Chart (Card)
└── List of PersonalRecordCard items (sorted by weight, descending)
    └── PersonalRecordCard (per exercise)
        ├── Rank Badge (#1, #2, #3, etc.)
        ├── Exercise Name
        ├── Weight/cable (formatted with unit)
        ├── Reps count
        ├── Workout Mode (OldSchool, Pump, TUT, etc.)
        ├── Date achieved
        └── Star icon (if rank #1)
```

### Empty State
```
Card with:
├── Icon: Info (48.dp, primary color)
├── Title: "No personal records yet"
└── Subtitle: "Complete workouts to see your PRs"
```

### Background
- Gradient background (same as other analytics tabs)
- Dark mode: slate-900 → indigo-950 → blue-950
- Light mode: indigo-200 → pink-100 → violet-200

---

## 2. PR List Item Specifications

### PersonalRecordCard - EXACT LAYOUT

**Card Properties:**
- Shape: `RoundedCornerShape(16.dp)`
- Elevation: `4.dp`
- Border: `1.dp solid Color(0xFFF5F3FF)`
- Container color: `MaterialTheme.colorScheme.surface`
- Padding: `Spacing.medium` (16.dp internal)
- Width: `fillMaxWidth()`
- Click behavior: Animated scale (0.98f on press)
- Animation: Spring with `DampingRatioMediumBouncy` and stiffness 400f

**Card Content (Row layout):**

**Left Section (Row, weight=1f):**
1. **Rank Badge** (Surface)
   - Shape: `RoundedCornerShape(8.dp)`
   - Background color:
     - Rank #1: `MaterialTheme.colorScheme.tertiary`
     - Rank #2-3: `MaterialTheme.colorScheme.secondary`
     - Rank #4+: `Color(0xFFF5F3FF)`
   - Text: `"#$rank"`
   - Text color:
     - Rank #1: `MaterialTheme.colorScheme.onTertiary`
     - Rank #2-3: `MaterialTheme.colorScheme.onSecondary`
     - Rank #4+: `Color(0xFF9333EA)` (purple)
   - Typography: `MaterialTheme.typography.labelMedium`, FontWeight.Bold
   - Padding: horizontal 8.dp, vertical 4.dp

2. **Spacer**: 16.dp (Spacing.medium)

3. **Exercise Details** (Column)
   - **Exercise Name**
     - Typography: `MaterialTheme.typography.titleMedium`
     - FontWeight: `Bold`
     - Color: `MaterialTheme.colorScheme.onSurface`

   - **Weight Display**
     - Text: `"{weight}/cable"` (e.g., "45.0 kg/cable")
     - Typography: `MaterialTheme.typography.bodyLarge`
     - Color: `MaterialTheme.colorScheme.primary`

   - **Metadata Row** (horizontal, spacedBy extraSmall)
     - Reps: `"{reps} reps"` (bodySmall, onSurfaceVariant)
     - Bullet separator: `"•"` (bodySmall, onSurfaceVariant)
     - Workout Mode: `"{workoutMode}"` (bodySmall, secondary color)
     - Bullet separator: `"•"` (bodySmall, onSurfaceVariant)
     - Date: `"MMM d, yyyy"` format (bodySmall, onSurfaceVariant)

**Right Section:**
- **Star Icon** (if rank == 1)
  - Icon: `Icons.Default.Star`
  - Size: `32.dp`
  - Tint: `MaterialTheme.colorScheme.primary`

**Spacing:**
- Internal padding: `Spacing.medium` (16.dp all sides)
- Between cards: `Spacing.medium` (16.dp vertical)
- Between metadata elements: `Spacing.extraSmall` (4.dp)

---

## 3. PR Celebration System

### PRCelebrationDialog

**Trigger Conditions:**
- Triggered immediately after workout completion
- Only if a new PR is achieved (better weight OR better reps at same weight)
- Only for non-Just Lift workouts
- Only for non-Echo mode workouts
- Displayed in `ActiveWorkoutScreen` during workout

**Animation Components:**

1. **Confetti Particles (30 particles)**
   - Colors: Gold, Orange, Pink, Purple, Blue, Green
   - Particle size: Random 4-12 dp
   - Start position: Top of dialog, random X
   - Velocity X: Random -200 to +200 pixels
   - Velocity Y: Random -800 to -1200 pixels (upward)
   - Rotation speed: Random -5 to +5 degrees/sec
   - Physics: Gravity applied (0.5 * 980 * t²)
   - Duration: 3 seconds loop
   - Opacity: Fades from 1.0 to 0.5 over animation

2. **Text Pulse Animation**
   - "NEW PR!" text scales from 1.0 to 1.15
   - Duration: 500ms
   - Easing: `FastOutSlowInEasing`
   - Repeat mode: `RepeatMode.Reverse` (infinite)

3. **Star Icons (3 stars)**
   - Size: `32.dp` each
   - Color: Gold (`0xFFFFD700`)
   - Arrangement: Horizontal row, 8.dp spacing
   - Scale: Follows pulse animation (1.0 to 1.15)

4. **Star Rotation** (unused in final implementation)
   - Rotation: 0° to 360°
   - Duration: 2000ms
   - Easing: `LinearEasing`

**Dialog Properties:**
- Dismissible: Yes (tap outside or back button)
- Auto-dismiss: After 3 seconds
- Shape: `MaterialTheme.shapes.large`
- Background: `MaterialTheme.colorScheme.surface`
- Padding: `32.dp`
- Width: `fillMaxWidth()`

**Dialog Content (Column, centered):**
1. **Three Stars** (Row, 8.dp spacing, pulsing)
2. **"NEW PR!" text**
   - Typography: `MaterialTheme.typography.headlineLarge`
   - FontWeight: `Bold`
   - Color: `MaterialTheme.colorScheme.primary`
   - Scale: Pulsing 1.0 to 1.15
3. **Exercise Name**
   - Typography: `MaterialTheme.typography.titleLarge`
   - FontWeight: `Bold`
   - Color: `MaterialTheme.colorScheme.onSurface`
4. **Weight Badge** (Surface)
   - Background: `MaterialTheme.colorScheme.primaryContainer`
   - Shape: `MaterialTheme.shapes.medium`
   - Text: `"{weight}/cable × {reps} reps"` (e.g., "45.0 kg/cable × 10 reps")
   - Typography: `MaterialTheme.typography.headlineMedium`
   - FontWeight: `Bold`
   - Color: `MaterialTheme.colorScheme.primary`
   - Padding: horizontal 24.dp, vertical 12.dp
5. **Spacer**: 8.dp
6. **"Tap to dismiss" hint**
   - Typography: `MaterialTheme.typography.bodySmall`
   - Color: `MaterialTheme.colorScheme.onSurfaceVariant`
   - Alpha: 0.6

**Spacing:**
- Vertical arrangement: 16.dp between elements
- Exception: 8.dp before "tap to dismiss"

---

## 4. Visual Design Specifications

### Typography System

| Element | Typography | FontWeight | Color |
|---------|-----------|------------|-------|
| Screen Title | headlineSmall | Bold | onSurface |
| Exercise Name (card) | titleMedium | Bold | onSurface |
| Weight Display | bodyLarge | Normal | primary |
| Reps/Mode/Date | bodySmall | Normal | onSurfaceVariant |
| Rank Badge | labelMedium | Bold | Varies by rank |
| Empty State Title | titleMedium | Bold | onSurface |
| Empty State Body | bodySmall | Normal | onSurfaceVariant |
| Chart Title | titleMedium | Bold | onSurface |
| PR Dialog "NEW PR!" | headlineLarge | Bold | primary |
| PR Dialog Exercise | titleLarge | Bold | onSurface |
| PR Dialog Weight | headlineMedium | Bold | primary |

### Spacing System (from Spacing object)
- `extraSmall`: 4.dp
- `small`: 8.dp
- `medium`: 16.dp (most common)
- `large`: 24.dp

### Color Palette

**Card Colors:**
- Surface: `MaterialTheme.colorScheme.surface`
- Border: `Color(0xFFF5F3FF)` (soft lavender)

**Rank Badge Colors:**
- Rank #1 background: `tertiary`
- Rank #2-3 background: `secondary`
- Rank #4+ background: `Color(0xFFF5F3FF)`

**Chart Colors:**
- Purple: `Color(0xFF9333EA)`
- Blue: `Color(0xFF3B82F6)`
- Green: `Color(0xFF10B981)`
- Orange: `Color(0xFFF59E0B)`
- Red: `Color(0xFFEF4444)`
- Violet: `Color(0xFF8B5CF6)`
- Pink: `Color(0xFFEC4899)`
- Teal: `Color(0xFF14B8A6)`

**Celebration Colors:**
- Gold: `Color(0xFFFFD700)`
- Orange: `Color(0xFFFFA500)`
- Pink: `Color(0xFFFF69B4)`
- Purple: `Color(0xFF9333EA)`
- Blue: `Color(0xFF3B82F6)`
- Green: `Color(0xFF10B981)`

### Card Styling
- Shape: `RoundedCornerShape(16.dp)`
- Elevation: `4.dp`
- Shadow: `4.dp` with `RoundedCornerShape(16.dp)`
- Border: `1.dp solid Color(0xFFF5F3FF)`

### Icon Sizes
- Tab icon: Default size
- Chart section icon: `24.dp`
- Empty state icon: `48.dp`
- Star icon (top PR): `32.dp`
- Export FAB icon: Default size
- Celebration stars: `32.dp`

---

## 5. Filtering and Sorting

### Current Implementation
**No explicit filtering or sorting UI provided.**

**Default Sorting:**
- PRs are grouped by exercise
- Within each exercise, the BEST PR is shown (highest weight, then highest reps)
- List is sorted by weight descending (heaviest PRs first)

### Grouping Logic
```kotlin
personalRecords.groupBy { it.exerciseId }
    .mapValues { (_, prs) ->
        // Get the best PR for this exercise
        prs.maxWith(compareBy({ it.weightPerCableKg }, { it.reps }))
    }
    .toList()
    .sortedByDescending { (_, pr) -> pr.weightPerCableKg }
```

### Future Filtering Options (NOT IMPLEMENTED)
Potential filters that could be added:
- By exercise name
- By workout mode (OldSchool, Pump, TUT, etc.)
- By time range (Last 30 days, All time)
- By muscle group

**Note:** Current implementation shows ALL PRs, one per exercise (the best one).

---

## 6. Data Loading and State

### Data Sources
```kotlin
// In MainViewModel
val allPersonalRecords: StateFlow<List<PersonalRecord>> =
    personalRecordRepository.getAllPRsGrouped()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.Eagerly,
            initialValue = emptyList()
        )
```

### Loading States
- **Initial Load**: Empty list shows empty state immediately
- **Loading Indicator**: None (relies on Flow from database)
- **Error State**: None (errors logged, UI shows empty state)
- **Empty State**: Custom card with icon and message

### Real-Time Updates
- PRs update automatically via StateFlow
- Database changes trigger Flow emission
- UI recomposes when StateFlow value changes

### Exercise Name Resolution
```kotlin
// Async fetch of exercise names
LaunchedEffect(prsByExercise) {
    prsByExercise.forEach { (exerciseId, _) ->
        if (!exerciseNames.contains(exerciseId)) {
            try {
                val exercise = exerciseRepository.getExerciseById(exerciseId)
                exerciseNames[exerciseId] = exercise?.name ?: "Unknown Exercise"
            } catch (e: Exception) {
                exerciseNames[exerciseId] = "Unknown Exercise"
            }
        }
    }
}
```

### Muscle Group Distribution
```kotlin
// Async calculation of muscle group counts
LaunchedEffect(prsByExercise) {
    val counts = mutableMapOf<String, Int>()
    prsByExercise.forEach { (exerciseId, _) ->
        val exercise = withContext(Dispatchers.IO) {
            exerciseRepository.getExerciseById(exerciseId)
        }
        exercise?.muscleGroups?.split(",")?.forEach { group ->
            val trimmedGroup = group.trim()
            if (trimmedGroup.isNotBlank()) {
                counts[trimmedGroup] = counts.getOrDefault(trimmedGroup, 0) + 1
            }
        }
    }
    muscleGroupCounts.clear()
    muscleGroupCounts.putAll(counts)
}
```

---

## 7. Navigation Patterns

### Route Configuration
**Not a standalone screen** - part of Analytics tab system.

Navigation via:
1. **Bottom navigation**: Main screen → Analytics
2. **Tab selection**: Analytics → Personal Bests tab (index 1)
3. **Swipe gesture**: HorizontalPager allows swipe between tabs

### Parameters
None - uses ViewModel's `allPersonalRecords` StateFlow.

### Deep Linking
None implemented (could be added for direct tab navigation).

---

## 8. Database Integration

### Schema
```kotlin
@Entity(
    tableName = "personal_records",
    indices = [
        Index(value = ["exerciseId", "workoutMode"], unique = true)
    ]
)
data class PersonalRecordEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val exerciseId: String,
    val weightPerCableKg: Float,
    val reps: Int,
    val timestamp: Long,
    val workoutMode: String
)
```

**Unique Index**: `exerciseId + workoutMode` combination ensures one PR per exercise per mode.

### Key Queries

#### 1. Get All PRs (Grouped)
```sql
SELECT * FROM personal_records
ORDER BY exerciseId, workoutMode, timestamp DESC
```

#### 2. Get Latest PR for Exercise+Mode
```sql
SELECT * FROM personal_records
WHERE exerciseId = :exerciseId AND workoutMode = :workoutMode
LIMIT 1
```

#### 3. Get Best PR for Exercise (Any Mode)
```sql
SELECT * FROM personal_records
WHERE exerciseId = :exerciseId
ORDER BY weightPerCableKg DESC, reps DESC
LIMIT 1
```

#### 4. Get All PRs for Exercise
```sql
SELECT * FROM personal_records
WHERE exerciseId = :exerciseId
ORDER BY timestamp DESC
```

### Insert/Update Logic
```kotlin
@Transaction
suspend fun updatePRIfBetter(
    exerciseId: String,
    weightPerCableKg: Float,
    reps: Int,
    workoutMode: String,
    timestamp: Long
): Boolean {
    val existingPR = getLatestPR(exerciseId, workoutMode)

    // If no existing PR, this is automatically a new PR
    if (existingPR == null) {
        upsertPR(PersonalRecordEntity(...))
        return true
    }

    // Compare: new PR if weight is higher OR (weight is same AND reps are higher)
    val isBetter = weightPerCableKg > existingPR.weightPerCableKg ||
            (weightPerCableKg == existingPR.weightPerCableKg && reps > existingPR.reps)

    if (isBetter) {
        upsertPR(PersonalRecordEntity(...))
        return true
    }

    return false
}
```

### Joins
- **With Exercise Table**: To get exercise names and muscle groups
- Performed via repository, not SQL joins
- Async lookup using `exerciseRepository.getExerciseById()`

---

## 9. PR Calculation Logic

### When PRs Are Checked
- **After every workout completion** (in `completeWorkout()`)
- Only for **working reps** (excludes warmup reps)
- Only for **non-Just Lift** workouts
- Only for **non-Echo mode** workouts
- Only if **exercise is selected** (`selectedExerciseId != null`)

### Comparison Algorithm
```kotlin
// Current workout performance
val newWeight = weightPerCableKg
val newReps = workingReps

// Existing PR
val existingWeight = existingPR.weightPerCableKg
val existingReps = existingPR.reps

// Is new performance better?
val isBetter = newWeight > existingWeight ||
               (newWeight == existingWeight && newReps > existingReps)
```

**Priority:**
1. Weight is KING (higher weight always wins)
2. If weight is equal, higher reps wins
3. If both equal, existing PR is kept (no update)

### PR Types (Implicit)

1. **Overall PR**: Best performance for an exercise across all modes
   - Query: `SELECT * FROM personal_records WHERE exerciseId = :id ORDER BY weightPerCableKg DESC, reps DESC LIMIT 1`

2. **Mode-Specific PR**: Best performance for an exercise in a specific mode
   - Stored per `exerciseId + workoutMode` combination
   - Example: "Bench Press - OldSchool", "Bench Press - Pump"

### Tie-Breaking
- **Same weight + same reps**: Older PR is kept (no update, returns false)
- **Same weight + more reps**: New PR (returns true)
- **More weight**: New PR regardless of reps (returns true)

### Edge Cases Handled
- **First workout for exercise**: Always a PR (existingPR == null)
- **Deleted exercises**: PRs remain but show "Unknown Exercise"
- **Mode changes**: Each mode tracks separately (OldSchool PR != Pump PR)

---

## 10. Edge Cases and Error States

### 1. No PRs Yet
**Display:**
```
Card with:
├── Icon: Info (48.dp, primary)
├── "No personal records yet" (titleMedium, bold)
└── "Complete workouts to see your PRs" (bodySmall, onSurfaceVariant)
```

### 2. Deleted/Unknown Exercise
- Exercise name shows: `"Unknown Exercise"`
- PR data remains in database
- Card displays normally with fallback name

### 3. Multiple PRs on Same Day
- Only the best one is shown (grouped by exercise)
- Timestamp is stored but not used for comparison
- Latest PR overwrites if better

### 4. Tied PRs (Same Weight and Reps)
- Existing PR is kept (no update)
- Celebration not triggered
- `updatePRIfBetter()` returns false

### 5. Very Old PRs
- Date format: `"MMM d, yyyy"` (e.g., "Jan 15, 2023")
- No special handling for old dates

### 6. Exercise Name Loading
- Shows `"Loading..."` while fetching
- Uses `LaunchedEffect` with async lookup
- Falls back to `"Unknown Exercise"` on error

### 7. Muscle Group Missing
- Chart shows only exercises with muscle groups defined
- Empty string or blank groups are filtered out

### 8. Zero or Negative Weight
- Not validated in UI (trusts database)
- Potential issue if data is corrupted

### 9. Database Error During PR Check
```kotlin
return try {
    val isNewPR = personalRecordDao.updatePRIfBetter(...)
    Result.success(isNewPR)
} catch (e: Exception) {
    Timber.e(e, "Failed to update PR for exercise $exerciseId")
    Result.failure(e)
}
```
- Error logged via Timber
- Returns `Result.failure(e)`
- UI not notified of error (celebration not shown)

### 10. Just Lift Mode
- PRs are **NOT tracked** for Just Lift workouts
- Celebration **NOT shown**
- Intentional: Just Lift is for casual/warmup

### 11. Echo Mode
- PRs are **NOT tracked** for Echo mode workouts
- Echo mode uses different resistance algorithm
- Not comparable to weight-based modes

---

## 11. Performance Optimizations

### 1. Query Optimization
- **Indexed columns**: `exerciseId + workoutMode` (unique index)
- **Efficient queries**: Use `LIMIT 1` for single PR lookups
- **Sorted results**: `ORDER BY` in SQL for best performance

### 2. Caching Strategy
- **StateFlow caching**: Results cached in ViewModel StateFlow
- **Single database query**: `getAllPRsGrouped()` fetches all PRs once
- **In-memory grouping**: Grouping done in Kotlin, not repeated SQL queries

### 3. Async Operations
- **Exercise name lookup**: Done with `LaunchedEffect` and `withContext(Dispatchers.IO)`
- **Muscle group calculation**: Async with IO dispatcher
- **Non-blocking UI**: Flow-based reactive updates

### 4. Animation Performance
- **Confetti particles**: Limited to 30 particles
- **Canvas drawing**: Native canvas for particle rendering
- **Infinite animations**: Use `rememberInfiniteTransition()` for efficiency

### 5. List Performance
- **LazyColumn**: Only renders visible items
- **No pagination**: All PRs shown (expected to be small dataset)
- **Stable keys**: Exercise ID used as stable key for grouping

### 6. Chart Rendering
- **MPAndroidChart library**: Hardware-accelerated charts
- **Lazy loading**: Charts only rendered in visible tabs
- **Data transformation**: Pre-sorted data passed to charts

### 7. Flow Optimization
- **SharingStarted.Eagerly**: Starts collecting immediately (PRs needed frequently)
- **Single Flow**: One Flow from database, multiple subscribers
- **StateFlow**: Latest value cached, new subscribers get instant update

---

## 12. Flutter Implementation Guide

### State Management (Riverpod)

#### Providers
```dart
// Personal Records Stream
final personalRecordsProvider = StreamProvider<List<PersonalRecord>>((ref) {
  final repository = ref.watch(personalRecordRepositoryProvider);
  return repository.getAllPRsGrouped();
});

// Grouped PRs
final groupedPRsProvider = Provider<List<(String, PersonalRecord)>>((ref) {
  final allPRs = ref.watch(personalRecordsProvider).value ?? [];

  // Group by exercise and get best PR
  final grouped = <String, PersonalRecord>{};
  for (final pr in allPRs) {
    final existing = grouped[pr.exerciseId];
    if (existing == null || _isBetter(pr, existing)) {
      grouped[pr.exerciseId] = pr;
    }
  }

  // Convert to list and sort by weight descending
  return grouped.entries
      .map((e) => (e.key, e.value))
      .toList()
      ..sort((a, b) => b.$2.weightPerCableKg.compareTo(a.$2.weightPerCableKg));
});

// Exercise names lookup
final exerciseNamesProvider = FutureProvider.family<String, String>((ref, exerciseId) async {
  final repository = ref.watch(exerciseRepositoryProvider);
  final exercise = await repository.getExerciseById(exerciseId);
  return exercise?.name ?? 'Unknown Exercise';
});

// PR celebration event stream
final prCelebrationProvider = StreamProvider<PRCelebrationEvent?>((ref) {
  final workoutService = ref.watch(workoutServiceProvider);
  return workoutService.prCelebrationStream;
});
```

### Widgets to Create

#### 1. `AnalyticsScreen` (Scaffold)
- 3-tab TabBar: History, Personal Bests, Trends
- TabBarView for swipeable content
- FloatingActionButton for export
- Background gradient

#### 2. `PersonalBestsTab` (StatelessWidget)
- Consumes `personalRecordsProvider`
- LazyList (ListView.builder) of `PersonalRecordCard`
- Muscle group distribution chart
- Workout mode distribution chart
- Empty state widget

#### 3. `PersonalRecordCard` (StatelessWidget)
- Card with rank badge, exercise name, weight, reps, mode, date
- Animated scale on tap (using `AnimatedScale`)
- Star icon for #1 rank
- Proper color coding for rank badges

#### 4. `PRCelebrationDialog` (StatefulWidget)
- Custom confetti particle animation
- Pulsing "NEW PR!" text
- Star icons
- Weight badge
- Auto-dismiss after 3 seconds
- Uses `CustomPainter` for confetti

#### 5. `ConfettiPainter` (CustomPainter)
- Draws 30 confetti particles
- Physics simulation (gravity, velocity)
- Random colors and rotations
- Fade-out animation

#### 6. `WeightProgressionChart` (StatelessWidget)
- Uses `fl_chart` package (Flutter charting library)
- LineChart showing weight over time
- X-axis: dates, Y-axis: weight
- Cubic bezier interpolation
- Touch interactions

#### 7. `MuscleGroupDistributionChart` (StatelessWidget)
- Uses `fl_chart` PieChart
- Shows percentage of PRs per muscle group
- Color-coded segments
- Legend

#### 8. `WorkoutModeDistributionChart` (StatelessWidget)
- Uses `fl_chart` BarChart or PieChart
- Shows distribution of PRs by workout mode

#### 9. `EmptyStateCard` (StatelessWidget)
- Reusable widget for "No PRs yet" state
- Icon, title, subtitle

### Animation Controllers

#### Confetti Animation
```dart
class _PRCelebrationDialogState extends State<PRCelebrationDialog>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late List<ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();

    // Confetti animation (3 seconds)
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Pulse animation (500ms, reverse)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.fastOutSlowIn),
    );

    // Generate 30 confetti particles
    _particles = List.generate(30, (i) => ConfettiParticle.random());

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ... build method
}
```

#### Particle Physics
```dart
class ConfettiParticle {
  final double startX;
  final double startY;
  final Color color;
  final double size;
  final double rotationSpeed;
  final double velocityX;
  final double velocityY;

  static ConfettiParticle random() {
    final random = Random();
    return ConfettiParticle(
      startX: random.nextDouble(),
      startY: 0,
      color: _randomColor(),
      size: random.nextDouble() * 8 + 4,
      rotationSpeed: random.nextDouble() * 10 - 5,
      velocityX: random.nextDouble() * 400 - 200,
      velocityY: random.nextDouble() * -800 - 400,
    );
  }

  Offset position(double progress) {
    final x = startX + velocityX * progress;
    final y = startY + velocityY * progress + 0.5 * 980 * progress * progress;
    return Offset(x, y);
  }

  double rotation(double progress) {
    return rotationSpeed * progress * 360;
  }

  double opacity(double progress) {
    return 1.0 - progress * 0.5;
  }
}
```

### Database (Drift)

#### Table Definition
```dart
@DataClassName('PersonalRecord')
class PersonalRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text()();
  RealColumn get weightPerCableKg => real()();
  IntColumn get reps => integer()();
  IntColumn get timestamp => integer()();
  TextColumn get workoutMode => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {exerciseId, workoutMode}, // Unique per exercise+mode
  ];
}
```

#### DAO Methods
```dart
@DriftAccessor(tables: [PersonalRecords])
class PersonalRecordDao extends DatabaseAccessor<AppDatabase> {
  PersonalRecordDao(AppDatabase db) : super(db);

  // Get all PRs grouped (ordered by exercise, mode, timestamp)
  Stream<List<PersonalRecord>> getAllPRsGrouped() {
    return (select(personalRecords)
      ..orderBy([
        (t) => OrderingTerm(expression: t.exerciseId),
        (t) => OrderingTerm(expression: t.workoutMode),
        (t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
      ])).watch();
  }

  // Get latest PR for exercise+mode
  Future<PersonalRecord?> getLatestPR(String exerciseId, String workoutMode) {
    return (select(personalRecords)
      ..where((t) => t.exerciseId.equals(exerciseId) & t.workoutMode.equals(workoutMode))
      ..limit(1)).getSingleOrNull();
  }

  // Get best PR for exercise (any mode)
  Future<PersonalRecord?> getBestPR(String exerciseId) {
    return (select(personalRecords)
      ..where((t) => t.exerciseId.equals(exerciseId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.weightPerCableKg, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.reps, mode: OrderingMode.desc),
      ])
      ..limit(1)).getSingleOrNull();
  }

  // Update PR if better (transaction)
  Future<bool> updatePRIfBetter({
    required String exerciseId,
    required double weightPerCableKg,
    required int reps,
    required String workoutMode,
    required int timestamp,
  }) async {
    return transaction(() async {
      final existingPR = await getLatestPR(exerciseId, workoutMode);

      // No existing PR = automatic new PR
      if (existingPR == null) {
        await into(personalRecords).insert(PersonalRecordsCompanion.insert(
          exerciseId: exerciseId,
          weightPerCableKg: weightPerCableKg,
          reps: reps,
          workoutMode: workoutMode,
          timestamp: timestamp,
        ));
        return true;
      }

      // Compare performance
      final isBetter = weightPerCableKg > existingPR.weightPerCableKg ||
          (weightPerCableKg == existingPR.weightPerCableKg && reps > existingPR.reps);

      if (isBetter) {
        // Replace existing PR (unique constraint handles it)
        await into(personalRecords).insert(
          PersonalRecordsCompanion.insert(
            exerciseId: exerciseId,
            weightPerCableKg: weightPerCableKg,
            reps: reps,
            workoutMode: workoutMode,
            timestamp: timestamp,
          ),
          mode: InsertMode.insertOrReplace,
        );
        return true;
      }

      return false;
    });
  }
}
```

### Chart Integration

#### fl_chart Package
```yaml
dependencies:
  fl_chart: ^0.66.0
```

#### Weight Progression Chart
```dart
Widget _buildWeightProgressionChart(List<PersonalRecord> prs, WeightUnit unit) {
  final spots = prs
      .sortedBy((pr) => pr.timestamp)
      .mapIndexed((i, pr) => FlSpot(i.toDouble(), pr.weightPerCableKg))
      .toList();

  return LineChart(
    LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: const Color(0xFF9333EA), // Purple
          barWidth: 3,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF9333EA).withOpacity(0.2),
          ),
        ),
      ],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) => Text(
              formatWeight(value, unit),
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= prs.length) return const Text('');
              final pr = prs[index];
              final date = DateTime.fromMillisecondsSinceEpoch(pr.timestamp);
              return Text(
                DateFormat('MMM d').format(date),
                style: const TextStyle(fontSize: 10),
              );
            },
          ),
        ),
      ),
    ),
  );
}
```

---

## 13. Component Breakdown

### Widgets to Create/Update

#### New Widgets (Create)
1. **PersonalBestsTab** - Main PR list tab
2. **PersonalRecordCard** - Individual PR card with rank badge
3. **PRCelebrationDialog** - Full-screen celebration with confetti
4. **ConfettiPainter** - Custom painter for confetti particles
5. **WeightProgressionChart** - Line chart for weight over time
6. **MuscleGroupDistributionChart** - Pie chart for muscle groups
7. **WorkoutModeDistributionChart** - Bar/pie chart for workout modes
8. **EmptyStatePRCard** - Empty state for no PRs
9. **StatItem** - Small stat display widget (for Trends tab)
10. **ExerciseProgressionCard** - Timeline of PRs for one exercise (Trends tab)

#### Updated Widgets (Modify)
1. **AnalyticsScreen** - Add Personal Bests tab to existing 3-tab layout
2. **ActiveWorkoutScreen** - Add PR celebration listener and dialog

#### Reusable Components
1. **RankBadge** - Colored badge with rank number
2. **PRMetadataRow** - Reps • Mode • Date row
3. **ChartCard** - Wrapper card for charts with title and icon

### Riverpod Providers

1. **personalRecordsProvider** - Stream of all PRs from database
2. **groupedPRsProvider** - Derived provider for grouped/sorted PRs
3. **exerciseNamesProvider** - Family provider for exercise name lookup
4. **muscleGroupCountsProvider** - Derived provider for muscle group distribution
5. **prCelebrationProvider** - Stream provider for celebration events
6. **personalRecordRepositoryProvider** - Repository instance

### Drift Tables/DAOs

1. **PersonalRecords** table (already exists)
2. **PersonalRecordDao** - DAO with PR-specific queries
3. **updatePRIfBetter** method - Transaction for PR comparison and update

### Services/Repositories

1. **PersonalRecordRepository** - Repository for PR operations
2. **WorkoutService** - Emits PR celebration events
3. **ExerciseRepository** - Lookup exercise names/muscle groups

### Models

1. **PersonalRecord** (domain model)
2. **PRCelebrationEvent** (event model)
3. **ConfettiParticle** (animation model)

### Animations

1. **ConfettiAnimationController** - 3-second confetti loop
2. **PulseAnimationController** - 500ms pulse for text/stars
3. **ScaleAnimationController** - Card tap animation
4. **StarRotationAnimation** - (optional, not used in final)

---

## CRITICAL FINDINGS

### 1. PR Screen is NOT a Standalone Screen
**The PR functionality is embedded in the Analytics screen as the "Personal Bests" tab (tab index 1).**

Do NOT create a separate `PRScreen` widget. Instead:
- Add a `PersonalBestsTab` widget
- Integrate it into the existing `AnalyticsScreen` as the second tab

### 2. PR Celebration Triggers During Workout
**The celebration dialog is NOT shown in the PR screen.** It's shown:
- In `ActiveWorkoutScreen`
- Immediately after workout completion
- Only if a new PR is achieved

Implementation:
```dart
// In ActiveWorkoutScreen
final prCelebrationEvent = ref.watch(prCelebrationProvider);

prCelebrationEvent.whenData((event) {
  if (event != null) {
    showDialog(
      context: context,
      builder: (_) => PRCelebrationDialog(
        event: event,
        onDismiss: () => /* clear event */,
      ),
    );
  }
});
```

### 3. One PR Per Exercise+Mode Combination
**Database constraint:** `unique(exerciseId, workoutMode)`

This means:
- "Bench Press - OldSchool" is ONE PR
- "Bench Press - Pump" is a DIFFERENT PR
- Each mode tracks separately

The UI shows **only the best PR per exercise** (across all modes).

### 4. PRs NOT Tracked for Just Lift or Echo Mode
```kotlin
val isEchoMode = params.workoutType is WorkoutType.Echo
if (working > 0 && !params.isJustLift && !isEchoMode) {
    // Update PR
}
```

**Flutter implementation must match this logic exactly.**

### 5. Confetti Animation is Custom Canvas
**Do NOT use a confetti package.** The Kotlin implementation uses:
- Custom `Canvas` composable
- 30 particles with physics simulation
- Specific colors, velocities, gravity

Port the exact animation logic using Flutter's `CustomPainter`.

### 6. Charts Use MPAndroidChart Library
In Flutter, use **fl_chart** package instead:
```yaml
dependencies:
  fl_chart: ^0.66.0
```

Match the chart styling (colors, line width, cubic interpolation) from the Kotlin version.

### 7. Export Functionality
**CSV export is available** for:
- Personal records
- Workout history
- PR progression

Use Flutter's `share_plus` package for sharing CSV files.

### 8. No Filtering UI (Yet)
Current implementation shows ALL PRs with no filters. Future enhancement opportunity.

### 9. Exercise Name Lookup is Async
```dart
// Use FutureProvider.family for async lookup
final exerciseNamesProvider = FutureProvider.family<String, String>((ref, id) async {
  final exercise = await ref.read(exerciseRepositoryProvider).getExerciseById(id);
  return exercise?.name ?? 'Unknown Exercise';
});
```

Show "Loading..." placeholder while fetching.

### 10. Muscle Group Distribution Requires Parsing
Exercise `muscleGroups` field is a **comma-separated string**: `"Chest,Triceps,Shoulders"`

Parse it:
```dart
final groups = exercise.muscleGroups.split(',').map((g) => g.trim()).where((g) => g.isNotEmpty);
```

---

## Summary Statistics

| Metric | Count |
|--------|-------|
| PR Types Tracked | 2 (Overall, Mode-specific) |
| Celebration Animations | 1 (Confetti dialog) |
| Database Tables | 1 (personal_records) |
| Database Queries | 5 (getAllPRsGrouped, getLatestPR, getBestPR, getPRsForExercise, updatePRIfBetter) |
| Widgets to Create | 10 new, 2 modified |
| Riverpod Providers | 6 |
| Chart Components | 3 (Weight Progression, Muscle Group, Workout Mode) |
| Animation Controllers | 3 (Confetti, Pulse, Scale) |
| Confetti Particles | 30 |
| Auto-Dismiss Time | 3 seconds |
| Card Rank Colors | 3 (Gold for #1, Silver for #2-3, Purple for #4+) |
| Supported Workout Modes | 5 (OldSchool, Pump, TUT, TUTBeast, EccentricOnly) |
| Export Formats | 1 (CSV) |

---

## Complexity Assessment

**Overall Complexity: MEDIUM**

### Breakdown:

| Component | Complexity | Reasoning |
|-----------|-----------|-----------|
| Data Layer | Low | Simple table, straightforward queries |
| Repository | Low | Thin wrapper over DAO |
| State Management | Medium | Multiple providers, async lookups |
| UI Layout | Low | Standard list with cards |
| Animation | Medium-High | Custom confetti physics, multiple animations |
| Charts | Medium | Third-party library integration |
| Business Logic | Medium | PR comparison logic, mode filtering |
| Navigation | Low | Embedded in tab system |
| Export | Low | CSV generation and sharing |

**Estimated Implementation Time:**
- Data layer: 2-3 hours
- Repository/Providers: 2-3 hours
- UI (list, cards): 3-4 hours
- Charts: 4-5 hours
- Celebration animation: 5-6 hours
- Testing: 3-4 hours
- **Total: 19-25 hours**

---

## Testing Requirements

### Unit Tests
1. PR comparison logic (`updatePRIfBetter`)
2. Grouping/sorting algorithm
3. Exercise name fallback logic
4. Muscle group parsing

### Widget Tests
1. PersonalRecordCard rendering
2. Empty state display
3. Rank badge colors
4. Celebration dialog layout

### Integration Tests
1. Database CRUD operations
2. PR detection after workout
3. Celebration trigger flow
4. Chart data binding

### Hardware Tests
1. **PR achievement during actual workout**
2. Export CSV file sharing
3. Chart rendering performance
4. Animation smoothness on low-end devices

---

## Dependencies

### Flutter Packages Required
```yaml
dependencies:
  # State management
  flutter_riverpod: ^2.5.1

  # Database
  drift: ^2.16.0
  drift_flutter: ^0.1.0

  # Charts
  fl_chart: ^0.66.0

  # Date formatting
  intl: ^0.19.0

  # CSV export
  csv: ^6.0.0
  share_plus: ^7.2.2
  path_provider: ^2.1.2

  # Utilities
  collection: ^1.18.0

dev_dependencies:
  drift_dev: ^2.16.0
  build_runner: ^2.4.8
```

---

## Migration Notes

### Kotlin → Dart Translations

| Kotlin | Dart | Notes |
|--------|------|-------|
| `StateFlow<T>` | `StreamProvider<T>` | Use Riverpod StreamProvider |
| `suspend fun` | `Future<T> async` | Async/await for coroutines |
| `Flow<T>` | `Stream<T>` | Direct translation |
| `LaunchedEffect` | `useEffect` (hooks) or `initState` | Lifecycle hooks |
| `remember` | `useMemoized` or `Provider` | State management |
| `@Composable` | `Widget` | UI components |
| `Modifier` | `Modifier` (Flutter doesn't have exact equivalent) | Use widget properties |
| `LazyColumn` | `ListView.builder` | Lazy list |
| `Card` | `Card` widget | Direct translation |
| `Dialog` | `showDialog` | Dialog display |
| `Canvas` | `CustomPainter` | Custom drawing |
| `@Transaction` | `transaction()` | Drift transactions |

### Color Mappings
```dart
// Kotlin: Color(0xFF9333EA)
// Dart: Color(0xFF9333EA)
// Same hex color format!
```

### Animation Mappings
```kotlin
// Kotlin: rememberInfiniteTransition()
// Dart: AnimationController with repeat()

// Kotlin: animateFloat()
// Dart: Tween<double>().animate()
```

---

## END OF ANALYSIS
