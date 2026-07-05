class StudySession {
  final int? id;
  final String subject;
  final int durationMinutes;
  final DateTime date;

  const StudySession({
    this.id,
    required this.subject,
    required this.durationMinutes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'durationMinutes': durationMinutes,
      'date': date.toIso8601String(),
    };
  }

  factory StudySession.fromMap(Map<String, dynamic> map) {
    return StudySession(
      id: map['id'],
      subject: map['subject'],
      durationMinutes: map['durationMinutes'],
      date: DateTime.parse(map['date']),
    );
  }
}