class User {
  String userID = "";
  String name = "";
  String householdId = "";
  int points = 0;

  User({required this.userID, required this.name, required this.householdId});

  Map toJson() => {'name': name, 'householdId': householdId};

  User.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    householdId = json["HouseholdID"];
    points = json["Points"];
    userID = json["UserID"];
  }
}
