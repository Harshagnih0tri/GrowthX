import 'package:flutter/material.dart';

class StudySessionTile extends StatelessWidget {
  final String subject;
  final String duration;

  const StudySessionTile({
    super.key,
    required this.subject,
    required this.duration,
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
        leading: const Icon(Icons.menu_book, color: Colors.tealAccent),
        title: Text(subject, style: const TextStyle(color: Colors.white)),
        trailing: Text(duration, style: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
