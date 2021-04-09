import 'package:frontend/src/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/task.dart';
import 'package:frontend/src/models/user.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  static String householdID = "";

  List<Task> _unfinishedTasks = [];
  /*Task(
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
  ];*/

  List<Task> _completedTasks = [];
  /*Task(
        name: "CompletedTask1",
        userID: "userID",
        householdID: "householdID",
        date: "12.02.21",
        recurring: true,
        done: false),
    Task(
        name: "CompletedTask2",
        userID: "userID",
        householdID: "householdID",
        date: "12.02.21",
        recurring: true,
        done: false),
  ];*/

  List<User> _users = [];

  List<Task> get unfinishedTasks => _unfinishedTasks;
  List<User> get users => _users;
  List<Task> get completedTasks => _completedTasks;

  Future<String> postHousehold(Household household) async {
    var result = await _repository.postHousehold(household);
    householdID = result;
    return result;
  }

  void postUser(User user) async {
    householdID = user.householdId;
    print('hhID: ' + householdID);
    await _repository.postUser(user);
  }

  void postTask(Task task) async {
    await _repository.postTask(task);
    _unfinishedTasks.add(task);
    notifyListeners();
  }

  void finishTask(Task task) async {
    await _repository.finishTask(task);
    _completedTasks.add(task);
    _unfinishedTasks.remove(task);
    notifyListeners();
  }

  getTasks(bool done) async {
    var tasks = await _repository.getTasks(householdID, done);
    if (done) {
      _completedTasks = tasks;
    } else {
      _unfinishedTasks = tasks;
    }

    notifyListeners();
  }

  getLeaderboard() async {
    var users = await _repository.getLeaderboard(householdID);
    _users = users;

    notifyListeners();
  }
}
