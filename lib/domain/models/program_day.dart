import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_day.freezed.dart';

/// Program day domain model
/// 
/// Links a routine to a specific day of the week within a weekly program.
/// Maps to ProgramDays database table.
/// 
/// dayOfWeek: 1=Monday, 2=Tuesday, ..., 7=Sunday (ISO-8601, matches DateTime.weekday)
@freezed
class ProgramDay with _$ProgramDay {
  const factory ProgramDay({
    required int id,
    required String programId,
    required String routineId,
    required int dayOfWeek, // 1-7: Monday-Sunday
  }) = _ProgramDay;
}
