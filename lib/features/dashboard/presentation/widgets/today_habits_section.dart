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
    final habitsAsync = ref.watch(habitProvider);

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
            child: const Text('Manage'),
          ),
        ),
        const SizedBox(height: 12),
        habitsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => const EmptyState(
            icon: Icons.error_outline_rounded,
            title: 'Could not load habits',
            subtitle: 'Tap Manage to try again',
          ),
          data: (habits) => habits.isEmpty
              ? const EmptyState(
                  icon: Icons.check_circle_outline_rounded,
                  title: 'No habits yet',
                  subtitle: 'Tap Manage to create your first habit',
                )
              : Column(
                  children: [
                    for (final habit in habits)
                      HabitRow(
                        name: habit.name,
                        description: habit.description,
                        frequency: habit.frequency,
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}