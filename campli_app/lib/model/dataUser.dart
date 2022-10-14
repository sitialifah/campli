// To parse this JSON data, do
//
//     final dataUser = dataUserFromJson(jsonString);

import 'dart:convert';

List<DataUser> dataUserFromJson(String str) =>
    List<DataUser>.from(json.decode(str).map((x) => DataUser.fromJson(x)));

String dataUserToJson(List<DataUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataUser {
  DataUser({
    this.email,
    this.id,
    this.noHp,
  });

  String email;
  int id;
  String noHp;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        email: json["email"],
        id: json["id"],
        noHp: json["no_hp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "no_hp": noHp,
      };
}
