class Workout {
  final int? id;
  final String exercise;
  final int sets;
  final int reps;
  final int caloriesBurned;
  final DateTime date;

  const Workout({
    this.id,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.caloriesBurned,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'caloriesBurned': caloriesBurned,
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      exercise: map['exercise'],
      sets: map['sets'],
      reps: map['reps'],
      caloriesBurned: map['caloriesBurned'],
      date: DateTime.parse(map['date']),
    );
  }
}