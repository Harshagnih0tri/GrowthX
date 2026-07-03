import 'package:flutter/material.dart';

class WorkoutTile extends StatelessWidget {
  final String exercise;
  final String detail;

  const WorkoutTile({
    super.key,
    required this.exercise,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.sports_gymnastics, color: Colors.orangeAccent),
        title: Text(exercise, style: const TextStyle(color: Colors.white)),
        trailing: Text(detail, style: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}