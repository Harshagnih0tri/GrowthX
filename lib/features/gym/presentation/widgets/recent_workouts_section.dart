import 'package:flutter/material.dart';
import 'workout_tile.dart';

class _WorkoutData {
  final String exercise;
  final String detail;

  const _WorkoutData({required this.exercise, required this.detail});
}

class RecentWorkoutsSection extends StatelessWidget {
  const RecentWorkoutsSection({super.key});

  static const List<_WorkoutData> _workouts = [
    _WorkoutData(exercise: 'Bench Press', detail: '4x8'),
    _WorkoutData(exercise: 'Squats', detail: '3x10'),
    _WorkoutData(exercise: 'Deadlift', detail: '3x5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Workouts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ..._workouts.map((workout) {
          return WorkoutTile(
            exercise: workout.exercise,
            detail: workout.detail,
          );
        }),
      ],
    );
  }
}