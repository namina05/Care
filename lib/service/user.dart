import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import '../models/userModel.dart';
import '../models/healthDetails.dart';

class userServices{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(appUser user)async {
    await _db.collection('user').doc(user.uid).set(user.toMap());
  }

Future<void> createHealthDetails(Healthdetails deets,String uid) async{
  await _db
      .collection('user')
      .doc(uid)
      .collection('health')
      .doc('profile')
      .set(deets.toMap());
}
}

