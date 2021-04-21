class User {
  String name = "";
  String householdId = "";
  int points = 0;
  String storageUrl = "";

  User({required this.name, required this.householdId, required this.storageUrl});

  Map toJson() => {'name': name, 'householdId': householdId};

  User.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    householdId = json["HouseholdID"];
    points = json["Points"];
    points = json["StorageUrl"];
  }
}
