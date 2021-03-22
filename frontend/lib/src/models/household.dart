class Household {
  String name = "";

  Household({required this.name});

  Map toJson() => {'name': name};

  Household.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}
