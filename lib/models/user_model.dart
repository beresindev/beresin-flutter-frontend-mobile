class UserModel {
  final int id;
  final String username;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "role": role,
      };
}