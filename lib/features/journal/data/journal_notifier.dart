import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/journal_entry_model.dart';
import 'journal_repository.dart';

class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  final JournalRepository _repository = JournalRepository();

  JournalNotifier() : super([]) {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    state = await _repository.getEntries();
  }

  Future<void> addEntry(String title, String content, String mood) async {
    final entry = JournalEntry(
      title: title,
      content: content,
      mood: mood,
      date: DateTime.now(),
    );
    await _repository.insertEntry(entry);
    await _loadEntries();
  }

  Future<void> deleteEntry(int id) async {
    await _repository.deleteEntry(id);
    await _loadEntries();
  }
}

final journalProvider = StateNotifierProvider<JournalNotifier, List<JournalEntry>>(
  (ref) => JournalNotifier(),
);