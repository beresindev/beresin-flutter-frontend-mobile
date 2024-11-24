import 'dart:convert';

import 'package:mobile_beresin/models/subscription_model.dart';

class ServiceModel {
  // final int id;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final int userId;
  // final bool isSubscription;
  // final String nameOfService;
  // final int categoryId;
  // final String description;
  // final String status;
  // final List<String> images;
  // final String phone;

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final String nameOfService;
  final int categoryId;
  final String description;
  final String status;
  final int minPrice;
  final int maxPrice;
  final int likeCount;
  final int bookmarkCount;
  final String phone;
  final List<String> images;
  final Subscription subscription;

  ServiceModel({
    // required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.userId,
    // required this.isSubscription,
    // required this.nameOfService,
    // required this.categoryId,
    // required this.description,
    // required this.status,
    // required this.images,
    // required this.phone,

    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.nameOfService,
    required this.categoryId,
    required this.description,
    required this.status,
    required this.minPrice,
    required this.maxPrice,
    required this.likeCount,
    required this.bookmarkCount,
    required this.phone,
    required this.images,
    required this.subscription,
  });

  factory ServiceModel.fromRawJson(String str) =>
      ServiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
  //       id: json["id"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //       userId: json["user_id"],
  //       isSubscription: json["isSubscription"],
  //       nameOfService: json["name_of_service"],
  //       categoryId: json["category_id"],
  //       description: json["description"],
  //       status: json["status"],
  //       images: List<String>.from(json["images"].map((x) => x)),
  //       phone: json["phone"] ?? '',
  //     );

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        nameOfService: json["name_of_service"],
        categoryId: json["category_id"],
        description: json["description"],
        status: json["status"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        likeCount: json["like_count"],
        bookmarkCount: json["bookmark_count"],
        phone: json["phone"],
        images: List<String>.from(json["images"].map((x) => x)),
        subscription: Subscription.fromJson(json["subscription"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "created_at": createdAt.toIso8601String(),
  //       "updated_at": updatedAt.toIso8601String(),
  //       "user_id": userId,
  //       "isSubscription": isSubscription,
  //       "name_of_service": nameOfService,
  //       "category_id": categoryId,
  //       "description": description,
  //       "status": status,
  //       "images": List<dynamic>.from(images.map((x) => x)),
  //       "phone": phone,
  //     };

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "name_of_service": nameOfService,
        "category_id": categoryId,
        "description": description,
        "status": status,
        "min_price": minPrice,
        "max_price": maxPrice,
        "like_count": likeCount,
        "bookmark_count": bookmarkCount,
        "phone": phone,
        "images": List<dynamic>.from(images.map((x) => x)),
        "subscription": subscription.toJson(),
      };
}
