import 'package:flutter/material.dart';
import '../../dashboard/presentation/widgets/habit_row.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const HabitRow(title: 'Read 20 pages', isDone: true),
              const HabitRow(title: 'Meditate 10 mins', isDone: false),
              const HabitRow(title: 'No junk food', isDone: true),
              const HabitRow(title: 'Sleep before 12 AM', isDone: false),
              const HabitRow(title: 'Drink 3L water', isDone: true),
              const HabitRow(title: 'Morning walk', isDone: false),
            ],
          ),
        ),
      ),
    );
  }
}