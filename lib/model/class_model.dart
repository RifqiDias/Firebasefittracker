// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({this.weight, this.born, this.id});

  int? weight;
  int? born;
  String? id;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        weight: json["weight"],
        born: json["born"],
      );

  Map<String, dynamic> toMap() => {
        "weight": weight,
        "born": born,
        "id": id,
      };
}
