/// Eccentric load percentage for Echo mode
/// 
/// Machine hardware limit: 150% maximum
/// NOTE: This is a minimal implementation for Phase 1. Full implementation in Phase 2.
enum EccentricLoad {
  load0(0, '0%'),
  load50(50, '50%'),
  load75(75, '75%'),
  load100(100, '100%'),
  load125(125, '125%'),
  load150(150, '150%');

  const EccentricLoad(this.percentage, this.displayName);
  
  final int percentage;
  final String displayName;
}
