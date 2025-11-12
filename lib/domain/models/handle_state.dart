/// Handle state detection for Just Lift mode
/// 
/// Determines whether user has grabbed the handles and is moving them.
/// Uses hysteresis algorithm to prevent rapid state changes.
enum HandleState {
  /// Handles are released (not grabbed)
  released,
  
  /// Handles are grabbed but not moving
  grabbed,
  
  /// Handles are grabbed and moving
  moving,
}

extension HandleStateExtension on HandleState {
  String get displayName {
    switch (this) {
      case HandleState.released:
        return 'Released';
      case HandleState.grabbed:
        return 'Grabbed';
      case HandleState.moving:
        return 'Moving';
    }
  }
}
