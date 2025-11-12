import 'package:freezed_annotation/freezed_annotation.dart';

part 'rep_ranges.freezed.dart';

/// Rep range boundaries for ROM visualization
/// 
/// Used to display rep range bars in the UI
@freezed
class RepRanges with _$RepRanges {
  const factory RepRanges({
    required double minPosition,
    required double maxPosition,
  }) = _RepRanges;
}
