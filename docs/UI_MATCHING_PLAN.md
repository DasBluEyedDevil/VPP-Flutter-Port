# UI Matching Plan - Kotlin → Flutter Perfect Fidelity

**Goal:** Make Flutter app nearly indistinguishable from Kotlin source app

**Date:** 2025-11-12
**Status:** INITIATED

---

## Methodology

### Phase 1: Screen Inventory & Analysis
Use **Gemini CLI** to:
1. List all screens in Kotlin app
2. Analyze each screen's UI elements, layout, colors, spacing, fonts
3. Document interactions, animations, state changes
4. Identify all features and edge cases

### Phase 2: Gap Analysis
Compare Kotlin analysis with Flutter implementation:
1. Missing UI elements
2. Incorrect layouts
3. Wrong colors/fonts/spacing
4. Missing features/interactions
5. Incorrect behavior

### Phase 3: Implementation
Use **Cursor CLI** to:
1. Implement each screen to match Kotlin exactly
2. Match colors, fonts, spacing pixel-perfect
3. Implement all interactions and animations
4. Handle all edge cases

### Phase 4: Verification
1. Visual comparison screenshots
2. Interaction testing
3. Feature completeness checklist

---

## Screen Inventory (Kotlin App)

### Main Flow Screens
1. **MainActivity** - Entry point, tab container
2. **Home/Dashboard** - Stats, quick actions, recent activity
3. **WorkoutTab** - Workout list, history
4. **RoutinesTab** - Routine management
5. **ProgramsTab** - Weekly program management
6. **SettingsTab** - App settings, preferences

### Workout Screens
7. **ActiveWorkoutScreen** - Real-time workout execution
8. **JustLiftScreen** - Auto-start/stop mode
9. **RoutineExecutionScreen** - Execute saved routine

### Management Screens
10. **RoutineBuilderDialog** - Create/edit routines
11. **ExercisePickerDialog** - Select exercises
12. **WorkoutHistoryScreen** - Past workouts
13. **AnalyticsScreen** - Charts and statistics
14. **PRScreen** - Personal records

### Onboarding/Setup
15. **BleConnectionScreen** - Device pairing
16. **SplashScreen** - App startup

---

## Detailed Analysis Template (per screen)

For each screen, Gemini will document:

### Layout Structure
- Root container type
- Nested layout hierarchy
- Column/Row/Stack organization
- Scaffold structure

### UI Elements
- All widgets (buttons, cards, text, images, icons)
- Element positioning and alignment
- Spacing (padding, margins)
- Sizes (width, height, constraints)

### Colors & Theme
- Background colors
- Surface colors
- Text colors
- Icon colors
- Accent/primary colors
- Color states (normal, pressed, disabled)

### Typography
- Font families
- Font sizes
- Font weights
- Text styles
- Letter spacing
- Line height

### Interactions
- Button actions
- Gestures (tap, swipe, long-press)
- Navigation transitions
- Dialog appearances
- Bottom sheet behavior

### Animations
- Loading states
- Transitions
- Progress indicators
- Confetti/celebrations
- Pulsing effects

### State Management
- Loading states
- Error states
- Empty states
- Success states
- Intermediate states

### Data Display
- How data is formatted
- Units (kg vs lb)
- Number formats
- Date/time formats
- Graph styles

---

## Implementation Checklist (per screen)

- [ ] Exact layout structure matches Kotlin
- [ ] All UI elements present
- [ ] Colors match exactly (use color picker on APK screenshots)
- [ ] Fonts/sizes match exactly
- [ ] Spacing matches exactly (use 8dp grid)
- [ ] Icons match exactly
- [ ] Interactions work identically
- [ ] Animations match timing and style
- [ ] All states handled
- [ ] Edge cases covered
- [ ] Accessibility maintained
- [ ] Performance equivalent

---

## Workflow Per Screen

### Step 1: Gemini Analysis
```bash
.skills/gemini.agent.wrapper.sh -d "
@C:/Users/dasbl/AndroidStudioProjects/VitruvianRedux/app/src/main/java/com/example/vitruvianredux/presentation/screen/

Analyze [ScreenName].kt in extreme detail. Document:
1. Complete layout hierarchy
2. Every UI element with exact properties
3. All colors (hex codes if possible)
4. All fonts, sizes, weights
5. All spacing values
6. All interactions and state changes
7. All animations and transitions
8. Data formatting and display logic

Format as structured markdown for Flutter implementation.
"
```

### Step 2: Compare with Flutter
Read existing Flutter screen and identify gaps.

### Step 3: Create Implementation Brief
Document exactly what needs to change in Flutter screen.

### Step 4: Cursor Implementation
```bash
.skills/cursor.agent.wrapper.sh "
EXACT UI MATCHING TASK:

Screen: [ScreenName]

**Kotlin Analysis:**
[Paste Gemini analysis]

**Flutter Current State:**
[Current Flutter code]

**Required Changes:**
1. [Specific change 1]
2. [Specific change 2]
...

**Acceptance Criteria:**
- Layout must match Kotlin exactly
- Colors must match exactly
- Fonts must match exactly
- Spacing must match exactly
- All interactions must work identically
- All states must be handled

Implement changes and verify with flutter analyze.
"
```

### Step 5: Visual Verification
Compare screenshots side-by-side.

---

## Priority Order

### High Priority (Core User Flow)
1. Splash Screen
2. Home/Dashboard
3. Workout Tab
4. Active Workout Screen
5. Just Lift Screen
6. BLE Connection Screen

### Medium Priority (Management)
7. Routines Tab
8. Routine Builder Dialog
9. Programs Tab
10. Settings Tab

### Lower Priority (Secondary)
11. Analytics Screen
12. Workout History
13. PR Screen
14. Exercise Picker

---

## Success Criteria

**Visual Fidelity:** 95%+ match to Kotlin screenshots
**Functional Fidelity:** 100% feature parity
**Interaction Fidelity:** Identical user experience
**Performance:** Equal or better than Kotlin app

---

## Next Steps

1. Start with Splash Screen (simplest)
2. Use Gemini to analyze Kotlin SplashScreen.kt
3. Compare with Flutter splash_screen.dart
4. Implement exact match with Cursor
5. Verify and move to next screen

**Estimated Time:** 2-3 hours per screen × 16 screens = 32-48 hours total
**Token Efficiency:** Use Quadrumvirate to minimize Claude token usage

---

**Status:** Ready to begin
**First Target:** Splash Screen
