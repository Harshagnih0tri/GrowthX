import '../../../core/database/database_service.dart';
import '../domain/water_entry_model.dart';

class WaterRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<WaterEntry>> getEntries() async {
    final db = await _databaseService.database;
    final maps = await db.query('water_entries', orderBy: 'date DESC');
    return maps.map((map) => WaterEntry.fromMap(map)).toList();
  }

  Future<int> insertEntry(WaterEntry entry) async {
    final db = await _databaseService.database;
    return db.insert('water_entries', entry.toMap());
  }

  Future<void> deleteEntry(int id) async {
    final db = await _databaseService.database;
    await db.delete('water_entries', where: 'id = ?', whereArgs: [id]);
  }
}