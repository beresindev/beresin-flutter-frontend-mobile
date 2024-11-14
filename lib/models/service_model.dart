import 'package:meta/meta.dart';
import 'dart:convert';

class ServiceModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final bool isSubscription;
  final String nameOfService;
  final int categoryId;
  final String description;
  final String status;
  final List<String> images;
  final String phone;

  ServiceModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.isSubscription,
    required this.nameOfService,
    required this.categoryId,
    required this.description,
    required this.status,
    required this.images,
    required this.phone,
  });

  factory ServiceModel.fromRawJson(String str) =>
      ServiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        isSubscription: json["isSubscription"],
        nameOfService: json["name_of_service"],
        categoryId: json["category_id"],
        description: json["description"],
        status: json["status"],
        images: List<String>.from(json["images"].map((x) => x)),
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "isSubscription": isSubscription,
        "name_of_service": nameOfService,
        "category_id": categoryId,
        "description": description,
        "status": status,
        "images": List<dynamic>.from(images.map((x) => x)),
        "phone": phone,
      };
}
