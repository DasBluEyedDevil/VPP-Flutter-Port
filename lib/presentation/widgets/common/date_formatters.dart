import 'package:intl/intl.dart';

/// Date formatting utilities for workout history.
///
/// Ported from Kotlin formatRelativeTimestamp (lines 867-881) and formatDuration.

/// Format a timestamp as a relative date string.
///
/// Formatting rules:
/// - <1 min: 'Just now'
/// - <1 hour: 'Xm ago'
/// - <1 day: 'Today at 3:45 PM'
/// - 1 day: 'Yesterday at 3:45 PM'
/// - <7 days: 'Monday' (day name)
/// - ≥7 days: 'Nov 12, 2025' (full date)
String formatRelativeTimestamp(int timestampMillis) {
  final now = DateTime.now();
  final date = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
  final difference = now.difference(date);

  final timeFormat = DateFormat('h:mm a');
  final dateFormat = DateFormat('MMM d, yyyy');
  final dayFormat = DateFormat('EEEE'); // Day name

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inDays == 0) {
    return 'Today at ${timeFormat.format(date)}';
  } else if (difference.inDays == 1) {
    return 'Yesterday at ${timeFormat.format(date)}';
  } else if (difference.inDays < 7) {
    return dayFormat.format(date); // "Monday"
  } else {
    return dateFormat.format(date); // "Nov 12, 2025"
  }
}

/// Format duration in milliseconds as 'M:SS' format.
///
/// Example: 2732000 milliseconds → '45:32'
String formatDuration(int milliseconds) {
  final totalSeconds = milliseconds ~/ 1000;
  final minutes = totalSeconds ~/ 60;
  final secs = totalSeconds % 60;
  return '$minutes:${secs.toString().padLeft(2, '0')}';
}
