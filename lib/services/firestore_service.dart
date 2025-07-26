import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createUserDocument(User user) async {
    await _db.collection('users').doc(user.uid).set({
      'email': user.email,
      'uid': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> addNews(Map<String, dynamic> data) async {
    await _db.collection('news').add(data);
  }

  static Stream<QuerySnapshot> getNews() {
    return _db.collection('news').orderBy('createdAt', descending: true).snapshots();
  }

  static Future<void> deleteNews(String docId) async {
    await _db.collection('news').doc(docId).delete();
  }
}
