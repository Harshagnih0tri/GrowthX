import 'package:flutter/material.dart';
import 'habit_row.dart';

class _HabitData {
  final String title;
  final bool isDone;

  const _HabitData({
    required this.title,
    required this.isDone,
  });
}

class TodayHabitsSection extends StatelessWidget {
  const TodayHabitsSection({super.key});

  static const List<_HabitData> _habits = [
    _HabitData(title: 'Read 20 pages', isDone: true),
    _HabitData(title: 'Meditate 10 mins', isDone: false),
    _HabitData(title: 'No junk food', isDone: true),
    _HabitData(title: 'Sleep before 12 AM', isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Habits",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ..._habits.map((habit) {
          return HabitRow(
            title: habit.title,
            isDone: habit.isDone,
          );
        }),
      ],
    );
  }
}
