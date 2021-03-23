import 'package:frontend/src/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/household.dart';
import 'package:frontend/src/models/user.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  String householdID = "";

  void postHousehold(Household household) async {
    await _repository
        .postHousehold(household)
        .then((value) => householdID = value);
  }

  void postUser(User user) async {
    await _repository.postUser(user);
  }
}
