import 'package:flutter/material.dart';
import 'widgets/greeting_section.dart';
import 'widgets/today_progress_section.dart';
import 'widgets/today_habits_section.dart';
import 'widgets/quick_access_section.dart';
import '../../../core/theme/app_spacing.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingSection(),
              const SizedBox(height: AppSpacing.xl),
              const TodayProgressSection(),
              const SizedBox(height: AppSpacing.xl),
              const QuickAccessSection(),
              const SizedBox(height: AppSpacing.xl),
              const TodayHabitsSection(),
            ],
          ),
        ),
      ),
    );
  }
}