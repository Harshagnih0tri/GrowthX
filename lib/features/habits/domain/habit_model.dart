class Habit {
  final int? id;
  final String title;
  final bool isDone;

  const Habit({
    this.id,
    required this.title,
    required this.isDone,
  });

  Habit copyWith({int? id, String? title, bool? isDone}) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone ? 1 : 0};
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(id: map['id'], title: map['title'], isDone: map['isDone'] == 1);
  }
}