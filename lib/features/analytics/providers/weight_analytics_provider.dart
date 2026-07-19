import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../weight/data/weight_notifier.dart';
import '../data/chart_point.dart';

final weightTrendDataProvider = Provider<List<ChartPoint>>((ref) {
  final entries = ref.watch(weightProvider);
  if (entries.isEmpty) return [];

  // entries are ordered date DESC (newest first) — reverse for chronological chart order
  final chronological = entries.reversed.toList();
  final recent = chronological.length > 10
      ? chronological.sublist(chronological.length - 10)
      : chronological;

  return recent.map((e) {
    final label = '${e.date.day}/${e.date.month}';
    return ChartPoint(label: label, value: e.weightKg);
  }).toList();
});

final weeklyWeightChangeProvider = Provider<double?>((ref) {
  final entries = ref.watch(weightProvider);
  final now = DateTime.now();
  final weekAgo = now.subtract(const Duration(days: 7));

  final currentEntries = entries.where((e) => e.date.isAfter(weekAgo)).toList();
  if (currentEntries.isEmpty || entries.isEmpty) return null;

  final oldestThisWeek = currentEntries.last;
  final latest = entries.first;
  if (oldestThisWeek.id == latest.id) return null;

  return latest.weightKg - oldestThisWeek.weightKg;
});

final monthlyWeightChangeProvider = Provider<double?>((ref) {
  final entries = ref.watch(weightProvider);
  final now = DateTime.now();
  final monthAgo = DateTime(now.year, now.month - 1, now.day);

  final currentEntries = entries.where((e) => e.date.isAfter(monthAgo)).toList();
  if (currentEntries.isEmpty || entries.isEmpty) return null;

  final oldestThisMonth = currentEntries.last;
  final latest = entries.first;
  if (oldestThisMonth.id == latest.id) return null;

  return latest.weightKg - oldestThisMonth.weightKg;
});