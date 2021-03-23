class Task {
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
        'name': name,
        'userID': userID,
        'householdID': householdID,
        'date': date,
        'recurring': recurring,
        'done': done
      };
}
