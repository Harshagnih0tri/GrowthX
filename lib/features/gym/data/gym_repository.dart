import '../../../core/database/database_service.dart';
import '../domain/workout_model.dart';

class GymRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Workout>> getWorkouts() async {
    final db = await _databaseService.database;
    final maps = await db.query('workouts', orderBy: 'date DESC');
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await _databaseService.database;
    return db.insert('workouts', workout.toMap());
  }

  Future<void> deleteWorkout(int id) async {
    final db = await _databaseService.database;
    await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}