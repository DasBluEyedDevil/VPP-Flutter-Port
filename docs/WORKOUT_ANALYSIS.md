# KOTLIN WORKOUT SESSION MANAGEMENT - FLUTTER PORT ANALYSIS

Source: MainViewModel.kt (1,742 lines)
Target: Flutter Riverpod Implementation

## 1. ALL STATEFLOW PROPERTIES (WORKOUT-RELATED)

_workoutState (57) / workoutState (58)
  Type: MutableStateFlow<WorkoutState> / StateFlow<WorkoutState>
  9 states: Idle, Countdown, Active, SetSummary, Resting, Paused, Completed, Error, Initializing

_currentMetric (60) / currentMetric (61)
  Type: MutableStateFlow<WorkoutMetric?> / StateFlow<WorkoutMetric?>
  Real-time position/load data from device

_workoutParameters (63-73) / workoutParameters (74)
  Type: MutableStateFlow<WorkoutParameters>
  Fields: workoutType, reps, weightPerCableKg, progressionRegressionKg, isJustLift, useAutoStart, stopAtTop, warmupReps, selectedExerciseId

_repCount (76) / repCount (77)
  Type: MutableStateFlow<RepCount>
  Fields: warmupReps, workingReps, totalReps, isWarmupComplete

_repRanges (79) / repRanges (80)
  Type: MutableStateFlow<RepRanges?>
  ROM boundaries for visualization bars

_autoStopState (82) / autoStopState (83)
  Type: MutableStateFlow<AutoStopUiState>
  Fields: isActive (Bool), progress (Float 0-1), secondsRemaining (Int)
  Just Lift auto-stop timer state

_autoStartCountdown (85) / autoStartCountdown (86)
  Type: MutableStateFlow<Int?>
  Auto-start grab-to-start timer (3 seconds)

_loadedRoutine (118), _currentExerciseIndex (121), _currentSetIndex (124)
  Routine management indices

