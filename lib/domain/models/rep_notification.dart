/// Rep notification event from Vitruvian device
/// 
/// Sent via RepNotify characteristic when rep counters change.
/// Contains top counter (reps at top position) and complete counter (full reps).
class RepNotification {
  /// Top counter - number of reps that reached the top position
  final int topCounter;
  
  /// Complete counter - number of complete reps (full range of motion)
  final int completeCounter;
  
  /// Raw data bytes received from device
  final List<int> rawData;
  
  /// Timestamp when notification was received (milliseconds since epoch)
  final int timestamp;

  RepNotification({
    required this.topCounter,
    required this.completeCounter,
    required this.rawData,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'RepNotification(topCounter=$topCounter, completeCounter=$completeCounter, '
        'timestamp=$timestamp)';
  }
}
