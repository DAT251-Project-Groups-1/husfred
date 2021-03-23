import 'package:frontend/src/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/user.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  String householdID = "";

  Future<String> postHousehold(Household household) async {
    var result = await _repository.postHousehold(household);
    householdID = result;
    return result;
  }

  void postUser(User user) async {
    await _repository.postUser(user);
  }
}
