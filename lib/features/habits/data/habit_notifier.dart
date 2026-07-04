import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/habit_model.dart';

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super(const [
    Habit(title: 'Read 20 pages', isDone: true),
    Habit(title: 'Meditate 10 mins', isDone: false),
    Habit(title: 'No junk food', isDone: true),
    Habit(title: 'Sleep before 12 AM', isDone: false),
  ]);

  void toggleHabit(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(isDone: !state[i].isDone) else state[i],
    ];
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>(
  (ref) => HabitNotifier(),
);