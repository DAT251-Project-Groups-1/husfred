class Task {
  String taskID = "";
  String name = "";
  String userID = "";
  String householdID = "";
  DateTime? date;
  bool recurring = false;
  bool done = false;
  int points = 0;

  Task(
      {required this.name,
      required this.householdID,
      required this.date,
      required this.done,
      required this.points});

  Map toJson() => {
        'taskID': taskID,
        'name': name,
        'userID': userID,
        'householdID': householdID,
        'date': date?.millisecondsSinceEpoch ?? 0,
        'recurring': recurring,
        'done': done,
        'points': points
      };

  Task.fromJson(Map<String, dynamic> json) {
    taskID = json["TaskID"];
    name = json["Name"];
    userID = json["UserID"];
    householdID = json["HouseholdID"];
    date = DateTime.fromMillisecondsSinceEpoch(json["Date"]);
    recurring = json["Recurring"];
    done = json["Done"];
    points = json['Points'];
  }
}
