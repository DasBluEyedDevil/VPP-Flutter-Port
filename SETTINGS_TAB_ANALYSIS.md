# Settings Tab - Kotlin to Flutter Exact Matching Analysis

## Executive Summary

The Settings Tab in VitruvianRedux is a moderately complex screen with 6 main sections and 5 configurable settings plus several information/action items. The implementation uses Jetpack Compose with Material 3 theming, DataStore for persistence, and a clean card-based UI design with gradient accents.

**Key Characteristics:**
- **Layout**: Scrollable column with 6 distinct card sections
- **Total Settings**: 5 user-configurable settings + 2 actions + 7 color scheme options + 1 info section
- **Complexity Level**: Moderate
- **State Management**: DataStore with Flow-based reactive updates
- **Visual Style**: Material 3 with custom gradients, rounded corners, shadows, and purple accent theme
- **Navigation**: Links to Connection Logs screen

---

## 1. Screen Structure

### Layout Hierarchy

```
SettingsTab (Scrollable Column)
├── Title: "Settings" (headlineMedium, bold)
├── Card 1: Weight Unit Section
│   ├── Header (icon + title)
│   └── FilterChip Row (KG / LB toggle)
├── Card 2: Workout Preferences Section
│   ├── Header (icon + title)
│   ├── Switch Row: Autoplay Routines
│   ├── Switch Row: Stop At Top
│   └── Switch Row: Show Exercise Videos
├── Card 3: LED Color Scheme Section
│   ├── Header (icon + title)
│   └── List of 7 color buttons (Blue, Green, Teal, Yellow, Pink, Red, Purple)
├── Card 4: Data Management Section
│   ├── Header (icon + title)
│   └── Button: Delete All Workouts (destructive action)
├── Card 5: Developer Tools Section
│   ├── Header (icon + title)
│   ├── OutlinedButton: Connection Logs
│   └── Description text
├── Card 6: App Info Section
│   ├── Header (icon + title)
│   ├── Version text
│   ├── Build text
│   └── Description text
└── Dialogs
    └── AlertDialog: Delete All Workouts confirmation
```

### Scrolling Behavior
- Uses `verticalScroll(rememberScrollState())` on the main Column
- No LazyColumn (all content rendered at once)
- Spacing between cards: `Spacing.medium` (16.dp)
- Outer padding: `Spacing.medium` (16.dp)

---

## 2. Complete Settings Catalog

### Setting 1: Weight Unit
- **Display Label**: "Weight Unit"
- **Type**: FilterChip toggle (segmented control style)
- **Options**: KG | LB
- **Default Value**: `WeightUnit.KG`
- **Preference Key**: `"weight_unit"` (stringPreferencesKey)
- **Data Type**: `WeightUnit` enum (KG, LB)
- **Valid Range**: N/A (enum)
- **Conditional Visibility**: Always visible
- **Change Handler**: `onWeightUnitChange(WeightUnit)`
- **Side Effects**: Updates all weight displays throughout the app
- **Validation**: Enum ensures valid values only
- **Optimistic UI**: Local state `localWeightUnit` provides immediate visual feedback

### Setting 2: Autoplay Routines
- **Display Label**: "Autoplay Routines"
- **Description**: "Automatically advance to next exercise after rest timer"
- **Type**: Switch (toggle)
- **Default Value**: `true`
- **Preference Key**: `"autoplay_enabled"` (booleanPreferencesKey)
- **Data Type**: Boolean
- **Valid Range**: true | false
- **Conditional Visibility**: Always visible
- **Change Handler**: `onAutoplayChange(Boolean)`
- **Side Effects**: Controls automatic exercise progression in routines
- **Validation**: None needed (boolean)

### Setting 3: Stop At Top
- **Display Label**: "Stop At Top"
- **Description**: "Release tension at contracted position instead of extended position"
- **Type**: Switch (toggle)
- **Default Value**: `false` (stop at bottom/extended)
- **Preference Key**: `"stop_at_top"` (booleanPreferencesKey)
- **Data Type**: Boolean
- **Valid Range**: true | false
- **Conditional Visibility**: Always visible
- **Change Handler**: `onStopAtTopChange(Boolean)`
- **Side Effects**: Changes BLE protocol commands for rep detection
- **Validation**: None needed (boolean)
- **Note**: false = stop at bottom (extended), true = stop at top (contracted)

### Setting 4: Show Exercise Videos
- **Display Label**: "Show Exercise Videos"
- **Description**: "Display exercise demonstration videos (disable to avoid slow loading)"
- **Type**: Switch (toggle)
- **Default Value**: `true`
- **Preference Key**: `"enable_video_playback"` (booleanPreferencesKey)
- **Data Type**: Boolean
- **Valid Range**: true | false
- **Conditional Visibility**: Always visible
- **Change Handler**: `onEnableVideoPlaybackChange(Boolean)`
- **Side Effects**: Controls video player visibility in exercise screens
- **Validation**: None needed (boolean)
- **Note**: Performance optimization setting

### Setting 5: LED Color Scheme
- **Display Label**: "LED Color Scheme"
- **Type**: Button list (7 options)
- **Options**: Blue (0), Green (1), Teal (2), Yellow (3), Pink (4), Red (5), Purple (6)
- **Default Value**: Not specified in code (likely 0 = Blue)
- **Preference Key**: Not stored in UserPreferences (likely sent directly to BLE)
- **Data Type**: Int (0-6 index)
- **Valid Range**: 0-6
- **Conditional Visibility**: Always visible
- **Change Handler**: `onColorSchemeChange(Int)` - receives index (0-6)
- **Side Effects**: Sends BLE command to change LED colors on Vitruvian device
- **Validation**: Index bounds (0-6)

