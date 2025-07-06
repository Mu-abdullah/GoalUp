import '../../../../../core/entities/category_enity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({super.id, super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
