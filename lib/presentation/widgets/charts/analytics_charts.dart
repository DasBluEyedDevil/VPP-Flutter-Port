import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../theme/spacing.dart';
import '../../../domain/models/workout_session.dart';

/// Analytics charts widget displaying workout data visualizations.
/// 
/// Shows three chart types:
/// 1. LineChart: Volume over time (kg × reps)
/// 2. BarChart: Workout frequency per week
/// 3. PieChart: Exercise distribution
/// 
/// Uses fl_chart package with theme-aware colors and interactive tooltips.
class AnalyticsCharts extends StatelessWidget {
  /// List of workout sessions to analyze
  final List<WorkoutSession> workoutHistory;

  const AnalyticsCharts({
    super.key,
    required this.workoutHistory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (workoutHistory.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.extraLarge),
          child: Text(
            'No workout data available',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Volume over time (LineChart)
          _buildVolumeChart(context, theme),
          
          const SizedBox(height: AppSpacing.extraLarge),
          
          // Workout frequency per week (BarChart)
          _buildFrequencyChart(context, theme),
          
          const SizedBox(height: AppSpacing.extraLarge),
          
          // Exercise distribution (PieChart)
          _buildExerciseDistributionChart(context, theme),
        ],
      ),
    );
  }

  /// Builds LineChart showing volume (kg × reps) over time
  Widget _buildVolumeChart(BuildContext context, ThemeData theme) {
    // Sort workouts by timestamp
    final sortedWorkouts = List<WorkoutSession>.from(workoutHistory)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Calculate volume for each workout: weightPerCableKg * totalReps
    final spots = sortedWorkouts.map((workout) {
      final volume = workout.weightPerCableKg * workout.totalReps;
      return FlSpot(
        workout.timestamp.toDouble(),
        volume,
      );
    }).toList();

    if (spots.isEmpty) {
      return _buildEmptyChartPlaceholder(context, theme, 'Volume Over Time');
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Volume Over Time',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Total volume (kg × reps)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: _calculateInterval(spots.map((s) => s.y).toList()),
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: _calculateTimeInterval(sortedWorkouts),
                        getTitlesWidget: (value, meta) {
                          final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              DateFormat('MMM d').format(date),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: _calculateInterval(spots.map((s) => s.y).toList()),
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  minX: spots.first.x,
                  maxX: spots.last.x,
                  minY: 0,
                  maxY: spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.1,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: theme.colorScheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: theme.colorScheme.primary.withOpacity(0.2),
                      ),
                      preventCurveOverShooting: true,
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => theme.colorScheme.surfaceContainerHighest,
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final date = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
                          return LineTooltipItem(
                            '${DateFormat('MMM d, y').format(date)}\n'
                            'Volume: ${spot.y.toInt()} kg',
                            TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds BarChart showing workout frequency per week
  Widget _buildFrequencyChart(BuildContext context, ThemeData theme) {
    // Group workouts by week
    final weekCounts = <String, int>{};
    
    for (final workout in workoutHistory) {
      final date = DateTime.fromMillisecondsSinceEpoch(workout.timestamp);
      final weekKey = _getWeekKey(date);
      weekCounts[weekKey] = (weekCounts[weekKey] ?? 0) + 1;
    }

    if (weekCounts.isEmpty) {
      return _buildEmptyChartPlaceholder(context, theme, 'Workout Frequency');
    }

    // Sort by week (most recent first, limit to last 12 weeks)
    final sortedWeeks = weekCounts.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    final recentWeeks = sortedWeeks.take(12).toList().reversed.toList();

    final barGroups = recentWeeks.asMap().entries.map((entry) {
      final index = entry.key;
      final weekEntry = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: weekEntry.value.toDouble(),
            color: theme.colorScheme.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ],
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workout Frequency',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Workouts per week',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= recentWeeks.length) return const Text('');
                          final weekKey = recentWeeks[value.toInt()].key;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _formatWeekKey(weekKey),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() == 0) return const Text('');
                          return Text(
                            value.toInt().toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  minY: 0,
                  maxY: recentWeeks.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble() * 1.2,
                  barGroups: barGroups,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => theme.colorScheme.surfaceContainerHighest,
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final weekKey = recentWeeks[group.x].key;
                        return BarTooltipItem(
                          '${_formatWeekKey(weekKey)}\n'
                          '${rod.toY.toInt()} workout${rod.toY.toInt() != 1 ? 's' : ''}',
                          TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds PieChart showing exercise distribution
  Widget _buildExerciseDistributionChart(BuildContext context, ThemeData theme) {
    // Count workouts by exerciseId
    final exerciseCounts = <String, int>{};
    
    for (final workout in workoutHistory) {
      final exerciseId = workout.exerciseId ?? 'Unknown';
      exerciseCounts[exerciseId] = (exerciseCounts[exerciseId] ?? 0) + 1;
    }

    if (exerciseCounts.isEmpty) {
      return _buildEmptyChartPlaceholder(context, theme, 'Exercise Distribution');
    }

    // Sort by count (descending) and take top 8
    final sortedExercises = exerciseCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topExercises = sortedExercises.take(8).toList();

    // Define colors for pie chart
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.error,
      theme.colorScheme.primaryContainer,
      theme.colorScheme.secondaryContainer,
      theme.colorScheme.tertiaryContainer,
      theme.colorScheme.surfaceContainerHighest,
    ];

    final pieChartSections = topExercises.asMap().entries.map((entry) {
      final index = entry.key;
      final exerciseEntry = entry.value;
      final percentage = (exerciseEntry.value / workoutHistory.length) * 100;
      
      return PieChartSectionData(
        value: exerciseEntry.value.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        color: colors[index % colors.length],
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise Distribution',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Top exercises by workout count',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  // Pie chart
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sections: pieChartSections,
                        sectionsSpace: 3,
                        centerSpaceRadius: 40,
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            // Interactive tooltip handled by fl_chart
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  // Legend
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: topExercises.asMap().entries.map((entry) {
                        final index = entry.key;
                        final exerciseEntry = entry.value;
                        final percentage = (exerciseEntry.value / workoutHistory.length) * 100;
                        
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colors[index % colors.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  exerciseEntry.key.length > 15
                                      ? '${exerciseEntry.key.substring(0, 15)}...'
                                      : exerciseEntry.key,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build empty chart placeholder
  Widget _buildEmptyChartPlaceholder(
    BuildContext context,
    ThemeData theme,
    String title,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              'No data available',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to get week key (YYYY-WW format)
  String _getWeekKey(DateTime date) {
    final year = date.year;
    final week = _getWeekNumber(date);
    return '$year-W$week';
  }

  /// Helper to format week key for display
  String _formatWeekKey(String weekKey) {
    final parts = weekKey.split('-W');
    if (parts.length != 2) return weekKey;
    
    final year = int.tryParse(parts[0]);
    final week = int.tryParse(parts[1]);
    if (year == null || week == null) return weekKey;
    
    // Calculate date for the start of the week
    final jan1 = DateTime(year, 1, 1);
    final daysOffset = (week - 1) * 7;
    final weekStart = jan1.add(Duration(days: daysOffset));
    
    return DateFormat('MMM d').format(weekStart);
  }

  /// Helper to get week number (ISO 8601 week number)
  int _getWeekNumber(DateTime date) {
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays + 1;
    final weekNumber = ((dayOfYear - date.weekday + 10) / 7).floor();
    return weekNumber;
  }

  /// Helper to calculate appropriate interval for Y-axis
  double _calculateInterval(List<double> values) {
    if (values.isEmpty) return 10;
    final max = values.reduce((a, b) => a > b ? a : b);
    if (max <= 0) return 10;
    
    // Round up to nearest nice number
    final magnitude = (max / 10).ceil();
    return magnitude.toDouble();
  }

  /// Helper to calculate appropriate time interval for X-axis
  double _calculateTimeInterval(List<WorkoutSession> workouts) {
    if (workouts.length <= 1) return 1;
    
    final timeSpan = workouts.last.timestamp - workouts.first.timestamp;
    final days = timeSpan / (1000 * 60 * 60 * 24);
    
    if (days <= 7) return 1; // Daily
    if (days <= 30) return 7; // Weekly
    if (days <= 90) return 14; // Bi-weekly
    return 30; // Monthly
  }
}