### Action 1: Delete All Workouts
- **Display Label**: "Delete All Workouts"
- **Type**: Button (destructive action)
- **Description**: N/A (in card header: "Data Management")
- **Confirmation Dialog**: Yes - "This will permanently delete all workout history. This action cannot be undone."
- **Change Handler**: `onDeleteAllWorkouts()`
- **Side Effects**: Clears all workout sessions from database

### Action 2: Connection Logs
- **Display Label**: "Connection Logs"
- **Type**: OutlinedButton (navigation)
- **Description**: "View Bluetooth connection debug logs to diagnose connectivity issues"
- **Navigation Target**: Connection Logs screen
- **Change Handler**: `onNavigateToConnectionLogs()`
- **Side Effects**: Navigates to debug logs screen

### Info Section: App Info
- **Version**: "0.4.0-beta" (hardcoded)
- **Build**: "Beta 4" (hardcoded)
- **Description**: "Open source community project to control Vitruvian Trainer machines locally."
- **Type**: Read-only text display

---

## 3. Visual Design Specifications

### Typography

#### Screen Title
- **Text**: "Settings"
- **Style**: `MaterialTheme.typography.headlineMedium`
- **Font Weight**: `FontWeight.Bold`
- **Color**: `MaterialTheme.colorScheme.onSurface`
- **Typical Size**: ~28sp (Material 3 default)

#### Card Section Headers
- **Style**: `MaterialTheme.typography.titleMedium`
- **Font Weight**: `FontWeight.Bold`
- **Color**: `MaterialTheme.colorScheme.onSurface`
- **Typical Size**: ~16sp

#### Setting Labels (Primary)
- **Style**: `MaterialTheme.typography.bodyLarge`
- **Font Weight**: `FontWeight.Medium`
- **Color**: `MaterialTheme.colorScheme.onSurface`
- **Typical Size**: ~16sp

#### Setting Descriptions (Secondary)
- **Style**: `MaterialTheme.typography.bodySmall`
- **Color**: `MaterialTheme.colorScheme.onSurfaceVariant`
- **Typical Size**: ~12sp

#### Info Text
- **Style**: `MaterialTheme.typography.bodySmall`
- **Color**: `MaterialTheme.colorScheme.onSurfaceVariant`
- **Typical Size**: ~12sp

#### Version/Build Text
- **Color**: `MaterialTheme.colorScheme.onSurface`
- **Implicit Style**: Default text style

### Spacing (All from Spacing object - 8dp grid system)

#### Screen Padding
- **Outer padding**: `Spacing.medium` = **16.dp**
- **Vertical spacing between cards**: `Spacing.medium` = **16.dp**

#### Card Internal Padding
- **All cards**: `Spacing.medium` = **16.dp** on all sides

#### Section Header Spacing
- **Icon to Text**: `Spacing.medium` = **16.dp**
- **Header to Content**: `Spacing.small` = **8.dp**

#### Setting Item Spacing
- **Label to Description**: **4.dp** (hardcoded)
- **Between settings**: `Spacing.medium` = **16.dp**

#### FilterChip Spacing (Weight Unit)
- **Horizontal gap between chips**: `Spacing.small` = **8.dp**

#### Button Content Spacing
- **Icon to Text**: `Spacing.small` = **8.dp**
- **Delete button icon to text**: **4.dp** (hardcoded)

#### Spacing Constants Reference
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

### Card Styling

#### All Setting Cards
- **Shape**: `RoundedCornerShape(16.dp)`
- **Background Color**: `MaterialTheme.colorScheme.surface`
- **Elevation**: `4.dp` (default elevation)
- **Shadow**: `shadow(4.dp, RoundedCornerShape(16.dp))` modifier
- **Border**: `BorderStroke(1.dp, Color(0xFFF5F3FF))` - light purple tint
- **Width**: `fillMaxWidth()`

### Icon Styling

#### Section Header Icons
- **Size**: **40.dp** (Box size)
- **Shape**: `RoundedCornerShape(12.dp)`
- **Shadow**: `shadow(4.dp, RoundedCornerShape(12.dp))`
- **Background**: Linear gradient (varies by section)
- **Tint**: `MaterialTheme.colorScheme.onPrimary`

#### Icon Gradients by Section:
1. **Weight Unit** (Scale icon):
   - Gradient: `Color(0xFF8B5CF6)` → `Color(0xFF9333EA)`
   - Icon: `Icons.Default.Scale`

2. **Workout Preferences** (Tune icon):
   - Gradient: `Color(0xFF6366F1)` → `Color(0xFF8B5CF6)`
   - Icon: `Icons.Default.Tune`

3. **LED Color Scheme** (ColorLens icon):
   - Gradient: `Color(0xFF3B82F6)` → `Color(0xFF6366F1)`
   - Icon: `Icons.Default.ColorLens`

4. **Data Management** (DeleteForever icon):
   - Gradient: `Color(0xFFF97316)` → `Color(0xFFEF4444)` (orange to red)
   - Icon: `Icons.Default.DeleteForever`

5. **Developer Tools** (BugReport icon):
   - Gradient: `Color(0xFFF59E0B)` → `Color(0xFFEF4444)` (amber to red)
   - Icon: `Icons.Default.BugReport`

6. **App Info** (Info icon):
   - Gradient: `Color(0xFF22C55E)` → `Color(0xFF3B82F6)` (green to blue)
   - Icon: `Icons.Default.Info`

#### Action Button Icons
- **Connection Logs icon**: `Icons.Default.Timeline`, size default
- **Delete button icon**: `Icons.Default.Delete`, size **18.dp**

### Switch Styling
- **Default Material 3 styling** (no custom colors specified)
- **Checked state**: Uses `MaterialTheme.colorScheme.primary`
- **Unchecked state**: Default Material 3 colors

### FilterChip Styling (Weight Unit)
- **Shape**: Default rounded shape
- **Selected Container Color**: `MaterialTheme.colorScheme.primary`
- **Selected Label Color**: `MaterialTheme.colorScheme.onPrimary`
- **Unselected Container Color**: `MaterialTheme.colorScheme.surface`
- **Unselected Label Color**: `MaterialTheme.colorScheme.onSurfaceVariant`
- **Width**: Each chip is `weight(1f)` - equal distribution

