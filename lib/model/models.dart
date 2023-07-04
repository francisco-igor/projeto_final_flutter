class User {
  String name;
  int number;
  double location;

  User(this.name, this.number, this.location);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'location': location,
    };
  }
}
