import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../study/data/study_notifier.dart';
import '../data/chart_point.dart';

final last7DaysStudyDataProvider = Provider<List<ChartPoint>>((ref) {
  final sessions = ref.watch(studyProvider);
  final now = DateTime.now();
  const dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<ChartPoint> points = [];
  for (int i = 6; i >= 0; i--) {
    final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
    final totalMinutes = sessions
        .where((s) => s.date.year == day.year && s.date.month == day.month && s.date.day == day.day)
        .fold<int>(0, (sum, s) => sum + s.durationMinutes);
    points.add(ChartPoint(label: dayLabels[day.weekday - 1], value: totalMinutes.toDouble()));
  }
  return points;
});

final weeklyStudyTotalProvider = Provider<int>((ref) {
  final points = ref.watch(last7DaysStudyDataProvider);
  return points.fold<int>(0, (sum, p) => sum + p.value.toInt());
});

final monthlyStudyTotalProvider = Provider<int>((ref) {
  final sessions = ref.watch(studyProvider);
  final now = DateTime.now();
  return sessions
      .where((s) => s.date.year == now.year && s.date.month == now.month)
      .fold<int>(0, (sum, s) => sum + s.durationMinutes);
});

final averageSessionDurationProvider = Provider<double>((ref) {
  final sessions = ref.watch(studyProvider);
  if (sessions.isEmpty) return 0;
  final total = sessions.fold<int>(0, (sum, s) => sum + s.durationMinutes);
  return total / sessions.length;
});

final mostStudiedSubjectProvider = Provider<String>((ref) {
  final sessions = ref.watch(studyProvider);
  if (sessions.isEmpty) return '--';

  final Map<String, int> totals = {};
  for (final session in sessions) {
    totals[session.subject] = (totals[session.subject] ?? 0) + session.durationMinutes;
  }

  var topSubject = '--';
  var topMinutes = 0;
  totals.forEach((subject, minutes) {
    if (minutes > topMinutes) {
      topMinutes = minutes;
      topSubject = subject;
    }
  });
  return topSubject;
});