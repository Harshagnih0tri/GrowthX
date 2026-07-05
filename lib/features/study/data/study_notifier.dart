import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/study_session_model.dart';
import 'study_repository.dart';

class StudyNotifier extends StateNotifier<List<StudySession>> {
  final StudyRepository _repository = StudyRepository();

  StudyNotifier() : super([]) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    state = await _repository.getSessions();
  }

  Future<void> addSession(String subject, int durationMinutes) async {
    final session = StudySession(
      subject: subject,
      durationMinutes: durationMinutes,
      date: DateTime.now(),
    );
    await _repository.insertSession(session);
    await _loadSessions();
  }

  Future<void> deleteSession(int id) async {
    await _repository.deleteSession(id);
    await _loadSessions();
  }
}

final studyProvider = StateNotifierProvider<StudyNotifier, List<StudySession>>(
  (ref) => StudyNotifier(),
);

final todayStudyMinutesProvider = Provider<int>((ref) {
  final sessions = ref.watch(studyProvider);
  final now = DateTime.now();
  final todaySessions = sessions.where((s) =>
      s.date.year == now.year && s.date.month == now.month && s.date.day == now.day);
  return todaySessions.fold(0, (sum, s) => sum + s.durationMinutes);
});

final todaySubjectsCountProvider = Provider<int>((ref) {
  final sessions = ref.watch(studyProvider);
  final now = DateTime.now();
  final todaySubjects = sessions
      .where((s) =>
          s.date.year == now.year && s.date.month == now.month && s.date.day == now.day)
      .map((s) => s.subject)
      .toSet();
  return todaySubjects.length;
});