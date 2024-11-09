class Service {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final bool isSubscription;
  final String nameOfService;
  final int categoryId;
  final String description;
  final String status;

  Service({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.isSubscription,
    required this.nameOfService,
    required this.categoryId,
    required this.description,
    required this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        isSubscription: json["isSubscription"],
        nameOfService: json["name_of_service"],
        categoryId: json["category_id"],
        description: json["description"],
        status: json["status"],
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
      };
}
