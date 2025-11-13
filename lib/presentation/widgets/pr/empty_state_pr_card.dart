import 'package:flutter/material.dart';
import '../common/empty_state.dart';

/// Empty state card for Personal Records tab.
/// 
/// Shows when user has no personal records yet.
class EmptyStatePRCard extends StatelessWidget {
  const EmptyStatePRCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.info_outline,
      title: 'No personal records yet',
      message: 'Complete workouts to see your PRs',
    );
  }
}
