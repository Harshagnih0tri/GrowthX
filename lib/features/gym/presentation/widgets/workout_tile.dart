import 'package:flutter/material.dart';

class WorkoutTile extends StatelessWidget {
  final String exercise;
  final String detail;
  final String calories;
  final VoidCallback? onDelete;

  const WorkoutTile({
    super.key,
    required this.exercise,
    required this.detail,
    required this.calories,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.sports_gymnastics, color: Colors.orangeAccent),
        title: Text(exercise, style: const TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(detail, style: TextStyle(color: Colors.grey[400])),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}