import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_metric.freezed.dart';

/// Real-time workout metric data from Vitruvian device
///
/// Polled at 100Hz (every 100ms) from the Monitor characteristic.
/// Contains position, velocity, force, and power data for both cables (A and B).
@freezed
class WorkoutMetric with _$WorkoutMetric {
  const WorkoutMetric._();

  const factory WorkoutMetric({
    @Default(0) int timestamp,
    required double loadA,
    required double loadB,
    required int positionA,
    required int positionB,
    @Default(0) int ticks,
    @Default(0.0) double velocityA, // Velocity for handle detection (official app protocol)
    @Default(0.0) double velocityB,
    @Default(0.0) double power,
  }) = _WorkoutMetric;

  /// Total force (loadA + loadB) in Newtons
  double get totalLoad => loadA + loadB;

  /// Average position ((positionA + positionB) / 2)
  double get averagePosition => (positionA + positionB) / 2.0;

  /// Average velocity ((velocityA + velocityB) / 2)
  double get averageVelocity => (velocityA + velocityB) / 2.0;

  /// Create WorkoutMetric with current timestamp
  factory WorkoutMetric.create({
    int? timestamp,
    required double loadA,
    required double loadB,
    required int positionA,
    required int positionB,
    int ticks = 0,
    double velocityA = 0.0,
    double velocityB = 0.0,
    double power = 0.0,
  }) {
    return WorkoutMetric(
      timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      loadA: loadA,
      loadB: loadB,
      positionA: positionA,
      positionB: positionB,
      ticks: ticks,
      velocityA: velocityA,
      velocityB: velocityB,
      power: power,
    );
  }
}
