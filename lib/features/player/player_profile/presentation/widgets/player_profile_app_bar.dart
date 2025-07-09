import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../core/style/custom_widgets/custom_icon_button.dart';
import '../../../../../core/style/widgets/app_text.dart';

class PlayerProfileAppBar extends StatelessWidget {
  const PlayerProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(),
        CustomIconButton(
          iconColor: AppColors.black,
          backgroundColor: AppColors.white,
          icon: HugeIcons.strokeRoundedMenu04,
          onTap: () {
            customShowBottomSheet(
              context: context,
              title: LangKeys.menu,
              isScrollControlled: false,
              useSafeArea: false,
              widget: Column(
                children: [
                  ListTile(
                    leading: Icon(HugeIcons.strokeRoundedStar),
                    title: AppText(LangKeys.ratings, isBold: true),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.pushNamed(RoutesNames.playerRatingScreen);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
