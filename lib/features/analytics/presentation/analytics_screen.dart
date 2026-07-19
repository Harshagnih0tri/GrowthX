import 'package:flutter/material.dart';
import 'study_analytics_screen.dart';
import 'weight_analytics_screen.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  void _openComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature analytics coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            _AnalyticsTile(
              icon: Icons.menu_book_rounded,
              title: 'Study',
              subtitle: 'Sessions, trends, subjects',
              color: AppColors.study,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudyAnalyticsScreen(),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            _AnalyticsTile(
              icon: Icons.monitor_weight_rounded,
              title: 'Weight',
              subtitle: 'Trend and change over time',
              color: AppColors.weight,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WeightAnalyticsScreen(),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            _AnalyticsTile(
              icon: Icons.water_drop_rounded,
              title: 'Water',
              subtitle: 'Daily intake and goal progress',
              color: AppColors.water,
              onTap: () => _openComingSoon(context, 'Water'),
            ),

            const SizedBox(height: AppSpacing.md),

            _AnalyticsTile(
              icon: Icons.fitness_center_rounded,
              title: 'Gym',
              subtitle: 'Workout frequency and calories',
              color: AppColors.gym,
              onTap: () => _openComingSoon(context, 'Gym'),
            ),

            const SizedBox(height: AppSpacing.md),

            _AnalyticsTile(
              icon: Icons.check_circle_rounded,
              title: 'Habits',
              subtitle: 'Completion rate over time',
              color: AppColors.habit,
              onTap: () => _openComingSoon(context, 'Habit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AnalyticsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: AppColors.surfaceBorder,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.title),
                    Text(subtitle, style: AppTextStyles.bodyMuted),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       