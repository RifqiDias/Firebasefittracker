// To parse this JSON data, do
//
//     final ProfileModel = ProfileModelFromMap(jsonString);
// Name, gender, date of birth and height
import 'dart:convert';

ProfileModel userFromMap(String str) => ProfileModel.fromMap(json.decode(str));

String userToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel({this.name, this.gender, this.dateofbirth, this.id, this.height});

  String? name;
  int? height;
  String? gender;
  String? dateofbirth;
  String? id;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        height: json["height"],
        gender: json["gender"],
        dateofbirth: json["dateofbirth"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "gender": gender,
        "height": height,
        "dateofbirth": dateofbirth,
        "id": id,
      };
}
