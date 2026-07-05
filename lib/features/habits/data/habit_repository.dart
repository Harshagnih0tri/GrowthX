import '../../../core/database/database_service.dart';
import '../domain/habit_model.dart';

class HabitRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Habit>> getHabits() async {
    final db = await _databaseService.database;
    final maps = await db.query('habits');
    return maps.map((map) => Habit.fromMap(map)).toList();
  }

  Future<int> insertHabit(Habit habit) async {
    final db = await _databaseService.database;
    return db.insert('habits', habit.toMap());
  }

  Future<void> updateHabit(Habit habit) async {
    final db = await _databaseService.database;
    await db.update(
      'habits',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }
}