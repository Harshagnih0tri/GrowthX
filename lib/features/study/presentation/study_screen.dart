import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/study_notifier.dart';
import 'widgets/study_session_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  void _showAddSessionDialog(BuildContext context, WidgetRef ref) {
    final subjectController = TextEditingController();
    final durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Study Session'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSessionDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Log Session'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Today'),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.timer_rounded,
                      title: 'Time studied',
                      value: '${hours}h ${minutes}m',
                      color: AppColors.study,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.menu_book_rounded,
                      title: 'Subjects',
                      value: '$todaySubjects',
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: 'Recent Sessions'),
              const SizedBox(height: AppSpacing.md),
              if (sessions.isEmpty)
                const EmptyState(
                  icon: Icons.menu_book_outlined,
                  title: 'No sessions logged',
                  subtitle: 'Tap "Log Session" to record your study time',
                )
              else
                for (final session in sessions)
                  StudySessionTile(
                    subject: session.subject,
                    duration: '${session.durationMinutes} min',
                    time: '${session.date.day}/${session.date.month}/${session.date.year}',
                    onDelete: () => ref.read(studyProvider.notifier).deleteSession(session.id!),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}