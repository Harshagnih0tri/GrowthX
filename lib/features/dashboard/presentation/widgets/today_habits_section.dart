import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'habit_row.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../habits/data/habit_notifier.dart';
import '../../../habits/presentation/habits_screen.dart';

class TodayHabitsSection extends ConsumerWidget {
  const TodayHabitsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);
    final doneCount = habits.where((h) => h.isDone).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Today's Habits",
          trailing: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HabitsScreen()),
            ),
            child: Text(habits.isEmpty ? 'Manage' : '$doneCount/${habits.length}'),
          ),
        ),
        const SizedBox(height: 12),
        if (habits.isEmpty)
          const EmptyState(
            icon: Icons.check_circle_outline_rounded,
            title: 'No habits yet',
            subtitle: 'Tap Manage to create your first habit',
          )
        else
          for (int i = 0; i < habits.length; i++)
            HabitRow(
              title: habits[i].title,
              isDone: habits[i].isDone,
              onTap: () => ref.read(habitProvider.notifier).toggleHabit(i),
            ),
      ],
    );
  }
}