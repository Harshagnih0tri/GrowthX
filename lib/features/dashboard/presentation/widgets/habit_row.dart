import 'package:flutter/material.dart';

class HabitRow extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const HabitRow({
    super.key,
    required this.title,
    required this.isDone,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? Colors.greenAccent : Colors.grey[500],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
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