import 'dart:convert';

class CategoryModel {
  final int id;
  final String nameOfCategory;

  CategoryModel({
    required this.id,
    required this.nameOfCategory,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        nameOfCategory: json["name_of_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_category": nameOfCategory,
      };

  static List<CategoryModel> getDummyCategories() {
    return [
      CategoryModel(id: 1, nameOfCategory: "Technology"),
      CategoryModel(id: 2, nameOfCategory: "Household"),
      CategoryModel(id: 3, nameOfCategory: "Uncategorized"),
    ];
  }
}
