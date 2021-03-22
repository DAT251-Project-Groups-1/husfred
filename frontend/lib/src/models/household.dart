class Household {
  String name;

  Household({required this.name});

  Map toJson() => {'name': name};
}
