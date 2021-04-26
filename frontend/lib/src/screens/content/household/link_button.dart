import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';

class LinkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: Text('Copy invite link'),
        onPressed: () {
          Uri parse = Uri.parse("https://husfred-b5e27.web.app?id=${ApiService.householdID}#/");
          FlutterClipboard.copy(parse.toString())
              .then((value) => print(parse.toString()));
        },
      ),
    );
  }
}
