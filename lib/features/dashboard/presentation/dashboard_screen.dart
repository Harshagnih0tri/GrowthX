import 'package:flutter/material.dart';
import 'widgets/greeting_section.dart';
import 'widgets/today_habits_section.dart';
import 'widgets/today_progress_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const GreetingSection(),
               const SizedBox(height: 24),
               const TodayProgressSection(),
               const SizedBox(height: 24),
               const TodayHabitsSection(),
            ],
          ),
        ),
      ),
    );
  }
}