import '../../../core/database/database_service.dart';
import '../domain/journal_entry_model.dart';

class JournalRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<JournalEntry>> getEntries() async {
    final db = await _databaseService.database;
    final maps = await db.query('journal_entries', orderBy: 'date DESC');
    return maps.map((map) => JournalEntry.fromMap(map)).toList();
  }

  Future<int> insertEntry(JournalEntry entry) async {
    final db = await _databaseService.database;
    return db.insert('journal_entries', entry.toMap());
  }

  Future<void> deleteEntry(int id) async {
    final db = await _databaseService.database;
    await db.delete('journal_entries', where: 'id = ?', whereArgs: [id]);
  }
}