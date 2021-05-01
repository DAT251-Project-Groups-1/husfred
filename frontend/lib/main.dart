import 'dart:async';

import 'package:firebase_cloud_messaging_interop/firebase_cloud_messaging_interop.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/api/storage_service.dart';
import 'package:frontend/src/app.dart';
import 'package:provider/provider.dart';

String? inviteID;

Future<void> main() async {
  inviteID = Uri.base.queryParameters["id"];
  WidgetsFlutterBinding.ensureInitialized();

  /// Direct init
  final FirebaseMessagingWeb fcm = FirebaseMessagingWeb(
      publicVapidKey:
          "BEciicoTpLTFVR2rcT1YX5h5QCZVSsW3ZBDAWaQ-WQzbr_OcF7WWV6rA0Fr4t32SECWxTa5cGr_93gFdGNxqmW8");

  final bool didGivePermissions = await fcm.requestNotificationPermissions();

  if (didGivePermissions) {
    fcm.onMessage((Map? messagePayload) {
      print(messagePayload);
    });
  }

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