### Button Styling

#### Delete All Workouts Button
- **Type**: `Button`
- **Modifier**: `fillMaxWidth()`
- **Container Color**: `MaterialTheme.colorScheme.error` (red)
- **Content**: Icon + Text ("Delete All Workouts")
- **Icon to Text spacing**: `Spacing.small` = **8.dp**

#### Connection Logs Button
- **Type**: `OutlinedButton`
- **Modifier**: `fillMaxWidth()`
- **Content**: Icon + Text ("Connection Logs")
- **Icon to Text spacing**: `Spacing.small` = **8.dp**

#### Color Scheme Buttons
- **Type**: `TextButton`
- **Modifier**: `fillMaxWidth()`
- **Content**: Row with `SpaceBetween` arrangement
  - Left: Color name text (`MaterialTheme.colorScheme.onSurface`)
  - Right: Arrow icon (`Icons.AutoMirrored.Filled.KeyboardArrowRight`, `MaterialTheme.colorScheme.primary`)

### Dialog Styling

#### Delete All Workouts Confirmation Dialog
- **Container Color**: `MaterialTheme.colorScheme.surface`
- **Shape**: `RoundedCornerShape(16.dp)`
- **Title**: "Delete All Workouts?"
- **Text**: "This will permanently delete all workout history. This action cannot be undone."
- **Confirm Button**: TextButton with "Delete All" (error color)
- **Dismiss Button**: TextButton with "Cancel" (onSurfaceVariant color)

### Theme Colors Reference

```kotlin
// Background Colors
val BackgroundBlack = Color(0xFF000000)
val BackgroundDarkGrey = Color(0xFF121212)
val SurfaceDarkGrey = Color(0xFF1E1E1E)
val CardBackground = Color(0xFF252525)

// Light Theme Colors
val ColorLightBackground = Color(0xFFF8F9FB)
val ColorOnLightBackground = Color(0xFF0F172A)
val ColorLightSurface = Color(0xFFFFFFFF)
val ColorOnLightSurface = Color(0xFF111827)
val ColorLightSurfaceVariant = Color(0xFFF3F4F6)
val ColorOnLightSurfaceVariant = Color(0xFF6B7280)

// Purple Accent Colors
val PrimaryPurple = Color(0xFFBB86FC)
val SecondaryPurple = Color(0xFF9965F4)
val TertiaryPurple = Color(0xFFE0BBF7)
val PurpleAccent = Color(0xFF7E57C2)

// Status Colors
val SuccessGreen = Color(0xFF4CAF50)
val ErrorRed = Color(0xFFF44336)
val WarningOrange = Color(0xFFFF9800)
val InfoBlue = Color(0xFF2196F3)
```

---

## 4. Interaction Patterns

### Weight Unit Change
1. User taps KG or LB FilterChip
2. Local optimistic state updates immediately (`localWeightUnit`)
3. Callback invoked: `onWeightUnitChange(WeightUnit)`
4. Parent updates DataStore asynchronously
5. All weight displays throughout app react to new unit

### Switch Toggles (Autoplay, Stop At Top, Show Videos)
1. User taps switch
2. Switch animates to new state (Material 3 default animation)
3. Callback invoked with new boolean value
4. Parent updates DataStore asynchronously
5. Setting persisted and applied to relevant features

### LED Color Scheme Selection
1. User taps one of 7 color name buttons
2. Callback invoked: `onColorSchemeChange(index)` where index is 0-6
3. Parent sends BLE command to device with color scheme index
4. Device LEDs change color (no local UI feedback in settings)

### Delete All Workouts
1. User taps "Delete All Workouts" button
2. Confirmation dialog appears (`showDeleteAllDialog = true`)
3. User can:
   - Tap "Delete All" (error color) → `onDeleteAllWorkouts()` invoked, dialog dismisses
   - Tap "Cancel" (surface variant color) → Dialog dismisses, no action
   - Tap outside or back → Dialog dismisses, no action

### Connection Logs Navigation
1. User taps "Connection Logs" outlined button
2. Callback invoked: `onNavigateToConnectionLogs()`
3. Parent navigates to Connection Logs screen

### Auto-Connect Overlays
- If `isAutoConnecting == true`: Shows `ConnectingOverlay` with cancel option
- If `connectionError != null`: Shows `ConnectionErrorDialog` with error message
- These overlays appear above the entire settings UI

---

## 5. Data Persistence Architecture

### DataStore Implementation

#### PreferencesManager Class
- **Location**: `com.example.vitruvianredux.data.preferences.PreferencesManager`
- **Injection**: Singleton, Hilt-injected
- **DataStore Name**: `"user_preferences"`
- **Pattern**: Reactive Flow-based with `DataStore<Preferences>`

#### Preference Keys

```kotlin
// In PreferencesManager
private val WEIGHT_UNIT_KEY = stringPreferencesKey("weight_unit")
private val AUTOPLAY_ENABLED_KEY = booleanPreferencesKey("autoplay_enabled")
private val STOP_AT_TOP_KEY = booleanPreferencesKey("stop_at_top")
private val ENABLE_VIDEO_PLAYBACK_KEY = booleanPreferencesKey("enable_video_playback")
```

#### Default Values

```kotlin
// In UserPreferences data class
data class UserPreferences(
    val weightUnit: WeightUnit = WeightUnit.KG,            // Default: KG
    val autoplayEnabled: Boolean = true,                    // Default: enabled
    val stopAtTop: Boolean = false,                         // Default: stop at bottom
    val enableVideoPlayback: Boolean = true                 // Default: show videos
)
```

#### Reactive Flow

