import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadAvatar(String householdId, String uid, File file) async {
    TaskSnapshot taskSnapshot = await storage.ref("$householdId/$uid").putFile(file);
    return taskSnapshot.ref.getDownloadURL();
  }
}