import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/weight_notifier.dart';
import 'widgets/weight_entry_tile.dart';

class WeightScreen extends ConsumerWidget {
  const WeightScreen({super.key});

  void _showAddWeightDialog(BuildContext context, WidgetRef ref) {
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Log Weight', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: weightController,
            style: const TextStyle(color: Colors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
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

    return Scaffold(
      appBar: AppBar(title: const Text('Weight')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWeightDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weight Dashboard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.monitor_weight,
                      title: 'Current',
                      value: latest == null ? '--' : '${latest.toStringAsFixed(1)} kg',
                      color: Colors.purpleAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.trending_up,
                      title: 'Change',
                      value: changeText,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              if (entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('No entries yet. Tap + to log your weight.', style: TextStyle(color: Colors.grey[500])),
                ),
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