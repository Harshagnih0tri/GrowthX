import 'package:flutter/material.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import 'widgets/recent_sessions_section.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Study Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
              const SizedBox(height: 24),
               const RecentSessionsSection(),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.timer,
                      title: 'Today',
                      value: '1.5 hrs',
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.menu_book,
                      title: 'Subjects',
                      value: '3',
                      color: Colors.tealAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}