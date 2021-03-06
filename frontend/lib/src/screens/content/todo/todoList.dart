import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/todo/todoTile.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, state, _) {
        return ListView.builder(
          itemCount: state.unfinishedTasks.length,
          itemBuilder: (context, i) => TodoTile(state.unfinishedTasks[i]),
        );
      },
    );
  }
}
