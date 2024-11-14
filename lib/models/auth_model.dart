import 'package:mobile_beresin/models/user_model.dart';

class AuthModel {
  final String status;
  final String message;
  final String token;
  final UserModel user;

  AuthModel({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}
