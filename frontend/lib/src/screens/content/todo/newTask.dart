import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/models/task.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();
  final taskField = TextEditingController();
  final dateField = TextEditingController();
  bool _recurring = false;

  @override
  void dispose() {
    taskField.dispose();
    dateField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apiService = context.watch<ApiService>();

    return Container(
      height: 1000,
      child: Form(
        key: _formKey,
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: taskField,
              decoration: InputDecoration(
                labelText: "Task",
                prefixIcon: Icon(Icons.cleaning_services),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a task';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: dateField,
              decoration: InputDecoration(
                labelText: "Date",
                prefixIcon: Icon(Icons.date_range),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a date';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Row(children: [
              Text("Recurring"),
              Switch(
                value: _recurring,
                onChanged: (newValue) => setState(() => _recurring = newValue),
              ),
            ]),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                apiService.postTask(
                  Task(
                      name: taskField.text,
                      userID: "psiYjxJ0RQHatDFe9Fq7",
                      householdID: ApiService.householdID,
                      date: DateTime.now().toString(),
                      recurring: _recurring,
                      done: false),
                );
              }
            },
            child: Text("Create"),
          )
        ]),
      ),
    );
  }
}
