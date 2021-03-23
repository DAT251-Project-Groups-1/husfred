import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'registerScreen.dart';

class RegisterUser extends StatefulWidget {
  final String househ;
  const RegisterUser({Key? key, required this.househ}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Center(
            child: Container(
                width: 200.0,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: "Name"),
                      onSubmitted: (String value) async {},
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                        ),
                        // When the user presses the button, call on the backend to create a new
                        // user with the specified name and assigned to specified household ID
                        onPressed: () async {
                          http.post(
                            Uri.https('husfred-backend-zprwgvw7pa-ew.a.run.app',
                                'user/new'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'Name': _controller.text,
                              'HouseholdID': widget.househ,
                            }),
                          );
                          //AlertDialog(
                          // Retrieve the text the user has entered by using the
                          // TextEditingController.
                          //content: Text(widget.househ));
                        },
                        child: Text("Register"),
                      ))
                ]))));
  }
}
