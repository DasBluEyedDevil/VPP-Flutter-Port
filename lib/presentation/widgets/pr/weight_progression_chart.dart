import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/personal_record.dart';

/// Weight Progression Chart widget.
/// 
/// Shows weight over time using fl_chart LineChart with cubic bezier interpolation.
class WeightProgressionChart extends StatelessWidget {
  final List<PersonalRecord> prs;
  final String weightUnit; // "kg" or "lbs"

  const WeightProgressionChart({
    super.key,
    required this.prs,
    this.weightUnit = 'kg',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (prs.length < 2) {
      return const SizedBox.shrink(); // Need at least 2 points for a line
    }

    // Sort PRs by timestamp
    final sortedPRs = List<PersonalRecord>.from(prs)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Create spots for line chart
    final spots = sortedPRs.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.weightPerCableKg,
      );
    }).toList();

    final maxWeight = sortedPRs
        .map((pr) => pr.weightPerCableKg)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weight Progression',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: const Color(0xFF9333EA), // Purple
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF9333EA).withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toStringAsFixed(1)} $weightUnit',
                            style: theme.textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < sortedPRs.length) {
                            final pr = sortedPRs[index];
                            final date = DateTime.fromMillisecondsSinceEpoch(
                              pr.timestamp,
                            );
                            return Text(
                              DateFormat('MMM d').format(date),
                              style: theme.textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 0,
                  maxY: maxWeight * 1.1, // Add 10% padding
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
