import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/workout_model.dart';
import 'gym_repository.dart';

class GymNotifier extends StateNotifier<List<Workout>> {
  final GymRepository _repository = GymRepository();

  GymNotifier() : super([]) {
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    state = await _repository.getWorkouts();
  }

  Future<void> addWorkout(String exercise, int sets, int reps, int calories) async {
    final workout = Workout(
      exercise: exercise,
      sets: sets,
      reps: reps,
      caloriesBurned: calories,
      date: DateTime.now(),
    );
    await _repository.insertWorkout(workout);
    await _loadWorkouts();
  }

  Future<void> deleteWorkout(int id) async {
    await _repository.deleteWorkout(id);
    await _loadWorkouts();
  }
}

final gymProvider = StateNotifierProvider<GymNotifier, List<Workout>>(
  (ref) => GymNotifier(),
);

final todayWorkoutStatusProvider = Provider<String>((ref) {
  final workouts = ref.watch(gymProvider);
  final now = DateTime.now();
  final didWorkoutToday = workouts.any((w) =>
      w.date.year == now.year && w.date.month == now.month && w.date.day == now.day);
  return didWorkoutToday ? 'Done' : 'Pending';
});

final todayCaloriesProvider = Provider<int>((ref) {
  final workouts = ref.watch(gymProvider);
  final now = DateTime.now();
  final todayWorkouts = workouts.where((w) =>
      w.date.year == now.year && w.date.month == now.month && w.date.day == now.day);
  return todayWorkouts.fold(0, (sum, w) => sum + w.caloriesBurned);
});