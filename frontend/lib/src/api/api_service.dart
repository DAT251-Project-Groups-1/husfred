import 'package:frontend/src/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/task.dart';
import 'package:frontend/src/models/user.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  String householdID = "";

  List<Task> _tasks = [
    Task(
        name: "Task1",
        userID: "userID",
        householdID: "householdID",
        date: "12.02.21",
        recurring: true,
        done: false),
    Task(
        name: "Task2",
        userID: "userID",
        householdID: "householdID",
        date: "12.02.21",
        recurring: true,
        done: false),
    Task(
        name: "Task3",
        userID: "userID",
        householdID: "householdID",
        date: "12.02.21",
        recurring: true,
        done: false)
  ];

  List<Task> get tasks => _tasks;

  Future<String> postHousehold(Household household) async {
    var result = await _repository.postHousehold(household);
    householdID = result;
    return result;
  }

  void postUser(User user) async {
    await _repository.postUser(user);
  }

  void postTask(Task task) => _repository.postTask(task);
}
