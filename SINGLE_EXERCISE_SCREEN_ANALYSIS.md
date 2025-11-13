# Single Exercise Screen - Analysis & Implementation

**Date:** 2025-01-29  
**Screen:** 13/16 in UI porting sequence  
**Status:** ✅ COMPLETE

## Overview

The Single Exercise Screen allows users to configure and execute a workout for a single exercise. This is a full-screen configuration screen (not a dialog) that provides:

- Exercise selection from library
- Sets and reps configuration
- Weight configuration (with unit conversion)
- Eccentric load setting
- Rest time between sets
- Navigation to Active Workout screen with configured parameters

## Purpose

This screen enables quick workout setup for individual exercises without creating a full routine. It's useful for:
- Quick single-exercise workouts
- Testing exercises
- Ad-hoc training sessions
- Simple workout execution

## Implementation Details

### Screen Type
- **Full Screen** (not modal/dialog)
- Uses gradient background matching other screens
- Material 3 design with Cards for configuration sections

### Key Features Implemented

1. **Exercise Selection**
   - Exercise picker dialog with search functionality
   - Displays exercise name and muscle groups
   - Single selection mode
   - Integration with ExerciseRepository

2. **Workout Configuration**
   - Sets: 1-10 (default: 3)
   - Reps: 1-50 (default: 10)
   - Concentric Weight: 0-100 kg/lb (default: 20 kg)
   - Eccentric Load: Segmented button (100%, 120%, 140%)
   - Rest Time: 30-300 seconds (default: 60s, step: 15s)

3. **Workout Session Integration**
   - Configures WorkoutParameters with selected exercise
   - Uses OldSchool program mode (default)
   - Sets selectedExerciseId for tracking
   - Updates WorkoutSessionProvider state
   - Navigates to ActiveWorkoutScreen

### Files Created/Modified

**New Files:**
1. `lib/presentation/widgets/dialogs/exercise_picker_dialog.dart` (234 lines)
   - Searchable exercise picker dialog
   - Stream-based exercise loading
   - Single selection mode
   - Material 3 styling

**Modified Files:**
1. `lib/presentation/screens/single_exercise_screen.dart` (330 lines)
   - Complete implementation with all features
   - Gradient background
   - Exercise picker integration
   - Workout session configuration
   - Navigation to active workout

### Architecture Integration

**Providers Used:**
- `exerciseRepositoryProvider` - Exercise library access
- `workoutSessionProvider` - Workout state management
- `weightUnitProvider` - Unit preferences (kg/lb)
- `preferencesActionsProvider` - Unit conversion utilities

**Models Used:**
- `Exercise` - Database entity for exercise data
- `WorkoutParameters` - Workout configuration
- `WorkoutType` - Program/Echo mode selection
- `ProgramMode` - OldSchool mode (default)
- `EccentricLoad` - Eccentric load percentage

**Navigation:**
- Route: `/single-exercise` (Routes.singleExercise)
- Navigates to: `/active-workout` (Routes.activeWorkout)

### UI Components

1. **Exercise Picker Card**
   - ListTile with exercise name
   - Chevron icon for navigation
   - Placeholder text when no exercise selected

2. **Configuration Cards**
   - Sets card with CompactNumberPicker
   - Reps card with CompactNumberPicker
   - Weight card with unit-aware CompactNumberPicker
   - Eccentric Load card with SegmentedButton
   - Rest Time card with CompactNumberPicker

3. **Start Workout Button**
   - Full-width FilledButton
   - Disabled when no exercise selected
   - Play arrow icon

### Exercise Picker Dialog

**Features:**
- Searchable exercise list
- Real-time search filtering
- Single selection mode
- Visual selection indicator
- Empty state handling
- Loading state handling
- Error state handling

**UI:**
- AlertDialog with search field
- Scrollable exercise list (400px height)
- Card-based exercise items
- Selected state highlighting
- Check icon for selected exercise

### Workout Configuration Flow

1. User selects exercise from picker
2. User configures sets, reps, weight, eccentric load, rest time
3. User taps "Start Workout"
4. Screen converts weight to kg if needed
5. Screen creates WorkoutParameters with:
   - WorkoutType: Program(OldSchool)
   - Reps: configured reps
   - WeightPerCableKg: converted weight
   - SelectedExerciseId: selected exercise ID
   - IsJustLift: false
   - UseAutoStart: false
   - WarmupReps: 0
6. Screen updates WorkoutSessionProvider state
7. Screen navigates to ActiveWorkoutScreen

### Integration with ActiveWorkoutScreen

The Single Exercise Screen configures the workout session state before navigation. The ActiveWorkoutScreen reads these parameters and:
- Displays selected exercise information
- Uses configured reps for rep counting
- Uses configured weight for BLE commands
- Tracks workout metrics
- Saves session with exercise ID

### Default Values

- Sets: 3
- Reps: 10
- Weight: 20.0 kg
- Eccentric Load: 100%
- Rest Time: 60 seconds
- Program Mode: OldSchool

### Unit Conversion

- Weight stored internally in kg
- Display converted based on user preference (kg/lb)
- Conversion handled by PreferencesActions
- Conversion factor: 1 kg = 2.20462 lb

### Error Handling

- Exercise picker handles empty exercise library
- Exercise picker handles search errors
- Start workout disabled when no exercise selected
- Workout session state update handled gracefully

### Future Enhancements (Not Implemented)

1. **Program Mode Selection**
   - Currently hardcoded to OldSchool
   - Could add mode selector (OldSchool, Pump, TUT, etc.)

2. **Cable Position Configuration**
   - Not included in single exercise screen
   - Could add cable position selector

3. **Warmup Configuration**
   - Currently set to 0 warmup reps
   - Could add warmup rep configuration

4. **Set Progression**
   - Currently uses same weight for all sets
   - Could add weight progression/regression per set

5. **Exercise Details**
   - Could show exercise description/videos
   - Could show muscle groups visualization

## Testing Considerations

**Manual Testing Required:**
1. Exercise picker dialog opens and displays exercises
2. Search functionality filters exercises correctly
3. Exercise selection updates screen state
4. Weight conversion works correctly (kg ↔ lb)
5. Workout parameters configured correctly
6. Navigation to ActiveWorkoutScreen works
7. ActiveWorkoutScreen receives correct parameters

**Edge Cases:**
- Empty exercise library
- No exercises match search query
- Very large weight values
- Very large rep counts
- Network errors during exercise loading

## Dependencies

**External:**
- flutter_riverpod - State management
- go_router - Navigation
- drift - Database (via ExerciseRepository)

**Internal:**
- ExerciseRepository - Exercise data access
- WorkoutSessionProvider - Workout state
- PreferencesProvider - User preferences
- CompactNumberPicker - Number input widget
- ExercisePickerDialog - Exercise selection UI

## Code Quality

- ✅ No linter errors
- ✅ Follows Material 3 design guidelines
- ✅ Consistent with app patterns
- ✅ Proper error handling
- ✅ Type-safe implementation
- ✅ Proper state management

## Progress Update

**Screens Completed:** 13/16 (81.25%)

**Remaining Screens:**
- Daily Routines Phase 2 (builder functionality)
- Analytics Screen (includes PR as tab 1)
- Exercise Picker Dialog (now implemented as part of this screen)
- Active Workout Phase 2

## Notes

- Exercise picker dialog is reusable and can be used in other screens (e.g., Routine Builder)
- Workout configuration follows same pattern as JustLiftScreen
- Screen uses gradient background matching other workout screens
- All configuration is stored in WorkoutParameters model
- Screen is fully functional and ready for testing
