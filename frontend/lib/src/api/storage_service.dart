import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadAvatar(
      String householdId, String uid, Uint8List fileAsBytes) async {
    await storage.ref("$householdId/$uid").putData(fileAsBytes);
  }

  Future<String?> getAvatar(String householdId, String uid) async {
    return await storage.ref("$householdId/$uid").getDownloadURL();
  }
}
