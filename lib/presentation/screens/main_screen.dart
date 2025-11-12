import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/ble_connection_provider.dart';
import '../widgets/banners/connection_status_banner.dart';
import '../theme/spacing.dart';
import '../../domain/models/connection_state.dart';

/// Main screen container with bottom navigation bar for tabs.
/// Uses GoRouter ShellRoute to display child routes.
class MainScreen extends ConsumerWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStateAsync = ref.watch(connectionStateProvider);
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VPP'),
        actions: [
          // Connection status icon
          connectionStateAsync.when(
            data: (state) {
              final isConnected = state is Connected;
              return Icon(
                isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                color: isConnected ? Colors.green : Colors.grey,
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const Icon(Icons.bluetooth_disabled, color: Colors.grey),
          ),
          const SizedBox(width: AppSpacing.medium),
        ],
      ),
      body: Column(
        children: [
          // Show connection banner when not connected
          connectionStateAsync.when(
            data: (state) {
              if (state is Connected) {
                return const SizedBox.shrink();
              }
              return const ConnectionStatusBanner();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const ConnectionStatusBanner(),
          ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Routines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _shouldShowFAB(context)
          ? FloatingActionButton.extended(
              onPressed: () => context.go(Routes.activeWorkout),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
            )
          : null,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains('/workout') || location == Routes.home) return 0;
    if (location.contains('/routines')) return 1;
    if (location.contains('/history')) return 2;
    if (location.contains('/settings')) return 3;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.homeWorkout);
        break;
      case 1:
        context.go(Routes.homeRoutines);
        break;
      case 2:
        context.go(Routes.homeHistory);
        break;
      case 3:
        context.go(Routes.homeSettings);
        break;
    }
  }

  bool _shouldShowFAB(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location.contains('/workout') || location == Routes.home;
  }
}
