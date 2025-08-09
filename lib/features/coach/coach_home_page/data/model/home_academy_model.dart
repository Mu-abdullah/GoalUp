import 'package:intl/intl.dart' as intl;

import '../../../../../core/entities/academy_entity.dart';

class HomeAcademyModel extends AcademyEntity {
  HomeAcademyModel({super.name, super.logo, super.activeTo});

  factory HomeAcademyModel.fromJson(Map<String, dynamic> json) =>
      HomeAcademyModel(
        name: json['name'],
        logo: json['logo'],
        activeTo: json['active_to'],
      );

  int calcPeriod() {
    final now = DateTime.now();

    if (activeTo == null || activeTo!.isEmpty) {
      return 0;
    }

    DateTime activeToDate;
    try {
      activeToDate = DateTime.parse(activeTo!);
    } catch (e) {
      try {
        activeToDate = intl.DateFormat('yyyy-MM-dd').parse(activeTo!);
      } catch (e) {
        return 0;
      }
    }

    final diff = activeToDate.difference(now);
    return diff.inDays;
  }
}
