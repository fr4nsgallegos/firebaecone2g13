class UserModel {
  String name;
  String lastname;
  int age;
  double weight;
  String nationality;

  UserModel({
    required this.name,
    required this.lastname,
    required this.age,
    required this.weight,
    required this.nationality,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      lastname: map['lastname'] ?? '',
      age: map['age']?.toInt() ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      nationality: map['nationality'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastname": lastname,
      "age": age,
      "weight": weight,
      "nationality": nationality,
    };
  }
}
