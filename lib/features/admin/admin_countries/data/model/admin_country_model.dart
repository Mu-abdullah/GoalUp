import '../../../../../core/entities/countries_entity.dart';

class AdminCountryModel extends CountriesEntity {
  AdminCountryModel({required super.name, required super.flag});

  factory AdminCountryModel.fromJson(Map<String, dynamic> json) {
    return AdminCountryModel(name: json['name'], flag: json['flag']);
  }
}
