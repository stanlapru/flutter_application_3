import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;

  static Future<String> uploadImage(File file) async {
    final ref = _storage.ref().child('news_images').child('${const Uuid().v4()}.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
