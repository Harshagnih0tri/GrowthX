class Habit {Habit copyWith({String? title, bool? isDone}) {
  return Habit(
    title: title ?? this.title,
    isDone: isDone ?? this.isDone,
  );
}
  final String title;
  final bool isDone;

  const Habit({
    required this.title,
    required this.isDone,
  });
}