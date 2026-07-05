class WaterEntry {
  final int? id;
  final int amountMl;
  final DateTime date;

  const WaterEntry({
    this.id,
    required this.amountMl,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'amountMl': amountMl,
      'date': date.toIso8601String(),
    };
  }

  factory WaterEntry.fromMap(Map<String, dynamic> map) {
    return WaterEntry(
      id: map['id'],
      amountMl: map['amountMl'],
      date: DateTime.parse(map['date']),
    );
  }
}