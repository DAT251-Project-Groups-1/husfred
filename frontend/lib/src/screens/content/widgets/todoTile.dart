import 'package:flutter/material.dart';
import 'package:frontend/src/models/task.dart';

class TodoTile extends StatelessWidget {
  final Task task;
  TodoTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dismissible(
        key: Key(task.name),
        onDismissed: (direction) {
          //Mark task as done in db
        },
        background: Container(color: Colors.red),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(task.name),
            subtitle: Text(task.date),
          ),
        ),
      ),
    );
  }
}
