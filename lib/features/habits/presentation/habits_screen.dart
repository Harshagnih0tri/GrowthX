import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/habit_row.dart';
import '../data/habit_notifier.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('New Habit', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(labelText: 'Habit name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
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

    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context, ref),
        child: const Icon(Icons.add),
      ),
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
              if (habits.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('No habits yet. Tap + to add one.', style: TextStyle(color: Colors.grey[500])),
                ),
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