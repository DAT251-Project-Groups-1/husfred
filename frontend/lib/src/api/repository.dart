import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/task.dart';
import 'package:frontend/src/models/user.dart';
import 'package:http/http.dart' as http;

const API_URL = String.fromEnvironment('API_URL',
    defaultValue: 'husfred-backend-zprwgvw7pa-ew.a.run.app');

final fa.FirebaseAuth auth = fa.FirebaseAuth.instance;

class Repository {
  Future<String> postHousehold(Household household) async {
    var res = await http.post(
      Uri.https('$API_URL', '/household/new'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(household),
    );

    return json.decode(res.body);
  }

  Future<String> postTask(Task task) async {
    var res = await http.post(
      Uri.https('$API_URL', '/task/new'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(task),
    );

    return json.decode(res.body);
  }

  Future<String> postUser(User user) async {
    fa.IdTokenResult idTokenResult =
        await auth.currentUser!.getIdTokenResult(true);
    var res = await http.post(Uri.https('$API_URL', 'user/new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${idTokenResult.token}'
        },
        body: json.encode(user));

    return json.decode(res.body);
  }

  Future<List<Task>> getTasks(String householdID, bool done) async {
    var res = await http.get(Uri.https('$API_URL', 'task/$householdID'));

    return (json.decode(res.body) as List)
        .map((p) => Task.fromJson(p))
        .toList();
  }

  Future<List<User>> getLeaderboard(String householdID) async {
    fa.IdTokenResult idTokenResult = await auth.currentUser!.getIdTokenResult();
    var res = await http.get(
      Uri.https('$API_URL', 'user/household/$householdID'),
      headers: <String, String>{
        'Authorization': 'Bearer ${idTokenResult.token}'
      },
    );

    return (json.decode(res.body) as List)
        .map((p) => User.fromJson(p))
        .toList();
  }
}
