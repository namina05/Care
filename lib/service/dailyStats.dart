import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyStatsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateStatsCount(String exerciseId, int count) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final time = DateTime.now().toIso8601String().substring(0, 10);

    await _db
    .collection('user')
    .doc(uid)
    .collection('dailystats')
    .doc(time)
    .collection("exercise")
    .doc(exerciseId)
    .set({
      "count": count
    }, SetOptions(merge: true));
  }
  Future<int> getTodayStats(String exerciseId) async {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final time = DateTime.now().toIso8601String().substring(0,10);

  final doc = await _db
      .collection('user')
      .doc(uid)
      .collection('dailystats')
      .doc(time)
      .collection("exercise")
      .doc(exerciseId)
      .get();

  if (!doc.exists) return 0;

  return doc.data()?['count'] ?? 0;
}
}