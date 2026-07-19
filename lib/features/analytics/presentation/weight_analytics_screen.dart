import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weight_analytics_provider.dart';
import '../../weight/data/weight_notifier.dart';
import 'widgets/analytics_section.dart';
import 'widgets/metric_card.dart';
import 'widgets/chart_card.dart';
import 'widgets/mini_line_chart.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class WeightAnalyticsScreen extends ConsumerWidget {
  const WeightAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendData = ref.watch(weightTrendDataProvider);
    final latest = ref.watch(latestWeightProvider);
    final weeklyChange = ref.watch(weeklyWeightChangeProvider);
    final monthlyChange = ref.watch(monthlyWeightChangeProvider);

    String formatChange(double? change) {
      if (change == null) return '--';
      final sign = change >= 0 ? '+' : '';
      return '$sign${change.toStringAsFixed(1)} kg';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Weight Analytics')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnalyticsSection(
                title: 'Trend',
                child: trendData.isEmpty
                    ? const EmptyState(
                        icon: Icons.monitor_weight_outlined,
                        title: 'Not enough data',
                        subtitle: 'Log a few weight entries to see your trend',
                      )
                    : ChartCard(
                        title: 'Weight Over Time',
                        subtitle: 'Last ${trendData.length} entries',
                        chart: MiniLineChart(points: trendData, color: AppColors.weight),
                      ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AnalyticsSection(
                title: 'Overview',
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.4,
                  children: [
                    MetricCard(
                      icon: Icons.monitor_weight_rounded,
                      label: 'Current',
                      value: latest == null ? '--' : '${latest.toStringAsFixed(1)} kg',
                      color: AppColors.weight,
                    ),
                    MetricCard(
                      icon: Icons.calendar_view_week_rounded,
                      label: 'This Week',
                      value: formatChange(weeklyChange),
                      color: AppColors.info,
                      trend: weeklyChange == null ? null : formatChange(weeklyChange),
                      trendPositive: weeklyChange == null ? true : weeklyChange <= 0,
                    ),
                    MetricCard(
                      icon: Icons.calendar_month_rounded,
                      label: 'This Month',
                      value: formatChange(monthlyChange),
                      color: AppColors.accent,
                      trend: monthlyChange == null ? null : formatChange(monthlyChange),
                      trendPositive: monthlyChange == null ? true : monthlyChange <= 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}