_connectionLostDuringWorkout (253)
  Type: MutableStateFlow<Boolean>
  BLE disconnection detection during workout (Issue #43)

## 2. SHARED FLOW PROPERTIES (EVENT EMISSION)

_prCelebrationEvent (95) / prCelebrationEvent (96)
  Type: MutableSharedFlow<PRCelebrationEvent>
  Emitted when user achieves new personal record

_hapticEvents (246-249) / hapticEvents (250)
  Type: MutableSharedFlow<HapticEvent>
  Buffer: 10 items, DROP_OLDEST policy
  Events: REP_COMPLETED, WARMUP_COMPLETE, WORKOUT_COMPLETE, WORKOUT_START, WORKOUT_END, ERROR


## 3. WORKOUT STATE MACHINE - 9 STATES

WorkoutState.Idle
  Initial state, awaiting start

WorkoutState.Countdown(secondsRemaining: Int)
  5-second countdown (5→4→3→2→1)
  Skipped in Just Lift or if skipCountdown=true

WorkoutState.Active
  Workout in progress, rep counting enabled
  Monitors rep notifications and position data
  Collects metrics for post-set summary

WorkoutState.SetSummary(metrics, peakPower, averagePower, repCount)
  Shows metrics after set completion
  User continues or completes workout

WorkoutState.Resting(restSecondsRemaining, nextExerciseName, isLastExercise, currentSet, totalSets)
  Rest between sets (duration from exercise or 90s default)
  Autoplay preference controls auto-advance vs manual skipRest()

WorkoutState.Paused
  Rarely used pause state

WorkoutState.Completed
  Final state (Just Lift: auto-resets to Idle)

WorkoutState.Error(message)
  Unrecoverable error

WorkoutState.Initializing
  Transient preparation state

## 4. STATE TRANSITIONS

NORMAL WORKOUT FLOW:
  Idle → Countdown(5→1) → Active → SetSummary → Resting(90→1) → Active → ... → Completed

JUST LIFT UNIQUE FLOW:
  Idle → (handles grabbed) → Auto-Start(3→1) → Active → SetSummary → Idle (AUTO-RESET!)

KEY TRANSITIONS:
  startWorkout() → Countdown (optional) → Active
  Active (auto-stop triggered 3s) → SetSummary
  proceedFromSummary() → Resting OR Completed OR Idle (Just Lift only)
  startRestTimer() → Resting(counting) → Active OR Resting(0)
  skipRest() → Active (immediate)
  stopWorkout() → Completed

## 5. TIMER LOGIC - THREE TYPES

AUTO-START HOLD TIMER (Grab-to-Start):
  Duration: 3 seconds
  Function: startAutoStartTimer() (428-448)
  Trigger: Handle grab + useAutoStart=true + Idle state
  Visible: Countdown 3→2→1
  Cancellation: cancelAutoStartTimer() on handle release
  Calls: startWorkout(isJustLiftMode=true)

PRE-WORKOUT COUNTDOWN:
  Duration: 5 seconds (5→4→3→2→1)
  Function: startWorkout() lines 773-776
  Skipped: In Just Lift or if skipCountdown=true
  State: Countdown(i) for each second, then Active

JUST LIFT AUTO-STOP TIMER:
  Duration: 3 seconds (AUTO_STOP_DURATION_SECONDS = 3f)
  Function: checkAutoStop() (495-529)
  Trigger: Position in danger zone (detected by RepCounterFromMachine)
  Visible: Progress bar showing elapsed time
  Reset: User moves position away from danger zone
  Double-Trigger Prevention: autoStopTriggered + autoStopStopRequested flags
  State: AutoStopUiState { isActive, progress (0-1), secondsRemaining }

REST TIMER BETWEEN SETS:
  Duration: exercise.restSeconds or 90 default
  Function: startRestTimer() (1043-1155)
  Visible: Resting(countdown)→Resting(0)
  Auto-Advance: If userPreferences.autoplayEnabled
  Manual Skip: skipRest() cancels timer
  After Countdown:
    if autoplay: startNextSetOrExercise() or startWorkout(skipCountdown=true)
    else: stay in Resting(0) waiting for skipRest()


## 6. REP COUNTING INTEGRATION

INITIALIZATION (startWorkout, lines 750-756):
  workingTarget = if (isJustLift) 0 else params.reps
  repCounter.reset()
  repCounter.configure(
      warmupTarget = params.warmupReps          // Usually 3
      workingTarget = workingTarget             // 0 for Just Lift
      isJustLift = params.isJustLift
      stopAtTop = params.stopAtTop
  )

REP EVENT CALLBACK (init block, lines 277-310):
  repCounter.onRepEvent = { repEvent ->
    val newRepCount = repCounter.getRepCount()
    _repCount.value = newRepCount

    Haptic feedback:
      WARMUP_COMPLETED/WORKING_COMPLETED → REP_COMPLETED
      WARMUP_COMPLETE → WARMUP_COMPLETE
      WORKOUT_COMPLETE → WORKOUT_COMPLETE

    if (repCounter.shouldStopWorkout()) {
      requestAutoStop()  // Triggers SetSummary
    }
  }

REP NOTIFICATION PROCESSING (handleRepNotification, lines 467-478):
  repCounter.process(
      topCounter = notification.topCounter
      completeCounter = notification.completeCounter
      posA = currentMetric?.positionA
      posB = currentMetric?.positionB
  )
  _repRanges.value = repCounter.getRepRanges()  // For visualization

REP STATE DATA MODEL:
  RepCount {
    warmupReps: Int = 0              // Completed warmup reps
    workingReps: Int = 0             // Completed working reps
    totalReps: Int = workingReps     // Exclude warmup
    isWarmupComplete: Boolean
  }

## 7. HAPTIC EVENT EMISSION

Type: MutableSharedFlow<HapticEvent>, buffer=10, DROP_OLDEST

REP_COMPLETED (line 293):
  Emitted for each individual rep completion
  From: repCounter.onRepEvent callback

WARMUP_COMPLETE (line 297):
  Emitted when warmup target reached
  From: repCounter.onRepEvent callback

WORKOUT_COMPLETE (line 301):
  Emitted when working target reached (or Just Lift completion)
  From: repCounter.onRepEvent callback

WORKOUT_START (line 815):
  Emitted when state transitions to Active
  Indicates BLE command sent and device ready

WORKOUT_END (lines 848, 897):
  Emitted in stopWorkout() and handleSetCompletion()

ERROR (line 413):
  Emitted when connection lost during workout
  Triggers dismissible alert

## 8. PERSONAL RECORD EVENT

Type: MutableSharedFlow<PRCelebrationEvent>
Emitted from: saveWorkoutSession() (lines 1362-1376)

Trigger Conditions (all must be true):
  - workingReps > 0
  - NOT isJustLift
  - NOT Echo mode (machine calculates weight)
  - NEW PR achieved (via workoutRepository check)

Event Data:
  PRCelebrationEvent {
    exerciseName: String
    weightPerCableKg: Float
    reps: Int
    workoutMode: String  // 'Old School', 'Pump', etc.
  }


## 9. ALL WORKOUT METHODS

startWorkout(skipCountdown=false, isJustLiftMode=false) [733-817]
  Initiates workout with optional countdown
  State Flow: (Optional Countdown) → Active
  Side Effects:
    - Reset rep counter (750)
    - Generate session UUID (761)
    - Record start time (762)
    - Send BLE command (790)
    - Start foreground service (806)
    - Emit WORKOUT_START haptic (815)

stopWorkout() [819-865]
  User manually stops workout
  State Flow: Any active → Completed
  Side Effects: Cancel timer, stop BLE, save session, reset counter

handleSetCompletion() [888-928]
  Auto-complete set when auto-stop triggers
  Trigger: Position held 3+ seconds
  State Flow: Active → SetSummary

proceedFromSummary() [946-1018]
  Continue after viewing set summary
  Decision: More sets/exercises? → Resting OR → Completed/Idle

startRestTimer() [1043-1155]
  Display rest period between sets
  Duration: exercise.restSeconds (or 90s default)
  Auto-Advance: if userPreferences.autoplayEnabled

skipRest() [1240-1267]
  User manually skips rest
  Action: Cancel restTimerJob, call startNextSetOrExercise()

startNextSetOrExercise() [1157-1238]
  Progress routine to next set or exercise
  Updates indices and parameters, calls startWorkout()

loadRoutine(routine: Routine) [1525-1568]
  Load multi-exercise routine
  CRITICAL: Set isJustLift=false (line 1556)

resetForNewWorkout() [1452-1459]
  Reset state to Idle without disconnect
  Resets: state, repCount, repRanges, indices, autoStopState

handleMonitorMetric(metric) [450-462]
  Process real-time position/load data
  If Just Lift: checks auto-stop timer
  Else: resets auto-stop timer

handleRepNotification(notification) [467-478]
  Process rep event from machine
  Feeds data to repCounter, updates visualization

checkAutoStop(metric) [495-529]
  Just Lift auto-stop logic
  Counts 3 seconds in danger zone

startAutoStartTimer() [428-448]
  Grab-to-start 3-second countdown
  Calls startWorkout(isJustLiftMode=true)

## 10. INTERNAL STATE VARIABLES

currentSessionId: String? (257)
  UUID for current workout, generated in startWorkout (761)

workoutStartTime: Long (258)
  Start timestamp (ms), set in startWorkout (762)

collectedMetrics: MutableList<WorkoutMetric> (259)
  Position/load data collected during Active state
  Cleared in startWorkout (763)

autoStopStartTime: Long? (262)
  When danger zone entry detected
  Reset in resetAutoStopTimer (532)

autoStopTriggered: AtomicBoolean (263)
  Flag: auto-stop already triggered
  Prevents double-trigger

autoStopStopRequested: AtomicBoolean (264)
  Flag: prevent multiple trigger attempts

Job References (for cancellation):
  autoStartJob (266) - grab-to-start timer
  restTimerJob (267) - rest countdown
  connectionJob (268) - connection attempt
  monitorDataCollectionJob (271) - monitor flow
  repEventsCollectionJob (272) - rep events flow


## 11. KEY CONSTANTS

AUTO_STOP_DURATION_SECONDS = 3f (line 1721)
  Just Lift auto-stop threshold (matches official app)

Auto-Start Hold Timer = 3 seconds (implicit)
  Time user must hold handles before workout starts

Rest Timer Default = 90 seconds (line 1052)
  Default rest between sets

Warmup Reps Default = 3 (line 71)
  Default warmup repetitions

## 12. DOMAIN MODELS

WorkoutState (Sealed Class)
  Idle, Countdown, Active, SetSummary, Resting, Paused, Completed, Error, Initializing

WorkoutParameters
  workoutType, reps, weightPerCableKg, progressionRegressionKg, isJustLift, 
  useAutoStart, stopAtTop, warmupReps, selectedExerciseId

RepCount
  warmupReps, workingReps, totalReps, isWarmupComplete

WorkoutMetric
  timestamp, loadA, loadB, positionA, positionB, ticks, velocityA, totalLoad (computed)

AutoStopUiState
  isActive: Boolean, progress: Float (0-1), secondsRemaining: Int

HapticEvent
  REP_COMPLETED, WARMUP_COMPLETE, WORKOUT_COMPLETE, WORKOUT_START, WORKOUT_END, ERROR

PRCelebrationEvent
  exerciseName, weightPerCableKg, reps, workoutMode

## 13. CRITICAL IMPLEMENTATION NOTES FOR FLUTTER

1. Rep Counter
   - Must port RepCounterFromMachine with identical logic
   - Tracks position-based ROM detection
   - Signals Just Lift completion via shouldStopWorkout()

2. Job Cancellation
   - Use Riverpod's ref.onDispose for cleanup
   - Cancel all timer jobs in onCleared equivalent

3. State Guards
   - startNextSetOrExercise only from Resting state (line 1165)
   - Prevent race conditions

4. Atomic Flags
   - autoStopTriggered and autoStopStopRequested prevent double-triggers
   - Critical for Just Lift reliability

5. Timing
   - Just Lift auto-stop: exactly 3 seconds
   - Auto-start hold: exactly 3 seconds
   - Rest timers: configurable, default 90s

6. BLE Integration
   - Monitor data and rep events must flow continuously
   - Stop polling immediately on stopWorkout() (line 841)

7. Autoplay Logic
   - Rest timer auto-advance depends on userPreferences.autoplayEnabled
   - Must be reactive (StateFlow)

8. Connection Loss
   - Flag _connectionLostDuringWorkout (line 253)
   - Emit ERROR haptic when connection lost (line 413)
   - Show dismissible alert

9. Metrics Collection
   - All position/load during Active must be saved
   - Used for post-set summary calculations
   - Used for session persistence

10. Just Lift Unique
    - Auto-resets to Idle after completing set (not Completed)
    - Line 1006: Idle for Just Lift, Completed for normal
    - Different flow than routine mode

11. Routine vs Single Exercise
    - Single: No routine loaded OR temp routine ID starts 'temp_single_exercise_'
    - Normal: Multiple exercises with multiple sets

12. Session Persistence
    - UUID + timestamp + all metadata to database
    - Personal record tracking separately (lines 1348-1378)

## 14. INIT BLOCK & CLEANUP

Init Block (lines 274-420):
  - Rep event callback setup (278-310)
  - Monitor data collection (314-321)
  - Rep events collection (324-336)
  - Workout history loading (339-343)
  - Routines loading (346-350)
  - Scanned devices collection (353-372)
  - Handle state listener for auto-start (375-392)
  - Connection loss monitoring (395-419)

onCleared (lines 1709-1718):
  - Cancel monitorDataCollectionJob
  - Cancel repEventsCollectionJob
  - Cancel autoStartJob
  - Cancel restTimerJob

---
END OF ANALYSIS
