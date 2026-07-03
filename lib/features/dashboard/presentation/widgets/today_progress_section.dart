import 'package:flutter/material.dart';
import 'summary_card.dart';

class _ProgressCardData {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ProgressCardData({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });
}

class TodayProgressSection extends StatelessWidget {
  const TodayProgressSection({super.key});

  static const List<_ProgressCardData> _cardData = [
    _ProgressCardData(
      icon: Icons.book,
      title: 'Study',
      value: '1.5 hrs',
      color: Colors.blueAccent,
    ),
    _ProgressCardData(
      icon: Icons.fitness_center,
      title: 'Gym',
      value: 'Done',
      color: Colors.orangeAccent,
    ),
    _ProgressCardData(
      icon: Icons.water_drop,
      title: 'Water',
      value: '2.1 L',
      color: Colors.cyanAccent,
    ),
    _ProgressCardData(
      icon: Icons.monitor_weight,
      title: 'Weight',
      value: '70 kg',
      color: Colors.purpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Progress",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: _cardData.map((data) {
            return SummaryCard(
              icon: data.icon,
              title: data.title,
              value: data.value,
              color: data.color,
            );
          }).toList(),
        ),
      ],
    );
  }
}