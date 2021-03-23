import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthState {
  Initialized,
  SignedIn,
}

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  AuthState state = AuthState.SignedIn;

  AuthService() {
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        this.user = user;

        FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get()
            .then(
              (value) => changeState(AuthState.SignedIn),
            )
            .catchError((err) {
          //Ignore
        });
      }
    });
  }

  Future<UserCredential> signInAnonymously() async =>
      await auth.signInAnonymously();

  void changeState(AuthState state) {
    this.state = state;
    notifyListeners();
  }
}
