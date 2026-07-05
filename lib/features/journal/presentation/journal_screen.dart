import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/journal_notifier.dart';
import 'widgets/journal_entry_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  void _showAddEntryDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedMood = 'Neutral';
    const moods = ['Happy', 'Neutral', 'Sad', 'Stressed', 'Excited'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Journal Entry'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: contentController,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: 'What happened today?'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: moods.map((m) {
                        final selected = m == selectedMood;
                        return ChoiceChip(
                          label: Text(m),
                          selected: selected,
                          onSelected: (_) => setState(() => selectedMood = m),
                          selectedColor: AppColors.journal.withValues(alpha: 0.25),
                          backgroundColor: AppColors.surfaceElevated,
                          labelStyle: TextStyle(
                            color: selected ? AppColors.journal : AppColors.textSecondary,
                          ),
                          side: BorderSide.none,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final content = contentController.text.trim();
                    if (title.isNotEmpty && content.isNotEmpty) {
                      ref.read(journalProvider.notifier).addEntry(title, content, selectedMood);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntryDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Daily Journal'),
              const SizedBox(height: AppSpacing.md),
              if (entries.isEmpty)
                const EmptyState(
                  icon: Icons.auto_stories_outlined,
                  title: 'No entries yet',
                  subtitle: 'Tap "New Entry" to write your first reflection',
                )
              else
                for (final entry in entries)
                  JournalEntryTile(
                    title: entry.title,
                    mood: entry.mood,
                    date: '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                    onDelete: () => ref.read(journalProvider.notifier).deleteEntry(entry.id!),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}