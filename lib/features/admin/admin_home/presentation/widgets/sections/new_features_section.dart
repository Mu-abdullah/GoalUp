import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../data/repo/admin_buttons_list.dart';
import '../admin_home_custom_button.dart';
import '../admin_section.dart';

class NewFeaturesSection extends StatelessWidget {
  const NewFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    var list = AdminButtonsList.featuresButtonsList(context);
    return AdminSections(
      title: LangKeys.features,
      color: AppColors.darkBlue,
      icon: HugeIcons.strokeRoundedDashboardSquareSetting,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,

        itemBuilder: (_, i) {
          return AdminHomeCustomButton(
            top: 10,
            bottom: 10,
            item: list[i],
            vertical: 8,
          );
        },
      ),
    );
  }
}
