class DailyStat {
  final String date;
  final String exerciseId;
  final int count;

  DailyStat({
    required this.date,
    required this.exerciseId,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'count': count,
    };
  }

  factory DailyStat.fromMap(String exerciseId, Map<String, dynamic> map) {
    return DailyStat(
      date: "",
      exerciseId: exerciseId,
      count: map['count'] ?? 0,
    );
  }
}