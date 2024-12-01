class SubscriptionModel {
  final bool isSubscription;
  final String boostName;
  // final int duration;
  final DateTime? expiredAt;

  SubscriptionModel({
    required this.isSubscription,
    required this.boostName,
    // required this.duration,
    required this.expiredAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        isSubscription: json["isSubscription"],
        boostName: json["boost_name"],
        // duration: json["duration"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
      );

  Map<String, dynamic> toJson() => {
        "isSubscription": isSubscription,
        "boost_name": boostName,
        // "duration": duration,
        "expired_at": expiredAt?.toIso8601String(),
      };
}
