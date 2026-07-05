import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/water_notifier.dart';
import 'widgets/water_progress_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

class WaterScreen extends ConsumerWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(todayWaterTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Water')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WaterProgressCard(currentMl: total, goalMl: dailyWaterGoalMl),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: 'Quick Add'),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [100, 250, 500].map((amount) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: OutlinedButton(
                        onPressed: () => ref.read(waterProvider.notifier).addWater(amount),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.surfaceBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.water_drop_rounded, color: AppColors.water, size: 20),
                            const SizedBox(height: 4),
                            Text('+$amount ml', style: AppTextStyles.body),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}