```kotlin
val preferencesFlow: Flow<UserPreferences> = context.dataStore.data
    .map { preferences ->
        val weightUnitString = preferences[WEIGHT_UNIT_KEY]
        val weightUnit = try {
            weightUnitString?.let { WeightUnit.valueOf(it) } ?: WeightUnit.KG
        } catch (e: IllegalArgumentException) {
            Timber.w(e, "Invalid weight unit in preferences: $weightUnitString, defaulting to KG")
            WeightUnit.KG
        }
        val autoplayEnabled = preferences[AUTOPLAY_ENABLED_KEY] ?: true
        val stopAtTop = preferences[STOP_AT_TOP_KEY] ?: false
        val enableVideoPlayback = preferences[ENABLE_VIDEO_PLAYBACK_KEY] ?: true

        UserPreferences(
            weightUnit = weightUnit,
            autoplayEnabled = autoplayEnabled,
            stopAtTop = stopAtTop,
            enableVideoPlayback = enableVideoPlayback
        )
    }
```

#### Write Methods

```kotlin
suspend fun setWeightUnit(unit: WeightUnit) {
    context.dataStore.edit { preferences ->
        preferences[WEIGHT_UNIT_KEY] = unit.name  // Stores enum name as string
    }
    Timber.d("Weight unit preference set to: ${unit.name}")
}

suspend fun setAutoplayEnabled(enabled: Boolean) {
    context.dataStore.edit { preferences ->
        preferences[AUTOPLAY_ENABLED_KEY] = enabled
    }
    Timber.d("Autoplay enabled preference set to: $enabled")
}

suspend fun setStopAtTop(enabled: Boolean) {
    context.dataStore.edit { preferences ->
        preferences[STOP_AT_TOP_KEY] = enabled
    }
    Timber.d("Stop at top preference set to: $enabled")
}

suspend fun setEnableVideoPlayback(enabled: Boolean) {
    context.dataStore.edit { preferences ->
        preferences[ENABLE_VIDEO_PLAYBACK_KEY] = enabled
    }
    Timber.d("Enable video playback preference set to: $enabled")
}
```

### Data Flow Pattern

1. **UI Layer**: Settings screen displays current values from state
2. **ViewModel**: Observes `preferencesFlow`, exposes state to UI
3. **User Action**: UI invokes callback (e.g., `onWeightUnitChange`)
4. **ViewModel**: Calls `PreferencesManager.setWeightUnit()`
5. **Repository**: Writes to DataStore asynchronously
6. **DataStore**: Persists to disk, emits new value in Flow
7. **ViewModel**: Receives updated preferences, updates state
8. **UI**: Recomposes with new values

### Notes on LED Color Scheme
- **Not persisted in DataStore** (not in UserPreferences model)
- Likely sent directly to BLE device when changed
- Device may remember setting internally, or app may use default on reconnect

---

## 6. Theme Management

### Current Implementation
The SettingsTab itself **does not implement theme switching**. It uses Material 3 theming with no explicit dark/light mode toggle visible.

### Theme System Present in App
The app has a full theme system defined in `ui/theme/`:
- **Dark Theme Colors**: BackgroundBlack, SurfaceDarkGrey, CardBackground, PrimaryPurple
- **Light Theme Colors**: ColorLightBackground, ColorLightSurface, ColorLightSurfaceVariant

### Expected Theme Implementation (Not in Current Code)
Based on common Android patterns, theme switching would typically:
1. Store theme preference in DataStore (e.g., `"theme_mode"`: "light" | "dark" | "system")
2. Read preference in MainActivity or App composable
3. Wrap app content in `MaterialTheme(colorScheme = if (darkMode) darkColorScheme else lightColorScheme)`
4. Provide theme toggle in Settings UI (currently absent)

### Recommendation for Flutter Port
Add a theme preference setting to Settings Tab:
- **Label**: "Theme"
- **Options**: Light, Dark, System
- **Store in**: `shared_preferences` as string ("light", "dark", "system")
- **Apply via**: Riverpod provider watching theme preference

---

## 7. State Management

### ViewModel Pattern (Kotlin)
Settings values are passed as individual parameters to `SettingsTab` composable. No explicit ViewModel code provided, but typical pattern would be:

```kotlin
// Hypothetical ViewModel (not in provided code)
class SettingsViewModel @Inject constructor(
    private val preferencesManager: PreferencesManager,
    private val workoutRepository: WorkoutRepository,
    // ... other dependencies
) : ViewModel() {

    val userPreferences: StateFlow<UserPreferences> =
        preferencesManager.preferencesFlow
            .stateIn(viewModelScope, SharingStarted.Eagerly, UserPreferences())

    fun setWeightUnit(unit: WeightUnit) {
        viewModelScope.launch {
            preferencesManager.setWeightUnit(unit)
        }
    }

    fun setAutoplayEnabled(enabled: Boolean) {
        viewModelScope.launch {
            preferencesManager.setAutoplayEnabled(enabled)
        }
    }

    // ... other methods

    fun deleteAllWorkouts() {
        viewModelScope.launch {
            workoutRepository.deleteAllWorkouts()
        }
    }

    fun sendColorSchemeCommand(colorIndex: Int) {
        viewModelScope.launch {
            bleManager.sendColorSchemeCommand(colorIndex)
        }
    }
}
```

### State Flow Pattern
1. **PreferencesManager** exposes `preferencesFlow: Flow<UserPreferences>`
2. **ViewModel** collects flow into `StateFlow` (hot stream)
3. **UI** observes `StateFlow` via `collectAsState()`
4. **User Actions** invoke ViewModel methods
5. **ViewModel** updates DataStore
6. **Flow** emits new state
7. **UI** recomposes automatically

### Optimistic UI
The weight unit setting uses local state for immediate feedback:
```kotlin
var localWeightUnit by remember(weightUnit) { mutableStateOf(weightUnit) }

FilterChip(
    selected = localWeightUnit == WeightUnit.KG,
    onClick = {
        localWeightUnit = WeightUnit.KG  // Immediate UI update
        onWeightUnitChange(WeightUnit.KG)  // Async persistence
    },
    // ...
)
```
This prevents UI lag while DataStore write completes.

