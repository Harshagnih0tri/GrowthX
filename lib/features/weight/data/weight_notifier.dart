import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/weight_entry_model.dart';
import 'weight_repository.dart';

class WeightNotifier extends StateNotifier<List<WeightEntry>> {
  final WeightRepository _repository = WeightRepository();

  WeightNotifier() : super([]) {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    state = await _repository.getEntries();
  }

  Future<void> addEntry(double weightKg) async {
    final entry = WeightEntry(weightKg: weightKg, date: DateTime.now());
    await _repository.insertEntry(entry);
    await _loadEntries();
  }

  Future<void> deleteEntry(int id) async {
    await _repository.deleteEntry(id);
    await _loadEntries();
  }
}

final weightProvider = StateNotifierProvider<WeightNotifier, List<WeightEntry>>(
  (ref) => WeightNotifier(),
);

final latestWeightProvider = Provider<double?>((ref) {
  final entries = ref.watch(weightProvider);
  if (entries.isEmpty) return null;
  return entries.first.weightKg;
});

final weightChangeProvider = Provider<double?>((ref) {
  final entries = ref.watch(weightProvider);
  if (entries.length < 2) return null;
  return entries.first.weightKg - entries[1].weightKg;
});