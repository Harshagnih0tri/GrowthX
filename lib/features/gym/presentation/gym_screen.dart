import 'package:flutter/material.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import 'widgets/recent_workouts_section.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gym')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gym Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
               ),
                const SizedBox(height: 24),
                const RecentWorkoutsSection(),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.fitness_center,
                      title: 'Status',
                      value: 'Done',
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.local_fire_department,
                      title: 'Calories',
                      value: '420 kcal',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}