---

## 8. Edge Cases and Validation

### Weight Unit
- **Invalid Enum Handling**: `PreferencesManager` catches `IllegalArgumentException` when parsing string to enum
- **Fallback**: Defaults to `WeightUnit.KG` if invalid value found
- **Logging**: Warns via Timber when invalid value encountered

### Boolean Settings
- **No validation needed**: Boolean type is inherently safe
- **Nulls**: Default values provided (`?: true` or `?: false`)

### LED Color Scheme
- **Index Bounds**: Should validate `colorIndex` is in 0-6 range before sending to BLE
- **Not implemented**: Code doesn't show validation, assumes UI enforces bounds

### Delete All Workouts
- **Confirmation Required**: AlertDialog prevents accidental deletion
- **No undo**: Warning text states "This action cannot be undone"
- **Error Handling**: Not shown in UI code, likely handled in repository/ViewModel

### Connection Logs Navigation
- **No special validation**: Simple navigation action

### DataStore Write Failures
- **Not explicitly handled in UI**: Errors during `dataStore.edit` would be logged but not surfaced to user
- **Recommendation**: Add error handling and user notification for critical failures

### Optimistic UI Sync Issues
- **Scenario**: Local state updates, but DataStore write fails
- **Current**: No rollback mechanism shown
- **Recommendation**: Revert optimistic state on write failure

---

## 9. Flutter Implementation Guide

### 9.1 Riverpod State Management

#### Providers to Create

```dart
// lib/presentation/providers/user_preferences_provider.dart

// Preferences repository provider
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepository();
});

// User preferences state provider (auto-refresh from SharedPreferences)
final userPreferencesProvider = StreamProvider<UserPreferences>((ref) {
  final repo = ref.watch(preferencesRepositoryProvider);
  return repo.watchPreferences();
});

// Individual setting providers (convenience accessors)
final weightUnitProvider = Provider<WeightUnit>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return prefs.maybeWhen(
    data: (data) => data.weightUnit,
    orElse: () => WeightUnit.kg,
  );
});

// Settings notifier for actions
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(
    ref.watch(preferencesRepositoryProvider),
    ref.watch(workoutRepositoryProvider),
    ref.watch(bleServiceProvider),
  );
});
```

#### State Notifier

```dart
class SettingsNotifier extends StateNotifier<SettingsState> {
  final PreferencesRepository _preferencesRepo;
  final WorkoutRepository _workoutRepo;
  final BleService _bleService;

  SettingsNotifier(this._preferencesRepo, this._workoutRepo, this._bleService)
      : super(const SettingsState());

  Future<void> setWeightUnit(WeightUnit unit) async {
    try {
      await _preferencesRepo.setWeightUnit(unit);
      // State updates automatically via StreamProvider
    } catch (e) {
      state = state.copyWith(error: 'Failed to update weight unit');
    }
  }

  Future<void> setAutoplayEnabled(bool enabled) async {
    await _preferencesRepo.setAutoplayEnabled(enabled);
  }

  Future<void> setStopAtTop(bool enabled) async {
    await _preferencesRepo.setStopAtTop(enabled);
  }

  Future<void> setEnableVideoPlayback(bool enabled) async {
    await _preferencesRepo.setEnableVideoPlayback(enabled);
  }

  Future<void> sendColorSchemeCommand(int colorIndex) async {
    if (colorIndex < 0 || colorIndex > 6) {
      throw ArgumentError('Color index must be 0-6');
    }
    await _bleService.sendColorSchemeCommand(colorIndex);
  }

  Future<void> deleteAllWorkouts() async {
    state = state.copyWith(isDeleting: true);
    try {
      await _workoutRepo.deleteAllWorkouts();
      state = state.copyWith(isDeleting: false, deleteSuccess: true);
    } catch (e) {
      state = state.copyWith(isDeleting: false, error: 'Failed to delete workouts');
    }
  }
}
```

### 9.2 SharedPreferences Implementation

#### Preferences Repository

```dart
// lib/data/repositories/preferences_repository.dart

class PreferencesRepository {
  static const String _keyWeightUnit = 'weight_unit';
  static const String _keyAutoplayEnabled = 'autoplay_enabled';
  static const String _keyStopAtTop = 'stop_at_top';
  static const String _keyEnableVideoPlayback = 'enable_video_playback';

  // Stream controller for reactive updates
  final _controller = StreamController<UserPreferences>.broadcast();
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _emitCurrentPreferences();
  }

  Stream<UserPreferences> watchPreferences() {
    return _controller.stream;
  }

  Future<UserPreferences> getPreferences() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();

    final weightUnitString = prefs.getString(_keyWeightUnit);
    WeightUnit weightUnit;
    try {
      weightUnit = WeightUnit.values.firstWhere(
        (e) => e.name == weightUnitString,
        orElse: () => WeightUnit.kg,
      );
    } catch (e) {
      print('Invalid weight unit: $weightUnitString, defaulting to kg');
      weightUnit = WeightUnit.kg;
    }

    return UserPreferences(
      weightUnit: weightUnit,
      autoplayEnabled: prefs.getBool(_keyAutoplayEnabled) ?? true,
      stopAtTop: prefs.getBool(_keyStopAtTop) ?? false,
      enableVideoPlayback: prefs.getBool(_keyEnableVideoPlayback) ?? true,
    );
  }

  Future<void> setWeightUnit(WeightUnit unit) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setString(_keyWeightUnit, unit.name);
    _emitCurrentPreferences();
    print('Weight unit preference set to: ${unit.name}');
  }

  Future<void> setAutoplayEnabled(bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoplayEnabled, enabled);
    _emitCurrentPreferences();
    print('Autoplay enabled preference set to: $enabled');
  }

  Future<void> setStopAtTop(bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setBool(_keyStopAtTop, enabled);
    _emitCurrentPreferences();
    print('Stop at top preference set to: $enabled');
  }

  Future<void> setEnableVideoPlayback(bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setBool(_keyEnableVideoPlayback, enabled);
    _emitCurrentPreferences();
    print('Enable video playback preference set to: $enabled');
  }

  void _emitCurrentPreferences() async {
    final prefs = await getPreferences();
    _controller.add(prefs);
  }

  void dispose() {
    _controller.close();
  }
}
```

