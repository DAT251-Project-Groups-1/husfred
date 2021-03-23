import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/screens/home.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Husfred',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) {
          return FutureBuilder<FirebaseApp>(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (!snapshot.hasData) return Loading();
              return FutureBuilder<UserCredential>(
                future: context.watch<AuthService>().signInAnonymously(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());
                  if (!snapshot.hasData) return Loading();
                  return Home();
                },
              );
            },
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
