import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/feed/feedTile.dart';
import 'package:provider/provider.dart';

class FeedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, state, _) {
        return ListView.builder(
          itemCount: state.completedTasks.length,
          itemBuilder: (context, i) => FeedTile(state.completedTasks[i]),
        );
      },
    );
  }
}
