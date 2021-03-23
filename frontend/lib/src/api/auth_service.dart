import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  AuthService() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        this.user = user;
      }
    });
  }

  Future<UserCredential> signInAnonymously() async =>
      await auth.signInAnonymously();
}
