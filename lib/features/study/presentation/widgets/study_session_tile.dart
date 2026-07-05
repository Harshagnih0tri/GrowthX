import 'package:flutter/material.dart';

class StudySessionTile extends StatelessWidget {
  final String subject;
  final String duration;
  final VoidCallback? onDelete;

  const StudySessionTile({
    super.key,
    required this.subject,
    required this.duration,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.tealAccent),
        title: Text(subject, style: const TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(duration, style: TextStyle(color: Colors.grey[400])),
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
