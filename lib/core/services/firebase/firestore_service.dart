import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  CollectionReference get users => _firestore.collection('users');
  CollectionReference get orchids => _firestore.collection('orchids');
  CollectionReference get scans => _firestore.collection('scans');

  Future<DocumentSnapshot> getUser(String userId) {
    return users.doc(userId).get();
  }

  Future<void> setUser(String userId, Map<String, dynamic> data) {
    return users.doc(userId).set(data);
  }

  Future<DocumentSnapshot> getOrchid(String orchidId) {
    return orchids.doc(orchidId).get();
  }

  Future<void> addOrchid(Map<String, dynamic> data) {
    return orchids.add(data);
  }

  Future<void> addScan(Map<String, dynamic> data) {
    return scans.add(data);
  }
}
