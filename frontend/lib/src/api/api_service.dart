import 'package:flutter/material.dart';
import 'package:frontend/src/api/repository.dart';
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/task.dart';
import 'package:frontend/src/models/user.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  static String householdID = "";

  List<Task> _unfinishedTasks = [];

  List<Task> _completedTasks = [];

  List<User> _users = [];

  List<Task> get unfinishedTasks => _unfinishedTasks;

  List<User> get users => _users;

  List<Task> get completedTasks => _completedTasks;

  double get taskProgress {
    if (_completedTasks.isEmpty && _unfinishedTasks.isEmpty) {
      return 0;
    }
    return _completedTasks.length /
        (_completedTasks.length + _unfinishedTasks.length);
  }

  Future<String> postHousehold(Household household) async {
    var result = await _repository.postHousehold(household);
    householdID = result;
    return result;
  }

  void postUser(User user) async {
    householdID = user.householdId;
    await _repository.postUser(user);
  }

  void deleteUser() async {
    await _repository.deleteUser();
  }

  void postTask(Task task) async {
    var taskID = await _repository.postTask(task);
    task.taskID = taskID;
    notifyListeners();
  }

  void finishTask(Task task) async {
    await _repository.finishTask(task);
    _completedTasks.add(task);
    _unfinishedTasks.remove(task);
    notifyListeners();
  }

  void voteTask(Task task) async {
    await _repository.voteTask(task);
    notifyListeners();
  }

  getTasks(bool done, [DateTime? from, DateTime? to]) async {
    var tasks = await _repository.getTasks(householdID, done, from, to);
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
