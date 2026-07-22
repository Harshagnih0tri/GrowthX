class Habit {
  final String id;
  final String name;
  final String? description;
  final String frequency;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Habit({
    required this.id,
    required this.name,
    this.description,
    required this.frequency,
    required this.createdAt,
    required this.updatedAt,
  });

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    String? frequency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      description: json["description"],
      frequency: json["frequency"] ?? "daily",
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  /// Full shape, matching HabitRead — not used for create/update requests.
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "frequency": frequency,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  /// Matches backend's HabitCreate schema — only what the server expects on create.
  Map<String, dynamic> toCreateJson() {
    return {
      "name": name,
      "description": description,
      "frequency": frequency,
    };
  }
}