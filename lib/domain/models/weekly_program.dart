import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_program.freezed.dart';

/// Weekly program domain model
/// 
/// Represents a weekly workout program that assigns routines to specific days.
/// Maps to WeeklyPrograms database table.
@freezed
class WeeklyProgram with _$WeeklyProgram {
  const factory WeeklyProgram({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime lastUsed,
    required bool isActive,
  }) = _WeeklyProgram;
}
