import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/water_notifier.dart';
import 'widgets/water_progress_card.dart';

class WaterScreen extends ConsumerWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(todayWaterTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Water')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WaterProgressCard(currentMl: total, goalMl: dailyWaterGoalMl),
              const SizedBox(height: 24),
              const Text(
                'Add Water',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [100, 250, 500].map((amount) {
                  return ElevatedButton(
                    onPressed: () => ref.read(waterProvider.notifier).addWater(amount),
                    child: Text('+$amount ml'),
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