import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_history_provider.dart';
import '../widgets/charts/analytics_charts.dart';
import '../widgets/common/empty_state.dart';
import '../theme/spacing.dart';
import '../../domain/models/workout_session.dart';

/// Analytics screen with tabs for Volume, Frequency, and Distribution charts.
class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _dateRange = 30; // days (0 = all time)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(workoutHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Volume'),
            Tab(text: 'Frequency'),
            Tab(text: 'Distribution'),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _dateRange,
            onSelected: (days) => setState(() => _dateRange = days),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 7, child: Text('Last 7 days')),
              PopupMenuItem(value: 30, child: Text('Last 30 days')),
              PopupMenuItem(value: 90, child: Text('Last 90 days')),
              PopupMenuItem(value: 0, child: Text('All time')),
            ],
          ),
        ],
      ),
      body: workoutsAsync.when(
        data: (workouts) {
          final filtered = _filterByDateRange(workouts, _dateRange);
          
          if (filtered.isEmpty) {
            return const EmptyState(
              icon: Icons.bar_chart,
              title: 'No Data',
              message: 'No workout data available for the selected date range',
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _VolumeTab(workouts: filtered),
              _FrequencyTab(workouts: filtered),
              _DistributionTab(workouts: filtered),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: AppSpacing.medium),
              Text('Error loading analytics: $error'),
            ],
          ),
        ),
      ),
    );
  }

  List<WorkoutSession> _filterByDateRange(List<WorkoutSession> workouts, int days) {
    if (days == 0) return workouts;
    
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final cutoffTimestamp = cutoffDate.millisecondsSinceEpoch;
    
    return workouts.where((w) => w.timestamp >= cutoffTimestamp).toList();
  }
}

class _VolumeTab extends StatelessWidget {
  final List<WorkoutSession> workouts;

  const _VolumeTab({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: AnalyticsCharts(workoutHistory: workouts),
    );
  }
}

class _FrequencyTab extends StatelessWidget {
  final List<WorkoutSession> workouts;

  const _FrequencyTab({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: AnalyticsCharts(workoutHistory: workouts),
    );
  }
}

class _DistributionTab extends StatelessWidget {
  final List<WorkoutSession> workouts;

  const _DistributionTab({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: AnalyticsCharts(workoutHistory: workouts),
    );
  }
}

