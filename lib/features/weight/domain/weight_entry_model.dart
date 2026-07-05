class WeightEntry {
  final int? id;
  final double weightKg;
  final DateTime date;

  const WeightEntry({
    this.id,
    required this.weightKg,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'weightKg': weightKg,
      'date': date.toIso8601String(),
    };
  }

  factory WeightEntry.fromMap(Map<String, dynamic> map) {
    return WeightEntry(
      id: map['id'],
      weightKg: map['weightKg'],
      date: DateTime.parse(map['date']),
    );
  }
}