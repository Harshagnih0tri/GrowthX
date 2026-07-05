import 'package:flutter/material.dart';

class WeightEntryTile extends StatelessWidget {
  final String weight;
  final String date;
  final VoidCallback? onDelete;

  const WeightEntryTile({
    super.key,
    required this.weight,
    required this.date,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.monitor_weight, color: Colors.purpleAccent),
        title: Text(weight, style: const TextStyle(color: Colors.white)),
        subtitle: Text(date, style: TextStyle(color: Colors.grey[500])),
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