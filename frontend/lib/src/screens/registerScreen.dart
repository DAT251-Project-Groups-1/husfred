import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/screens/main.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Navigation();
            }));
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
