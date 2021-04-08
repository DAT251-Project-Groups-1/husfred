import 'package:flutter/material.dart';
import 'package:frontend/src/models/task.dart';

class FeedTile extends StatelessWidget {
  final Task task;

  FeedTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(task.name),
          leading: Icon(Icons.account_circle),
          trailing: Icon(Icons.thumbs_up_down)),
    );
  }
}
