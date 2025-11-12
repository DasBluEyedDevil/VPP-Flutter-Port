import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_record.freezed.dart';

/// Personal record for an exercise
@freezed
class PersonalRecord with _$PersonalRecord {
  const factory PersonalRecord({
    @Default(0) int id,
    required String exerciseId,
    required double weightPerCableKg,
    required int reps,
    required int timestamp,
    required String workoutMode,
  }) = _PersonalRecord;
}
