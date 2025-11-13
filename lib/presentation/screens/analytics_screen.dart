import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pr/personal_bests_tab.dart';
import '../widgets/pr/trends_tab.dart';
import '../screens/history_tab.dart';

/// Analytics screen with three tabs: History, Personal Bests, and Trends.
/// 
/// Provides comprehensive view of workout data and progress.
/// Ported from Kotlin AnalyticsScreen.kt
class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    
    // Sync tab controller with page controller
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (_tabController.index != index) {
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Background gradient matching Kotlin implementation
    final backgroundGradient = theme.brightness == Brightness.dark
        ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0F172A), // slate-900
              const Color(0xFF1E1B4B), // indigo-950
              const Color(0xFF172554), // blue-950
            ],
          )
        : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFE0E7FF), // indigo-200 - soft lavender
              const Color(0xFFFCE7F3), // pink-100 - soft pink
              const Color(0xFFDDD6FE), // violet-200 - soft violet
            ],
          );

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Analytics'),
          bottom: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(3),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF9333EA), // purple-600
                  const Color(0xFF7E22CE), // purple-700
                ],
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            tabs: const [
              Tab(
                icon: Icon(Icons.list),
                text: 'History',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Personal Bests',
              ),
              Tab(
                icon: Icon(Icons.info_outline),
                text: 'Trends',
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [
            // Tab 1: History
            HistoryTab(),
            // Tab 2: Personal Bests
            PersonalBestsTab(),
            // Tab 3: Trends
            TrendsTab(),
          ],
        ),
      ),
    );
  }
}
