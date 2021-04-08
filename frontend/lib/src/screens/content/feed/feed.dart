import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/feed/feedList.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
      ),
      body: FutureBuilder(
        future: context.read<ApiService>().getTasks(true),
        builder: (context, snapshot) {
          return FeedList();
        },
      ),
    );
  }
}
