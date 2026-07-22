class Habit {
  final String? id;
  final String title;
  final bool isDone;

  const Habit({
    this.id,
    required this.title,
    required this.isDone,
  });

  Habit copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json["id"]?.toString(),
      title: json["title"] ?? "",
      isDone: json["is_done"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "is_done": isDone,
    };
  }
}