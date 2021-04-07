import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Husfred"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthService>().changeState(AuthState.Create);
                },
                child: Text("Create household"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthService>().changeState(AuthState.Join);
                },
                child: Text("Join household"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
