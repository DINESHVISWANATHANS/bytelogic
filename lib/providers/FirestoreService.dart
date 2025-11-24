import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid) async {
    await _db.collection("users").doc(uid).set({
      "counter": 0,
      "createdAt": Timestamp.now(),
    });
  }

  Future<int> getUserCounter(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return (doc.data()?["counter"] ?? 0) as int;
  }

  Future<void> updateUserCounter(String uid, int counter) async {
    await _db.collection("users").doc(uid).update({"counter": counter});
  }
}
