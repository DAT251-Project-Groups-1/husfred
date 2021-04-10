import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/todo/newTask.dart';
import 'package:frontend/src/screens/content/todo/progress_ring.dart';
import 'package:frontend/src/screens/content/todo/todoList.dart';
import 'package:provider/provider.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  void initState() {
    super.initState();
    context.read<ApiService>().getTasks(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return NewTask();
            },
          );
        },
      ),
      body: Column(
        children: [
          ProgressRing(
            progress: 0.8,
          ),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
