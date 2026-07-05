import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/study_analytics_provider.dart';
import 'widgets/analytics_section.dart';
import 'widgets/metric_card.dart';
import 'widgets/chart_card.dart';
import 'widgets/mini_line_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class StudyAnalyticsScreen extends ConsumerWidget {
  const StudyAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyPoints = ref.watch(last7DaysStudyDataProvider);
    final weeklyTotal = ref.watch(weeklyStudyTotalProvider);
    final monthlyTotal = ref.watch(monthlyStudyTotalProvider);
    final avgSession = ref.watch(averageSessionDurationProvider);
    final topSubject = ref.watch(mostStudiedSubjectProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Study Analytics')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnalyticsSection(
                title: 'Last 7 Days',
                child: ChartCard(
                  title: 'Study Time',
                  subtitle: 'Minutes studied per day',
                  chart: MiniLineChart(points: weeklyPoints, color: AppColors.study),
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
                      icon: Icons.calendar_view_week_rounded,
                      label: 'This Week',
                      value: '${(weeklyTotal / 60).floor()}h ${weeklyTotal % 60}m',
                      color: AppColors.study,
                    ),
                    MetricCard(
                      icon: Icons.calendar_month_rounded,
                      label: 'This Month',
                      value: '${(monthlyTotal / 60).floor()}h ${monthlyTotal % 60}m',
                      color: AppColors.info,
                    ),
                    MetricCard(
                      icon: Icons.timer_rounded,
                      label: 'Avg Session',
                      value: '${avgSession.toStringAsFixed(0)}m',
                      color: AppColors.accent,
                    ),
                    MetricCard(
                      icon: Icons.emoji_events_rounded,
                      label: 'Top Subject',
                      value: topSubject,
                      color: AppColors.warning,
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