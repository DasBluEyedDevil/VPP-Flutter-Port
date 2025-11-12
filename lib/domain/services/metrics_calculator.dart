import '../models/workout_metric.dart';
import 'dart:math' as math;

/// Metrics calculator for workout summaries
/// 
/// TODO: Port from Kotlin MetricsCalculator.kt
/// This is a stub implementation with basic calculations.
class MetricsCalculator {
  /// Calculate peak power from metrics
  double calculatePeakPower(List<WorkoutMetric> metrics) {
    if (metrics.isEmpty) return 0.0;
    
    return metrics
        .map((m) => m.power)
        .reduce((a, b) => math.max(a, b));
  }

  /// Calculate average power from metrics
  double calculateAveragePower(List<WorkoutMetric> metrics) {
    if (metrics.isEmpty) return 0.0;
    
    final sum = metrics.fold<double>(0.0, (sum, m) => sum + m.power);
    return sum / metrics.length;
  }
}
