import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/screens/registerScreen.dart';

class JoinHousehold extends StatefulWidget {
  const JoinHousehold({Key? key}) : super(key: key);

  @override
  _JoinHouseholdState createState() => _JoinHouseholdState();
}

class _JoinHouseholdState extends State<JoinHousehold> {
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
        title: Text("Join Household"),
      ),
      body: Center(
        child: Container(
          width: 200.0,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Household ID"),
                  onSubmitted: (String value) async {},
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: ElevatedButton(
                    // When the user presses the button, show an alert dialog containing the
                    // text that the user has entered into the text field.
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterUser(
                              househ: _controller.text,
                            ),
                          ));
                    },
                    child: Text("Join"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
