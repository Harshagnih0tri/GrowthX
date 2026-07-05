import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/chart_point.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MiniLineChart extends StatelessWidget {
  final List<ChartPoint> points;
  final Color color;
  final double height;

  const MiniLineChart({
    super.key,
    required this.points,
    required this.color,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = points.map((p) => p.value).fold<double>(0, (a, b) => a > b ? a : b);
    final safeMaxY = maxY == 0 ? 10.0 : maxY * 1.3;

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: safeMaxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: safeMaxY / 4,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.divider,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= points.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(points[index].label, style: AppTextStyles.caption),
                  );
                },
                reservedSize: 28,
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.surfaceElevated,
              getTooltipItems: (spots) => spots.map((s) {
                return LineTooltipItem(
                  s.y.toStringAsFixed(0),
                  AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].value),
              ],
              isCurved: true,
              color: color,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}