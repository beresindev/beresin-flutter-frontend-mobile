import 'package:mobile_beresin/models/service.dart';

class ServiceModel {
  final String status;
  final Service service;
  final List<dynamic> images;

  ServiceModel({
    required this.status,
    required this.service,
    required this.images,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        status: json["status"],
        service: Service.fromJson(json["service"]),
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "service": service.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
