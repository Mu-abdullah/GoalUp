import '../../../../../core/entities/criteria_entity.dart';

class CriteriaModel extends CriteriaEntity {
  CriteriaModel({
    super.id,
    super.category,
    super.name,
    super.average,
    super.max,
  });

  factory CriteriaModel.fromJson(Map<String, dynamic> json) {
    return CriteriaModel(
      id: json['id'],
      category: json['category']['id'],
      name: json['name'],
      average: json['average'],
      max: json['max'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'average': average,
    'max': max,
    'category': category,
  };
}
