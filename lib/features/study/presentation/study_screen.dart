import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/study_notifier.dart';
import 'widgets/study_session_tile.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  void _showAddSessionDialog(BuildContext context, WidgetRef ref) {
    final subjectController = TextEditingController();
    final durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Add Study Session', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: durationController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final subject = subjectController.text.trim();
                final duration = int.tryParse(durationController.text.trim()) ?? 0;
                if (subject.isNotEmpty && duration > 0) {
                  ref.read(studyProvider.notifier).addSession(subject, duration);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(studyProvider);
    final todayMinutes = ref.watch(todayStudyMinutesProvider);
    final todaySubjects = ref.watch(todaySubjectsCountProvider);
    final hours = (todayMinutes / 60).floor();
    final minutes = todayMinutes % 60;

    return Scaffold(
      appBar: AppBar(title: const Text('Study')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSessionDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Study Dashboard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.timer,
                      title: 'Today',
                      value: '${hours}h ${minutes}m',
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.menu_book,
                      title: 'Subjects',
                      value: '$todaySubjects',
                      color: Colors.tealAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Sessions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              if (sessions.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('No sessions yet. Tap + to add one.', style: TextStyle(color: Colors.grey[500])),
                ),
              for (final session in sessions)
                StudySessionTile(
                  subject: session.subject,
                  duration: '${session.durationMinutes} min',
                  onDelete: () => ref.read(studyProvider.notifier).deleteSession(session.id!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}