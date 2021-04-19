import 'package:date_field/date_field.dart';
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
  final pointsField = TextEditingController();
  DateTime dateTime = DateTime.now();
  //bool _recurring = false;

  @override
  void dispose() {
    taskField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apiService = context.read<ApiService>();

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
            child: DateTimeFormField(
              decoration: InputDecoration(
                labelText: "Date",
                prefixIcon: Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null ? "Please provide date" : null,
              onDateSelected: (DateTime date) {
                setState(() {
                  dateTime = date;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: pointsField,
              decoration: InputDecoration(
                labelText: "Points",
                prefixIcon: Icon(Icons.star_border_rounded),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please some points';
                }
                return null;
              },
            ),
          ),
          /*Container(
            margin: EdgeInsets.all(20.0),
            child: Row(children: [
              Text("Recurring"),
              Switch(
                value: _recurring,
                onChanged: (newValue) => setState(() => _recurring = newValue),
              ),
            ]),
          ),*/
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                apiService.postTask(
                  Task(
                      name: taskField.text,
                      householdID: ApiService.householdID,
                      date: dateTime,
                      done: false,
                      points: int.parse(pointsField.text),
                      votes: []),
                );
                Navigator.pop(context);
              }
            },
            child: Text("Create"),
          )
        ]),
      ),
    );
  }
}
