import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/weight_notifier.dart';
import 'widgets/weight_entry_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class WeightScreen extends ConsumerWidget {
  const WeightScreen({super.key});

  void _showAddWeightDialog(BuildContext context, WidgetRef ref) {
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Weight'),
          content: TextField(
            controller: weightController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final weight = double.tryParse(weightController.text.trim());
                if (weight != null && weight > 0) {
                  ref.read(weightProvider.notifier).addEntry(weight);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(weightProvider);
    final latest = ref.watch(latestWeightProvider);
    final change = ref.watch(weightChangeProvider);

    final changeText = change == null
        ? '--'
        : '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)} kg';
    final changeColor = change == null
        ? AppColors.textSecondary
        : (change <= 0 ? AppColors.success : AppColors.error);

    return Scaffold(
      appBar: AppBar(title: const Text('Weight')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddWeightDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Log Weight'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Overview'),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.monitor_weight_rounded,
                      title: 'Current',
                      value: latest == null ? '--' : '${latest.toStringAsFixed(1)} kg',
                      color: AppColors.weight,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.trending_up_rounded,
                      title: 'Change',
                      value: changeText,
                      color: changeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: 'History'),
              const SizedBox(height: AppSpacing.md),
              if (entries.isEmpty)
                const EmptyState(
                  icon: Icons.monitor_weight_outlined,
                  title: 'No entries yet',
                  subtitle: 'Tap "Log Weight" to start tracking',
                )
              else
                for (final entry in entries)
                  WeightEntryTile(
                    weight: '${entry.weightKg.toStringAsFixed(1)} kg',
                    date: '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                    onDelete: () => ref.read(weightProvider.notifier).deleteEntry(entry.id!),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}