### 9.3 Widget Structure

#### Settings Tab Widget

```dart
// lib/presentation/screens/settings_tab.dart

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends ConsumerState<SettingsTab> {
  bool _showDeleteDialog = false;

  @override
  Widget build(BuildContext context) {
    final preferencesAsync = ref.watch(userPreferencesProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);

    return preferencesAsync.when(
      data: (preferences) => _buildContent(context, preferences, settingsNotifier),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildContent(
    BuildContext context,
    UserPreferences preferences,
    SettingsNotifier notifier,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          _buildWeightUnitCard(preferences, notifier),
          const SizedBox(height: AppSpacing.medium),

          _buildWorkoutPreferencesCard(preferences, notifier),
          const SizedBox(height: AppSpacing.medium),

          _buildColorSchemeCard(notifier),
          const SizedBox(height: AppSpacing.medium),

          _buildDataManagementCard(notifier),
          const SizedBox(height: AppSpacing.medium),

          _buildDeveloperToolsCard(),
          const SizedBox(height: AppSpacing.medium),

          _buildAppInfoCard(),
        ],
      ),
    );
  }

  // ... section builder methods
}
```

### 9.4 Kotlin → Flutter Pattern Mappings

| Kotlin Compose | Flutter Equivalent | Notes |
|---|---|---|
| `Card { Column { } }` | `Card(child: Padding(padding: ..., child: Column()))` | Flutter Card doesn't have internal padding |
| `FilterChip` | `ChoiceChip` or `SegmentedButton` | SegmentedButton is closer to iOS/Material 3 style |
| `Switch` | `Switch` | Direct equivalent |
| `TextButton` | `TextButton` | Direct equivalent |
| `Button` | `ElevatedButton` or `FilledButton` | FilledButton is Material 3 equivalent |
| `OutlinedButton` | `OutlinedButton` | Direct equivalent |
| `AlertDialog` | `AlertDialog` | Direct equivalent |
| `RoundedCornerShape(16.dp)` | `RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))` | |
| `Brush.linearGradient(...)` | `LinearGradient(colors: [...])` with `Container` + `decoration` | Flutter uses BoxDecoration |
| `shadow(4.dp, ...)` | `BoxShadow` in `BoxDecoration` | Different API, same effect |
| `Spacing.medium` | `AppSpacing.medium` (custom constant class) | Define spacing constants |
| `MaterialTheme.colorScheme.primary` | `Theme.of(context).colorScheme.primary` | |
| `remember { mutableStateOf(...) }` | `useState` hook or `StatefulWidget` local state | |
| `LaunchedEffect` | `useEffect` hook or `initState`/`didChangeDependencies` | |

### 9.5 Gradient Icon Box Implementation

```dart
// Helper widget for section header icons
class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;
  final double size;

  const GradientIconBox({
    required this.icon,
    required this.gradientColors,
    this.size = 40,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
```

### 9.6 Section Header Implementation

```dart
class SettingsSectionHeader extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;
  final String title;

  const SettingsSectionHeader({
    required this.icon,
    required this.gradientColors,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientIconBox(
          icon: icon,
          gradientColors: gradientColors,
        ),
        const SizedBox(width: AppSpacing.medium),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
```

---

## 10. Component Breakdown

### New Widgets to Create

#### 1. `SettingsTab` Widget
- **File**: `lib/presentation/screens/settings_tab.dart`
- **Type**: `ConsumerStatefulWidget` (Riverpod)
- **Purpose**: Main settings screen container
- **Dependencies**: `userPreferencesProvider`, `settingsNotifierProvider`

#### 2. `SettingsSectionCard` Widget
- **File**: `lib/presentation/widgets/settings_section_card.dart`
- **Type**: `StatelessWidget`
- **Purpose**: Reusable card container for setting sections
- **Props**: `child: Widget`

#### 3. `SettingsSectionHeader` Widget
- **File**: `lib/presentation/widgets/settings_section_header.dart`
- **Type**: `StatelessWidget`
- **Purpose**: Icon + title header for each section
- **Props**: `icon: IconData`, `gradientColors: List<Color>`, `title: String`

#### 4. `GradientIconBox` Widget
- **File**: `lib/presentation/widgets/gradient_icon_box.dart`
- **Type**: `StatelessWidget`
- **Purpose**: Gradient background icon container
- **Props**: `icon: IconData`, `gradientColors: List<Color>`, `size: double`

#### 5. `SettingsSwitchRow` Widget
- **File**: `lib/presentation/widgets/settings_switch_row.dart`
- **Type**: `StatelessWidget`
- **Purpose**: Label + description + switch toggle row
- **Props**: `label: String`, `description: String`, `value: bool`, `onChanged: (bool) -> void`

#### 6. `WeightUnitSelector` Widget
- **File**: `lib/presentation/widgets/weight_unit_selector.dart`
- **Type**: `StatefulWidget` (for optimistic UI)
- **Purpose**: FilterChip-style toggle for KG/LB selection
- **Props**: `selectedUnit: WeightUnit`, `onChanged: (WeightUnit) -> void`

#### 7. `ColorSchemeList` Widget
- **File**: `lib/presentation/widgets/color_scheme_list.dart`
- **Type**: `StatelessWidget`
- **Purpose**: List of color scheme buttons
- **Props**: `colorSchemes: List<String>`, `onColorSelected: (int) -> void`

