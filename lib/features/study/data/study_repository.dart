import '../../../core/database/database_service.dart';
import '../domain/study_session_model.dart';

class StudyRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<StudySession>> getSessions() async {
    final db = await _databaseService.database;
    final maps = await db.query('study_sessions', orderBy: 'date DESC');
    return maps.map((map) => StudySession.fromMap(map)).toList();
  }

  Future<int> insertSession(StudySession session) async {
    final db = await _databaseService.database;
    return db.insert('study_sessions', session.toMap());
  }

  Future<void> deleteSession(int id) async {
    final db = await _databaseService.database;
    await db.delete('study_sessions', where: 'id = ?', whereArgs: [id]);
  }
}