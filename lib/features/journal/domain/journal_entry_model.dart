class JournalEntry {
  final int? id;
  final String title;
  final String content;
  final String mood;
  final DateTime date;

  const JournalEntry({
    this.id,
    required this.title,
    required this.content,
    required this.mood,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'mood': mood,
      'date': date.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      mood: map['mood'],
      date: DateTime.parse(map['date']),
    );
  }
}