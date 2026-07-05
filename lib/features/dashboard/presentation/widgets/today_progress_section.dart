import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'summary_card.dart';
import '../../../study/data/study_notifier.dart';
import '../../../study/presentation/study_screen.dart';
import '../../../gym/data/gym_notifier.dart';
import '../../../gym/presentation/gym_screen.dart';
import '../../../weight/data/weight_notifier.dart';
import '../../../weight/presentation/weight_screen.dart';
import '../../../water/data/water_notifier.dart';
import '../../../water/presentation/water_screen.dart';

class TodayProgressSection extends ConsumerWidget {
  const TodayProgressSection({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyMinutes = ref.watch(todayStudyMinutesProvider);
    final gymStatus = ref.watch(todayWorkoutStatusProvider);
    final waterMl = ref.watch(todayWaterTotalProvider);
    final latestWeight = ref.watch(latestWeightProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Progress",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            SummaryCard(
              icon: Icons.book,
              title: 'Study',
              value: '${studyMinutes}m',
              color: Colors.blueAccent,
              onTap: () => _navigateTo(context, const StudyScreen()),
            ),
            SummaryCard(
              icon: Icons.fitness_center,
              title: 'Gym',
              value: gymStatus,
              color: Colors.orangeAccent,
              onTap: () => _navigateTo(context, const GymScreen()),
            ),
            SummaryCard(
              icon: Icons.water_drop,
              title: 'Water',
              value: '${(waterMl / 1000).toStringAsFixed(1)} L',
              color: Colors.cyanAccent,
              onTap: () => _navigateTo(context, const WaterScreen()),
            ),
            SummaryCard(
              icon: Icons.monitor_weight,
              title: 'Weight',
              value: latestWeight == null ? '--' : '${latestWeight.toStringAsFixed(1)} kg',
              color: Colors.purpleAccent,
              onTap: () => _navigateTo(context, const WeightScreen()),
            ),
          ],
        ),
      ],
    );
  }
}