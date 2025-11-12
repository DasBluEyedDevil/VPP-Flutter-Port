# Database Layer - Drift Implementation

Complete Room → Drift port of the database layer for VPP_Flutter_Port.

## Structure

```
lib/data/database/
├── app_database.dart          # Main database definition (version 15)
├── converters.dart             # Type converters (if needed)
├── tables/                     # 10 table definitions
│   ├── workout_sessions.dart
│   ├── workout_metrics.dart    # HIGH PERFORMANCE - 100Hz inserts
│   ├── routines.dart
│   ├── routine_exercises.dart
│   ├── exercises.dart
│   ├── exercise_videos.dart
│   ├── personal_records.dart
│   ├── weekly_programs.dart
│   ├── program_days.dart
│   └── connection_logs.dart
└── daos/                       # 4 DAO implementations
    ├── workout_dao.dart
    ├── exercise_dao.dart
    ├── pr_dao.dart
    └── connection_log_dao.dart
```

## Database Schema

**Version:** 15 (matches Kotlin Room database)

**Tables:** 10 tables
- WorkoutSessions - Workout session metadata
- WorkoutMetrics - High-frequency sensor data (100Hz)
- Routines - Workout routines
- RoutineExercises - Exercises within routines
- Exercises - Exercise library
- ExerciseVideos - Video URLs for exercises
- PersonalRecords - PR tracking
- WeeklyPrograms - Weekly workout programs
- ProgramDays - Days in weekly programs
- ConnectionLogs - BLE debug logs

## Foreign Keys & Constraints

### Foreign Keys (CASCADE delete)
- `RoutineExercises.routineId` → `Routines.id` (CASCADE)
- `ProgramDays.programId` → `WeeklyPrograms.id` (CASCADE)
- `ProgramDays.routineId` → `Routines.id` (CASCADE)
- `ExerciseVideos.exerciseId` → `Exercises.id` (CASCADE)

### Unique Constraints
- `PersonalRecords`: (exerciseId, workoutMode)

### Indexes
- `WorkoutMetrics`: sessionId, timestamp
- `RoutineExercises`: routineId
- `ProgramDays`: programId, routineId
- `ConnectionLogs`: timestamp

## Performance Optimization

### WorkoutMetrics Batch Inserts
The `WorkoutMetrics` table receives 100Hz inserts (6000 records/minute). The DAO uses `batch()` API for efficient bulk inserts:

```dart
Future<void> insertMetricsBatch(List<WorkoutMetricsCompanion> metrics) {
  return batch((batch) {
    batch.insertAll(workoutMetrics, metrics);
  });
}
```

## Usage

### Initialize Database
```dart
final database = AppDatabase();
```

### Access DAOs
```dart
final workoutDao = database.workoutDao;
final exerciseDao = database.exerciseDao;
final prDao = database.prDao;
final connectionLogDao = database.connectionLogDao;
```

### Example: Insert Workout Session
```dart
final session = WorkoutSessionsCompanion.insert(
  id: const Uuid().v4(),
  timestamp: DateTime.now().millisecondsSinceEpoch,
  mode: 'OldSchool',
  reps: 10,
  weightPerCableKg: 10.0,
  // ... other fields
);

final sessionId = await workoutDao.insertSession(session);
```

### Example: Batch Insert Metrics (100Hz)
```dart
final metrics = workoutMetrics.map((metric) => 
  WorkoutMetricsCompanion.insert(
    sessionId: sessionId,
    timestamp: metric.timestamp,
    loadA: metric.loadA,
    loadB: metric.loadB,
    // ... other fields
  )
).toList();

await workoutDao.insertMetricsBatch(metrics);
```

### Example: Reactive Streams
```dart
// Watch recent workout sessions
workoutDao.watchRecentSessions(limit: 20).listen((sessions) {
  // Update UI when sessions change
});
```

## Code Generation

**IMPORTANT:** Run build_runner to generate `.g.dart` files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `app_database.g.dart` - Database implementation
- `workout_dao.g.dart` - WorkoutDao mixin
- `exercise_dao.g.dart` - ExerciseDao mixin
- `pr_dao.g.dart` - PrDao mixin
- `connection_log_dao.g.dart` - ConnectionLogDao mixin

## Migration Notes

### Room → Drift Differences
1. **Companion Objects**: Use `TableNameCompanion` for inserts/updates
2. **Reactive Streams**: `watch()` replaces Room's `Flow`
3. **Batch Operations**: Use `batch()` API for bulk inserts
4. **Foreign Keys**: Defined in table class, not separate annotation
5. **Type Converters**: Implement `TypeConverter<T, S>` interface

### Schema Fidelity
- ✅ All 10 tables ported
- ✅ All foreign keys preserved (CASCADE deletes)
- ✅ All indexes preserved
- ✅ All unique constraints preserved
- ✅ Database version matches (15)
- ✅ Column types match Kotlin schema

## Testing

After running build_runner, verify:
1. `flutter analyze` passes
2. Database can be instantiated
3. DAO methods work correctly
4. Batch inserts perform well (100Hz requirement)

## Next Steps

1. Run `flutter pub run build_runner build`
2. Create repository implementations that use these DAOs
3. Add unit tests for DAO methods
4. Test batch insert performance with 100Hz data
