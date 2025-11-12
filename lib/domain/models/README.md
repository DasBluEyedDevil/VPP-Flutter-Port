# Domain Models

This directory contains all domain layer models from Models.kt

## Files to Port

- [ ] `connection_state.dart` - ConnectionState sealed class
- [ ] `workout_state.dart` - WorkoutState sealed class
- [ ] `workout_type.dart` - WorkoutType (Program, Echo)
- [ ] `program_mode.dart` - Old School, Pump, TUT, TUT Beast, Eccentric Only
- [ ] `echo_level.dart` - Echo difficulty levels
- [ ] `eccentric_load.dart` - Eccentric load percentages
- [ ] `weight_unit.dart` - kg/lb
- [ ] `workout_metric.dart` - Real-time sensor data
- [ ] `rep_count.dart` - Rep tracking model
- [ ] `workout_session.dart` - Session summary
- [ ] `exercise.dart` - Exercise data class
- [ ] `routine.dart` - Routine and RoutineExercise
- [ ] `user_preferences.dart` - User settings

All models should use freezed for immutability.