#### 8. `DeleteConfirmationDialog` Widget
- **File**: `lib/presentation/widgets/delete_confirmation_dialog.dart`
- **Type**: `StatelessWidget`
- **Purpose**: Reusable delete confirmation dialog
- **Props**: `title: String`, `message: String`, `onConfirm: () -> void`, `onCancel: () -> void`

### Existing Widgets to Use

1. **Material Components**: `Card`, `Switch`, `TextButton`, `ElevatedButton`, `OutlinedButton`, `AlertDialog`
2. **Layout Widgets**: `Column`, `Row`, `Padding`, `SizedBox`, `Spacer`, `SingleChildScrollView`
3. **Riverpod Widgets**: `ConsumerWidget`, `ConsumerStatefulWidget`

### Files to Update

#### 1. `lib/core/constants/app_spacing.dart`
- Define spacing constants (extraSmall, small, medium, large, extraLarge, huge)

#### 2. `lib/core/theme/app_colors.dart`
- Define gradient color constants for section icons

#### 3. `lib/domain/models/user_preferences.dart`
- Create `UserPreferences` data class with freezed/json_serializable

#### 4. `lib/data/repositories/preferences_repository.dart`
- Create repository for SharedPreferences access

#### 5. `lib/presentation/providers/user_preferences_provider.dart`
- Create Riverpod providers for preferences state

---

## 11. Code Snippets

### Kotlin: Weight Unit Setting

```kotlin
Row(
    modifier = Modifier.fillMaxWidth(),
    horizontalArrangement = Arrangement.spacedBy(Spacing.small)
) {
    FilterChip(
        selected = localWeightUnit == WeightUnit.KG,
        onClick = {
            localWeightUnit = WeightUnit.KG
            onWeightUnitChange(WeightUnit.KG)
        },
        label = { Text("kg") },
        modifier = Modifier.weight(1f),
        colors = FilterChipDefaults.filterChipColors(
            selectedContainerColor = MaterialTheme.colorScheme.primary,
            selectedLabelColor = MaterialTheme.colorScheme.onPrimary,
            containerColor = MaterialTheme.colorScheme.surface,
            labelColor = MaterialTheme.colorScheme.onSurfaceVariant
        )
    )
    FilterChip(
        selected = localWeightUnit == WeightUnit.LB,
        onClick = {
            localWeightUnit = WeightUnit.LB
            onWeightUnitChange(WeightUnit.LB)
        },
        label = { Text("lbs") },
        modifier = Modifier.weight(1f),
        colors = FilterChipDefaults.filterChipColors(
            selectedContainerColor = MaterialTheme.colorScheme.primary,
            selectedLabelColor = MaterialTheme.colorScheme.onPrimary,
            containerColor = MaterialTheme.colorScheme.surface,
            labelColor = MaterialTheme.colorScheme.onSurfaceVariant
        )
    )
}
```

### Flutter Equivalent: Weight Unit Setting

```dart
class WeightUnitSelector extends StatefulWidget {
  final WeightUnit selectedUnit;
  final ValueChanged<WeightUnit> onChanged;

  const WeightUnitSelector({
    required this.selectedUnit,
    required this.onChanged,
    super.key,
  });

  @override
  State<WeightUnitSelector> createState() => _WeightUnitSelectorState();
}

class _WeightUnitSelectorState extends State<WeightUnitSelector> {
  late WeightUnit _localUnit;

  @override
  void initState() {
    super.initState();
    _localUnit = widget.selectedUnit;
  }

  @override
  void didUpdateWidget(WeightUnitSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedUnit != oldWidget.selectedUnit) {
      _localUnit = widget.selectedUnit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('kg'),
            selected: _localUnit == WeightUnit.kg,
            onSelected: (selected) {
              if (selected) {
                setState(() => _localUnit = WeightUnit.kg);
                widget.onChanged(WeightUnit.kg);
              }
            },
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: _localUnit == WeightUnit.kg
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: ChoiceChip(
            label: const Text('lbs'),
            selected: _localUnit == WeightUnit.lb,
            onSelected: (selected) {
              if (selected) {
                setState(() => _localUnit = WeightUnit.lb);
                widget.onChanged(WeightUnit.lb);
              }
            },
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: _localUnit == WeightUnit.lb
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
```

### Kotlin: Switch Setting Row

```kotlin
Row(
    modifier = Modifier.fillMaxWidth(),
    horizontalArrangement = Arrangement.SpaceBetween,
    verticalAlignment = Alignment.CenterVertically
) {
    Column(
        modifier = Modifier.weight(1f)
    ) {
        Text(
            "Autoplay Routines",
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = FontWeight.Medium,
            color = MaterialTheme.colorScheme.onSurface
        )
        Spacer(modifier = Modifier.height(4.dp))
        Text(
            "Automatically advance to next exercise after rest timer",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
    Switch(
        checked = autoplayEnabled,
        onCheckedChange = onAutoplayChange
    )
}
```

### Flutter Equivalent: Switch Setting Row

```dart
class SettingsSwitchRow extends StatelessWidget {
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchRow({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
```

### Kotlin: Delete Confirmation Dialog

```kotlin
if (showDeleteAllDialog) {
    AlertDialog(
        onDismissRequest = { showDeleteAllDialog = false },
        title = { Text("Delete All Workouts?") },
        text = { Text("This will permanently delete all workout history. This action cannot be undone.") },
        containerColor = MaterialTheme.colorScheme.surface,
        shape = RoundedCornerShape(16.dp),
        confirmButton = {
            TextButton(
                onClick = {
                    onDeleteAllWorkouts()
                    showDeleteAllDialog = false
                }
            ) {
                Text("Delete All", color = MaterialTheme.colorScheme.error)
            }
        },
        dismissButton = {
            TextButton(onClick = { showDeleteAllDialog = false }) {
                Text("Cancel", color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
    )
}
```

