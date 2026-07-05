import '../../../core/database/database_service.dart';
import '../domain/weight_entry_model.dart';

class WeightRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<WeightEntry>> getEntries() async {
    final db = await _databaseService.database;
    final maps = await db.query('weight_entries', orderBy: 'date DESC');
    return maps.map((map) => WeightEntry.fromMap(map)).toList();
  }

  Future<int> insertEntry(WeightEntry entry) async {
    final db = await _databaseService.database;
    return db.insert('weight_entries', entry.toMap());
  }

  Future<void> deleteEntry(int id) async {
    final db = await _databaseService.database;
    await db.delete('weight_entries', where: 'id = ?', whereArgs: [id]);
  }
}