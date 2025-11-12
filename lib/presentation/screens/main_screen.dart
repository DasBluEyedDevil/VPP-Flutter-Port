import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../navigation/routes.dart';
import '../providers/ble_connection_provider.dart';
import '../widgets/banners/connection_status_banner.dart';
import '../theme/spacing.dart';
import '../../domain/models/connection_state.dart' as ble;

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VPP'),
        actions: [
          // Connection status icon with 5-state system
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  connectionStateAsync.whenData((state) {
                    if (state is ble.Connected) {
                      ref.read(bleConnectionActionsProvider).disconnect();
                    } else {
                      ref.read(bleConnectionActionsProvider).ensureConnection(
                        onConnected: () {},
                        onFailed: () {},
                      );
                    }
                  });
                },
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      connectionStateAsync.when(
                        data: (state) => Icon(
                          _getConnectionIcon(state),
                          size: 20,
                          color: _getConnectionColor(state),
                        ),
                        loading: () => const Icon(
                          Icons.bluetooth_disabled,
                          size: 20,
                          color: Color(0xFFEF4444),
                        ),
                        error: (_, __) => const Icon(
                          Icons.bluetooth_disabled,
                          size: 20,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                      connectionStateAsync.when(
                        data: (state) => Text(
                          _getConnectionText(state),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                            color: _getConnectionColor(state),
                          ),
                          maxLines: 1,
                        ),
                        loading: () => Text(
                          'Disconnected',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                            color: const Color(0xFFEF4444),
                          ),
                          maxLines: 1,
                        ),
                        error: (_, __) => Text(
                          'Error',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                            color: const Color(0xFFEF4444),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.medium),
        ],
      ),
      body: Column(
        children: [
          // Show connection banner when not connected
          connectionStateAsync.when(
            data: (state) {
              if (state is ble.Connected) {
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

  /// Get connection icon based on state
  IconData _getConnectionIcon(ble.ConnectionState state) {
    return state.when(
      disconnected: () => Icons.bluetooth_disabled,
      scanning: () => Icons.bluetooth_searching,
      connecting: () => Icons.bluetooth_searching,
      connected: (deviceName, deviceAddress, hardwareModel) => Icons.bluetooth,
      error: (message, throwable) => Icons.bluetooth_disabled,
    );
  }

  /// Get connection color based on state
  Color _getConnectionColor(ble.ConnectionState state) {
    return state.when(
      disconnected: () => const Color(0xFFEF4444),     // red-500
      scanning: () => const Color(0xFF3B82F6),         // blue-500
      connecting: () => const Color(0xFFFBBF24),       // yellow-400
      connected: (deviceName, deviceAddress, hardwareModel) => const Color(0xFF22C55E), // green-500
      error: (message, throwable) => const Color(0xFFEF4444), // red-500
    );
  }

  /// Get connection text based on state
  String _getConnectionText(ble.ConnectionState state) {
    return state.when(
      disconnected: () => 'Disconnected',
      scanning: () => 'Scanning',
      connecting: () => 'Connecting',
      connected: (deviceName, deviceAddress, hardwareModel) => 'Connected',
      error: (message, throwable) => 'Error',
    );
  }
}
