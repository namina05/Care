

class Exercise {
  final String id;
  final String name;
  final String description;
  final int recommendedReps;
  final int recommendedSets;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.recommendedReps,
    required this.recommendedSets,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'recommendedReps': recommendedReps,
      'recommendedSets' : recommendedSets,
    };
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      description: map['description'],
      recommendedReps: map['recommendedReps'],
      recommendedSets: map['recommendedSets'],
    );
  }
}