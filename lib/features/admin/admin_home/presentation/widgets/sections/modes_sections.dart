import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/style/color/app_color.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../data/repo/admin_buttons_list.dart';
import '../admin_home_custom_button.dart';
import '../admin_section.dart';

class ModesSection extends StatelessWidget {
  const ModesSection({super.key});

  @override
  Widget build(BuildContext context) {
    var list = AdminButtonsList.modesButtonsList(context);
    return AdminSections(
      title: LangKeys.modes,
      color: AppColors.grey,
      icon: HugeIcons.strokeRoundedDashboardSquareSetting,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 13 / 9,
        ),
        itemBuilder: (_, i) {
          return AdminHomeCustomButton(top: null, bottom: 10, item: list[i]);
        },
      ),
    );
  }
}
