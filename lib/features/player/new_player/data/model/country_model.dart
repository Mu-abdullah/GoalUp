import '../../../../../core/entities/countries_entity.dart';

class CountryModel extends CountriesEntity {
  CountryModel({required super.name, required super.flag});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(name: json['name'], flag: json['flag']);
  }
}
