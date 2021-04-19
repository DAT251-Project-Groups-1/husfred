import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/api/api_service.dart';

enum AuthState {
  UnInitialized,
  Initialized,
  Join,
  Create,
  Register,
  SignedIn,
}

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  AuthState state = AuthState.UnInitialized;

  AuthService() {
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        this.user = user;

        FirebaseFirestore.instance.collection('user').doc(user.uid).get().then(
          (DocumentSnapshot doc) {
            if (doc.exists) {
              ApiService.householdID = doc.data()?["HouseholdID"];
              changeState(AuthState.SignedIn);
            } else if (inviteID != null) {
              ApiService.householdID = inviteID ?? "";
              changeState(AuthState.Register);
            } else {
              changeState(AuthState.Initialized);
            }
          },
        ).catchError((err) {
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
