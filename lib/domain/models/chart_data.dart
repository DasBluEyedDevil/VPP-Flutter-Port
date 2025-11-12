import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data.freezed.dart';

/// Chart data point for visualization
@freezed
class ChartDataPoint with _$ChartDataPoint {
  const factory ChartDataPoint({
    required int timestamp,
    required double totalLoad,
    required double loadA,
    required double loadB,
    required int positionA,
    required int positionB,
  }) = _ChartDataPoint;
}

/// Chart event markers
@freezed
class ChartEvent with _$ChartEvent {
  const ChartEvent._();

  const factory ChartEvent.repStart({
    required int timestamp,
    required int repNumber,
  }) = RepStart;
  const factory ChartEvent.repComplete({
    required int timestamp,
    required int repNumber,
  }) = RepComplete;
  const factory ChartEvent.warmupComplete({
    required int timestamp,
  }) = WarmupComplete;

  /// Label for display
  String get label => switch (this) {
        RepStart(:final repNumber) => 'Rep $repNumber',
        RepComplete(:final repNumber) => 'Rep $repNumber Complete',
        WarmupComplete() => 'Warmup Complete',
        _ => throw UnimplementedError(),
      };
}
