import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../model/profile_btn_model.dart';

class ProfileBtnsList {
  static List<ProfileBtnModel> profileBtnsList(BuildContext context) {
    return [
      ProfileBtnModel(
        title: LangKeys.changeLanguage,
        icon: HugeIcons.strokeRoundedLanguageSquare,
        iconColor: AppColors.black,
        onTap: () {
          context.pushNamed(RoutesNames.language);
        },
      ),
      ProfileBtnModel(
        title: LangKeys.logout,
        icon: HugeIcons.strokeRoundedLogout02,
        iconColor: AppColors.red,
        titleColor: AppColors.red,
        onTap: () {
          AppUserCubit.get(context).logout().then((onValue) {
            if (context.mounted) {
              context.pushNamedAndRemoveUntil(RoutesNames.userAuthScreen);
            }
          });
        },
      ),
    ];
  }
}
