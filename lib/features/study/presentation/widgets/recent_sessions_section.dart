import 'package:flutter/material.dart';
import 'study_session_tile.dart';

class _SessionData {
  final String subject;
  final String duration;

  const _SessionData({required this.subject, required this.duration});
}

class RecentSessionsSection extends StatelessWidget {
  const RecentSessionsSection({super.key});

  static const List<_SessionData> _sessions = [
    _SessionData(subject: 'Flutter Development', duration: '45 min'),
    _SessionData(subject: 'DSA Practice', duration: '30 min'),
    _SessionData(subject: 'System Design', duration: '15 min'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Sessions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ..._sessions.map((session) {
          return StudySessionTile(
            subject: session.subject,
            duration: session.duration,
            time: 'Today',
          );
        }),
      ],
    );
  }
}