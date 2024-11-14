import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String phone;
  final String role;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
      };
}
