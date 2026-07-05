import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/journal_notifier.dart';
import 'widgets/journal_entry_tile.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  void _showAddEntryDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedMood = 'Neutral';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              title: const Text('New Journal Entry', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: contentController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'What happened today?'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: selectedMood,
                    dropdownColor: const Color(0xFF1E1E1E),
                    style: const TextStyle(color: Colors.white),
                    items: ['Happy', 'Neutral', 'Sad', 'Stressed', 'Excited']
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedMood = value!),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Journal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              if (entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('No entries yet. Tap + to write one.', style: TextStyle(color: Colors.grey[500])),
                ),
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