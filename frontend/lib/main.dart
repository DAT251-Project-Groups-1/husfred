import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/app.dart';
import 'package:provider/provider.dart';

String? inviteID;

void main() {
  inviteID = Uri.base.queryParameters["id"];
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        )
      ],
      child: App(),
    ),
  );
}
