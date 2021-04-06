import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/widgets/todoList.dart';
import 'package:provider/provider.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Household"),
      ),
      body: TodoList(),
    );
  }
}
