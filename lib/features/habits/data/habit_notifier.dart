import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/habit_model.dart';
import 'habit_repository.dart';

class HabitNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  final HabitRepository _repository = HabitRepository();

  HabitNotifier() : super(const AsyncValue.loading()) {
    loadHabits();
  }

  Future<void> loadHabits() async {
    state = const AsyncValue.loading();
    try {
      final habits = await _repository.getHabits();
      state = AsyncValue.data(habits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addHabit({
    required String name,
    String? description,
    required String frequency,
  }) async {
    try {
      await _repository.createHabit(
        name: name,
        description: description,
        frequency: frequency,
      );
      await loadHabits();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteHabit(String id) async {
    try {
      await _repository.deleteHabit(id);
      await loadHabits();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, AsyncValue<List<Habit>>>(
  (ref) => HabitNotifier(),
);