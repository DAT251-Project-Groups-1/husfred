import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadAvatar(
      String householdId, String uid, Uint8List file, String name) async {
    await storage.ref("$householdId/$uid/$name").putData(file);
  }

  Future<String?> getAvatar(String householdId, String uid) async {
    ListResult listResult = await storage.ref("$householdId/$uid").list(ListOptions(maxResults: 1));
    return await listResult.items.first.getDownloadURL();
  }
}
