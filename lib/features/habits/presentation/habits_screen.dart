import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/habit_row.dart';
import '../data/habit_notifier.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All Habits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < habits.length; i++)
                HabitRow(
                  title: habits[i].title,
                  isDone: habits[i].isDone,
                  onTap: () => ref.read(habitProvider.notifier).toggleHabit(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}