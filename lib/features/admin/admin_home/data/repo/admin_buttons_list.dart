import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../model/admin_section_model.dart';

class AdminButtonsList {
  static List<AdminSectionModel> modesButtonsList(BuildContext context) => [];

  static List<AdminSectionModel> settingsButtonsList(BuildContext context) => [
    AdminSectionModel(
      title: LangKeys.changeLanguage,
      icon: HugeIcons.strokeRoundedLanguageSquare,
      backgroundColor: AppColors.black,
      titleColor: AppColors.white,
      onTap: () {
        context.pushNamed(RoutesNames.language);
      },
    ),
  ];
  static List<AdminSectionModel> featuresButtonsList(BuildContext context) => [
    AdminSectionModel(
      title: LangKeys.country,
      icon: HugeIcons.strokeRoundedEarth,
      backgroundColor: AppColors.darkBlue,
      titleColor: AppColors.white,
      onTap: () {
        context.pushNamed(RoutesNames.adminCountries);
      },
    ),
    AdminSectionModel(
      title: LangKeys.academy,
      icon: HugeIcons.strokeRoundedSchool01,
      backgroundColor: AppColors.blueAccent,
      titleColor: AppColors.white,
      onTap: () {
        context.pushNamed(RoutesNames.adminAcademies);
      },
    ),
  ];
}
