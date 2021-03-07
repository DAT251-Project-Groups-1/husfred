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
      body: ListView.builder(
        itemCount: pongs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pongs[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => pingPong()),
        tooltip: "Ping",
        child: const Icon(Icons.sports_tennis),
      ),
    );
  }
}
