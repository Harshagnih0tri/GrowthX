import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/habit_row.dart';
import '../data/habit_notifier.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_spacing.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedFrequency = 'daily';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Habit'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Habit name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: selectedFrequency,
                    decoration: const InputDecoration(labelText: 'Frequency'),
                    items: const [
                      DropdownMenuItem(value: 'daily', child: Text('Daily')),
                      DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                      DropdownMenuItem(
                        value: '3x per week',
                        child: Text('3x per week'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedFrequency = value);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      final description = descriptionController.text.trim();
                      ref.read(habitProvider.notifier).addHabit(
                            name: name,
                            description: description.isEmpty ? null : description,
                            frequency: selectedFrequency,
                          );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddHabitDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Habit'),
      ),
      body: SafeArea(
        child: habitsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 48),
                  const SizedBox(height: AppSpacing.md),
                  Text('Could not load habits.\n$error', textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => ref.read(habitProvider.notifier).loadHabits(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (habits) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'All Habits'),
                const SizedBox(height: AppSpacing.md),
                if (habits.isEmpty)
                  const EmptyState(
                    icon: Icons.check_circle_outline_rounded,
                    title: 'No habits yet',
                    subtitle: 'Tap "New Habit" to start building your routine',
                  )
                else
                  for (final habit in habits)
                    HabitRow(
                      name: habit.name,
                      description: habit.description,
                      frequency: habit.frequency,
                      onDelete: () =>
                          ref.read(habitProvider.notifier).deleteHabit(habit.id),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}