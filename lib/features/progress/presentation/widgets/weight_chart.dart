import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/color_palette.dart';

class WeightChart extends StatelessWidget {
  final List<Map<String, dynamic>> weightData;
  final double targetWeight;

  const WeightChart({
    super.key,
    required this.weightData,
    required this.targetWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (weightData.isEmpty) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timeline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No weight data yet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Start logging your weight to see progress',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Prepare data for chart
    final spots = <FlSpot>[];
    for (int i = 0; i < weightData.length; i++) {
      final weight = weightData[i]['weight'] as double;
      spots.add(FlSpot(i.toDouble(), weight));
    }

    // Calculate min/max for Y axis
    final weights = weightData.map((e) => e['weight'] as double).toList();
    final minWeight = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxWeight = weights.reduce((a, b) => a > b ? a : b) + 2;

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade200,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}kg',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorPalette.textSecondary,
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= weightData.length) return const Text('');
                  final date = DateTime.parse(weightData[value.toInt()]['date'] as String);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${date.day}/${date.month}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minY: minWeight,
          maxY: maxWeight,
          lineBarsData: [
            // Actual weight line
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: ColorPalette.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: ColorPalette.primary,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: ColorPalette.primary.withValues(alpha: 0.1),
              ),
            ),
            // Target weight line
            LineChartBarData(
              spots: [
                FlSpot(0, targetWeight),
                FlSpot(spots.length.toDouble() - 1, targetWeight),
              ],
              isCurved: false,
              color: ColorPalette.success,
              barWidth: 2,
              dashArray: [5, 5],
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}