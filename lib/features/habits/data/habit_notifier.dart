import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/habit_model.dart';
import 'habit_repository.dart';

class HabitNotifier extends StateNotifier<List<Habit>> {
  final HabitRepository _repository = HabitRepository();

  HabitNotifier() : super([]) {
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    var habits = await _repository.getHabits();

    if (habits.isEmpty) {
      const defaults = [
        Habit(title: 'Read 20 pages', isDone: false),
        Habit(title: 'Meditate 10 mins', isDone: false),
        Habit(title: 'No junk food', isDone: false),
        Habit(title: 'Sleep before 12 AM', isDone: false),
      ];
      for (final habit in defaults) {
        await _repository.insertHabit(habit);
      }
      habits = await _repository.getHabits();
    }

    state = habits;
  }

  Future<void> toggleHabit(int index) async {
    final habit = state[index];
    final updated = habit.copyWith(isDone: !habit.isDone);
    await _repository.updateHabit(updated);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updated else state[i],
    ];
  }

  Future<void> addHabit(String title) async {
    final habit = Habit(title: title, isDone: false);
    await _repository.insertHabit(habit);
    state = await _repository.getHabits();
  }

  Future<void> deleteHabit(int id) async {
    await _repository.deleteHabit(id);
    state = await _repository.getHabits();
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>(
  (ref) => HabitNotifier(),
);