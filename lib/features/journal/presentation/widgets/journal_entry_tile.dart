import 'package:flutter/material.dart';

class JournalEntryTile extends StatelessWidget {
  final String title;
  final String mood;
  final String date;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const JournalEntryTile({
    super.key,
    required this.title,
    required this.mood,
    required this.date,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.book, color: Colors.amberAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text('$mood · $date', style: TextStyle(color: Colors.grey[500])),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}