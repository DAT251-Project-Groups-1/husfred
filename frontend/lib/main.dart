import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/api/storage_service.dart';
import 'package:frontend/src/app.dart';
import 'package:provider/provider.dart';

String? inviteID;

void main() {
  inviteID = Uri.base.queryParameters["id"];
  WidgetsFlutterBinding.ensureInitialized();

  /*FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  messaging.getToken(
    vapidKey:
        "BEciicoTpLTFVR2rcT1YX5h5QCZVSsW3ZBDAWaQ-WQzbr_OcF7WWV6rA0Fr4t32SECWxTa5cGr_93gFdGNxqmW8",
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });*/

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        Provider(
          create: (_) => StorageService(),
        )
      ],
      child: App(),
    ),
  );
}
