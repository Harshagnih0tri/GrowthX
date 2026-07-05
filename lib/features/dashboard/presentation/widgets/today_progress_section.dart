import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'summary_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
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
        const SectionHeader(title: "Today's Progress"),
        const SizedBox(height: 12),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.2,
          children: [
            SummaryCard(
              icon: Icons.menu_book_rounded,
              title: 'Study',
              value: '${studyMinutes}m',
              color: AppColors.study,
              onTap: () => _navigateTo(context, const StudyScreen()),
            ),
            SummaryCard(
              icon: Icons.fitness_center_rounded,
              title: 'Gym',
              value: gymStatus,
              color: AppColors.gym,
              onTap: () => _navigateTo(context, const GymScreen()),
            ),
            SummaryCard(
              icon: Icons.water_drop_rounded,
              title: 'Water',
              value: '${(waterMl / 1000).toStringAsFixed(1)} L',
              color: AppColors.water,
              onTap: () => _navigateTo(context, const WaterScreen()),
            ),
            SummaryCard(
              icon: Icons.monitor_weight_rounded,
              title: 'Weight',
              value: latestWeight == null
                  ? '--'
                  : '${latestWeight.toStringAsFixed(1)} kg',
              color: AppColors.weight,
              onTap: () => _navigateTo(context, const WeightScreen()),
            ),
          ],
        ),
      ],
    );
  }
}