### Flutter Equivalent: Delete Confirmation Dialog

```dart
Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete All Workouts?'),
      content: const Text(
        'This will permanently delete all workout history. This action cannot be undone.',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Delete All',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    ),
  );
}

// Usage:
final confirmed = await showDeleteConfirmationDialog(context);
if (confirmed == true) {
  await notifier.deleteAllWorkouts();
}
```

---

## 12. Critical Findings and Recommendations

### Critical Findings

1. **No Theme Toggle**: Settings screen lacks dark/light mode toggle despite app having full theme system
   - **Recommendation**: Add theme preference setting in Flutter port

2. **LED Color Scheme Not Persisted**: Color scheme selection is not stored in UserPreferences
   - **Impact**: Setting is lost on app restart, must be resent to device
   - **Recommendation**: Consider persisting in SharedPreferences for convenience

3. **Optimistic UI Only for Weight Unit**: Other settings don't use optimistic updates
   - **Impact**: Slight lag when toggling switches (waiting for DataStore write)
   - **Recommendation**: Apply optimistic UI pattern to all settings for better UX

4. **No Error Handling in UI**: DataStore write failures not surfaced to user
   - **Recommendation**: Add error snackbars/toasts for persistence failures

5. **Hardcoded Version Info**: App version and build number are hardcoded strings
   - **Recommendation**: Read from `pubspec.yaml` via `package_info_plus` package

6. **Missing Settings**:
   - No language/locale setting
   - No notification preferences
   - No data export/import (only delete)
   - No account/sync settings
   - **Recommendation**: Consider adding for Flutter port if needed

### Performance Considerations

1. **Scrollable Column vs ListView**: Uses Column with ScrollView instead of ListView
   - **Impact**: All content rendered at once (minor performance impact, small list)
   - **Recommendation**: Keep as-is for Settings tab (not enough items to matter)

2. **Gradient Rendering**: 6 gradient boxes rendered simultaneously
   - **Impact**: Minimal (Material 3 is optimized for this)

3. **DataStore Writes**: Each setting writes individually to disk
   - **Impact**: Could batch writes if multiple settings changed rapidly
   - **Recommendation**: Current approach is fine (settings rarely change rapidly)

### Accessibility Considerations

1. **Switch Labels**: All switches have proper labels and descriptions
2. **Icon Content Descriptions**: Most icons have `contentDescription = null` (decorative)
   - **Recommendation**: Add semantic labels for screen reader users
3. **Button Sizes**: All buttons meet minimum touch target sizes (48dp default)

### Testing Recommendations

1. **Unit Tests**:
   - PreferencesRepository read/write operations
   - UserPreferences enum parsing and default values
   - SettingsNotifier state updates

2. **Widget Tests**:
   - Each setting widget interaction
   - Dialog confirmation flow
   - Optimistic UI behavior for weight unit
   - Error state display

3. **Integration Tests**:
   - End-to-end setting persistence (write → read back)
   - Navigation to Connection Logs screen
   - Delete all workouts with database verification

---

## Summary

### Total Settings Count
- **5 configurable settings** (Weight Unit, Autoplay, Stop At Top, Show Videos, LED Color)
- **2 action items** (Delete All Workouts, Connection Logs navigation)
- **7 color scheme options** (Blue, Green, Teal, Yellow, Pink, Red, Purple)
- **1 info section** (Version, Build, Description)
- **Total: 15 interactive elements**

### Number of Categories
**6 card sections**:
1. Weight Unit
2. Workout Preferences
3. LED Color Scheme
4. Data Management
5. Developer Tools
6. App Info

### Complexity Assessment
**Moderate Complexity**

**Reasons**:
- Straightforward settings with boolean/enum types
- No complex validation or interdependencies
- Standard Material 3 widgets throughout
- Reactive state management with DataStore/Flow
- One confirmation dialog for destructive action
- Optimistic UI for one setting (weight unit)

**Challenges**:
- Custom gradient icon boxes require BoxDecoration in Flutter
- DataStore → SharedPreferences translation
- ViewModel → Riverpod StateNotifier pattern
- Ensuring reactive updates work properly with SharedPreferences

### Estimated Flutter Widgets Needed
**8 new custom widgets**:
1. SettingsTab (main screen)
2. SettingsSectionCard (reusable card wrapper)
3. SettingsSectionHeader (icon + title)
4. GradientIconBox (gradient background icon)
5. SettingsSwitchRow (label + description + switch)
6. WeightUnitSelector (FilterChip equivalent)
7. ColorSchemeList (list of color buttons)
8. DeleteConfirmationDialog (reusable confirmation dialog)

**Plus standard Material widgets** (Card, Switch, TextButton, etc.)

### Critical Concerns

1. **Theme Management**: No theme toggle present, need to add for completeness
2. **LED Color Persistence**: Not stored in preferences, may want to add
3. **Error Handling**: No user-facing error messages for persistence failures
4. **Version Info**: Hardcoded, should use package_info_plus
5. **Optimistic UI**: Only implemented for weight unit, consider expanding

### Recommended Implementation Order

1. **Phase 1**: Data layer
   - Create UserPreferences model
   - Implement PreferencesRepository with SharedPreferences
   - Set up Riverpod providers

2. **Phase 2**: Reusable widgets
   - GradientIconBox
   - SettingsSectionHeader
   - SettingsSectionCard
   - SettingsSwitchRow

3. **Phase 3**: Specific widgets
   - WeightUnitSelector
   - ColorSchemeList
   - DeleteConfirmationDialog

4. **Phase 4**: Main screen
   - SettingsTab composable
   - Wire up all providers and callbacks
   - Test persistence and reactivity

5. **Phase 5**: Enhancements
   - Add theme preference setting
   - Implement error handling
   - Add version info from pubspec
   - Polish animations and transitions

---

**END OF ANALYSIS**
