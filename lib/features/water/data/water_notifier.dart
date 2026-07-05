import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/water_entry_model.dart';
import 'water_repository.dart';

const int dailyWaterGoalMl = 3000;

class WaterNotifier extends StateNotifier<List<WaterEntry>> {
  final WaterRepository _repository = WaterRepository();

  WaterNotifier() : super([]) {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    state = await _repository.getEntries();
  }

  Future<void> addWater(int amountMl) async {
    final entry = WaterEntry(amountMl: amountMl, date: DateTime.now());
    await _repository.insertEntry(entry);
    await _loadEntries();
  }

  Future<void> deleteEntry(int id) async {
    await _repository.deleteEntry(id);
    await _loadEntries();
  }
}

final waterProvider = StateNotifierProvider<WaterNotifier, List<WaterEntry>>(
  (ref) => WaterNotifier(),
);

final todayWaterTotalProvider = Provider<int>((ref) {
  final entries = ref.watch(waterProvider);
  final now = DateTime.now();
  final todayEntries = entries.where((e) =>
      e.date.year == now.year && e.date.month == now.month && e.date.day == now.day);
  return todayEntries.fold(0, (sum, e) => sum + e.amountMl);
});