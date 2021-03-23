class User {
  String name = "";
  String householdId = "";

  User({required this.name, required this.householdId});

  Map toJson() => {'name': name, 'householdId': householdId};

  User.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    householdId = json["householdId"];
  }
}
