import 'dart:convert';

class Task {
  String taskID = "";
  String name = "";
  String userID = "";
  String householdID = "";
  DateTime? date;
  bool recurring = false;
  bool done = false;
  List<String> votes = [];
  int points = 0;

  Task(
      {required this.name,
      required this.householdID,
      required this.date,
      required this.done,
      required this.points,
      required this.votes});

  Map toJson() => {
        'taskID': taskID,
        'name': name,
        'userID': userID,
        'householdID': householdID,
        'date': date?.millisecondsSinceEpoch ?? 0,
        'done': done,
        'votes': votes,
        'points': points
      };

  Task.fromJson(Map<String, dynamic> json) {
    taskID = json["TaskID"];
    name = json["Name"];
    userID = json["UserID"];
    householdID = json["HouseholdID"];
    date = DateTime.fromMillisecondsSinceEpoch(json["Date"]);
    done = json["Done"];
    votes = json["Votes"] != null ? List.from(json["Votes"]) : [];
    points = json['Points'];
  }
}
