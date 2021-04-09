class Task {
  String taskID = "";
  String name = "";
  String userID = "";
  String householdID = "";
  String date = "";
  bool recurring = false;
  bool done = false;

  Task(
      {required this.name,
      required this.userID,
      required this.householdID,
      required this.date,
      required this.recurring,
      required this.done});

  Map toJson() => {
        'taskID': taskID,
        'name': name,
        'userID': userID,
        'householdID': householdID,
        'date': date,
        'recurring': recurring,
        'done': done
      };

  Task.fromJson(Map<String, dynamic> json) {
    taskID = json["TaskID"];
    name = json["Name"];
    userID = json["UserID"];
    householdID = json["HouseholdID"];
    date = json["Date"];
    recurring = json["Recurring"];
    done = json["Done"];
  }
}
