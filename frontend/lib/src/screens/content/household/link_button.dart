import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: Text('Copy invite link'),
        onPressed: () async {},
      ),
    );
  }
}
