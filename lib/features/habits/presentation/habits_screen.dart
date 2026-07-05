import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/habit_row.dart';
import '../data/habit_notifier.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Habit'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Habit name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  ref.read(habitProvider.notifier).addHabit(title);
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
    final habits = ref.watch(habitProvider);
    final doneCount = habits.where((h) => h.isDone).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddHabitDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Habit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (habits.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  margin: const EdgeInsets.only(bottom: AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.habit.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.habit.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.local_fire_department_rounded, color: AppColors.habit),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$doneCount of ${habits.length} completed', style: AppTextStyles.title),
                          Text('Keep the streak going', style: AppTextStyles.bodyMuted),
                        ],
                      ),
                    ],
                  ),
                ),
              const SectionHeader(title: 'All Habits'),
              const SizedBox(height: AppSpacing.md),
              if (habits.isEmpty)
                const EmptyState(
                  icon: Icons.check_circle_outline_rounded,
                  title: 'No habits yet',
                  subtitle: 'Tap "New Habit" to start building your routine',
                )
              else
                for (int i = 0; i < habits.length; i++)
                  HabitRow(
                    title: habits[i].title,
                    isDone: habits[i].isDone,
                    onTap: () => ref.read(habitProvider.notifier).toggleHabit(i),
                    onDelete: () => ref.read(habitProvider.notifier).deleteHabit(habits[i].id!),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}