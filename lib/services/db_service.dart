import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserData(String userId, String name, String surname, int age) async {
  await FirebaseFirestore.instance.collection('users').doc(userId).set({
    'name': name,
    'surname': surname,
    'age': age,
  });
}

Stream<DocumentSnapshot> getUserData(String userId) {
  return FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
}
