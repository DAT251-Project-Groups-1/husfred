import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/models/task.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatelessWidget {
  final Task task;

  TodoTile(this.task);

  @override
  Widget build(BuildContext context) {
    var apiService = context.read<ApiService>();

    return Container(
      child: Dismissible(
        key: Key(task.name),
        onDismissed: (direction) {
          apiService.finishTask(task);
        },
        background: Container(color: Colors.green),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(task.name),
            subtitle: Text(task.date.toString()),
          ),
        ),
      ),
    );
  }
}
