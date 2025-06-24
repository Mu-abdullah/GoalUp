import '../../../../../core/entities/academy_entity.dart';

class HomeAcademyModel extends AcademyEntity {
  HomeAcademyModel({super.name, super.logo});

  factory HomeAcademyModel.fromJson(Map<String, dynamic> json) =>
      HomeAcademyModel(name: json['name'], logo: json['logo']);
}
