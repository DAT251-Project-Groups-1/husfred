import 'dart:convert';
import 'package:frontend/src/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/models/household.dart';

const API_URL = String.fromEnvironment('API_URL',
    defaultValue: 'husfred-backend-zprwgvw7pa-ew.a.run.app');

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
}
