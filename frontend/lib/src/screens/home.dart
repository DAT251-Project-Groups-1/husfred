import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pongs = [];

  pingPong() {
    http
        .read(Uri.parse('https://husfred-backend-zprwgvw7pa-ew.a.run.app/ping'))
        .then((value) => pongs.add(value));
  }

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
                onPressed: null,
                child: Text("Create household"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: ElevatedButton(
                onPressed: null,
                child: Text("Join household"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
