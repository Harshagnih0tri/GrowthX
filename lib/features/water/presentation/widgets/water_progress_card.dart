import 'package:flutter/material.dart';

class WaterProgressCard extends StatelessWidget {
  final int currentMl;
  final int goalMl;

  const WaterProgressCard({
    super.key,
    required this.currentMl,
    required this.goalMl,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentMl / goalMl).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            '$currentMl ml / $goalMl ml',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.white12,
              color: Colors.cyanAccent,
            ),
          ),
        ],
      ),
    );
  }
}