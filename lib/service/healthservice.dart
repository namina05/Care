import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/healthdetails.dart';

class HealthService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveHealth(Healthdetails health) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db
        .collection("user")
        .doc(uid)
        .collection("health")
        .doc("profile")
        .set(health.toMap());
  }

  Future<Healthdetails?> getHealth() async {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  final doc = await FirebaseFirestore.instance
      .collection("user")
      .doc(uid)
      .collection("health")
      .doc("profile")
      .get();

  if (!doc.exists) return null;

  return Healthdetails.fromMap(doc.data()!);
}

}