/// Echo mode difficulty levels
/// 
/// NOTE: This is a minimal implementation for Phase 1. Full implementation in Phase 2.
enum EchoLevel {
  hard(0, 'Hard'),
  harder(1, 'Harder'),
  hardest(2, 'Hardest'),
  epic(3, 'Epic');

  const EchoLevel(this.levelValue, this.displayName);
  
  final int levelValue;
  final String displayName;
}
