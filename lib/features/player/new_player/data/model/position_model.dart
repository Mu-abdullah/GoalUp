import '../../../../../core/entities/position_entity.dart';

class PositionModel extends PositionEntity {
  PositionModel({required super.code, required super.name});

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      PositionModel(code: json['code'], name: json['name']);
}
