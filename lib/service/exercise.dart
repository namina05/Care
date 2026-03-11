import 'package:care/models/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class exerciseServices{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future <void> createExercise(Exercise ex)async{
    await _db.collection('exercise').doc(ex.id).set(ex.toMap());
  }

  Future <void> deleteExercise(Exercise ex) async{
    await _db.collection('exercise').doc(ex.id).delete();
  }

  Stream<QuerySnapshot> getExercises(){
    return _db.collection('exercise').snapshots();
  }

  Future <void> selectExercise(String uid,String exerciseId)async{
    await _db.collection('user').doc(uid).collection('myExercises').doc(exerciseId).set({'timeAdded': Timestamp.now()});
  }

  Future <void> removeExercise(String uid,String exerciseId)async{
    await _db.collection('user').doc(uid).collection('myExercises').doc(exerciseId).delete();
  }

  Future<DocumentSnapshot> getExerciseName(String eid)async{
    return _db.collection('exercise').doc(eid).get();
  }

  Future <void> incrementDailyCounter(String uid,String exerciseid , String date)async{
    final ref = _db.collection('user').doc(uid).collection('myExercises').doc(exerciseid).collection('dailyStats').doc(date);

    final doc = await ref.get();
    if(doc.exists){
      await ref.update({'count' : FieldValue.increment(1)});
    }
    else{
      await ref.set({'count' : 1});
    }
  }
}
