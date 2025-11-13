import 'package:drift/drift.dart';

/// Type converters for Drift database
///
/// Currently, all complex types are stored as strings (text columns).
/// Converters can be added here if needed for:
/// - `List<String>` to comma-separated strings
/// - Enum types to strings (currently handled directly)
/// - JSON serialization for complex types

/// Example: String list converter (if needed)
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}
