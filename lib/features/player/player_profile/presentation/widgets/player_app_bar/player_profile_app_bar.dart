import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/custom_widgets/custom_icon_button.dart';
import '../../../data/model/player_profile_model.dart';
import 'app_bar_action.dart';

class PlayerProfileAppBar extends StatelessWidget {
  const PlayerProfileAppBar({super.key, required this.player});
  final PlayerProfileModel player;
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
            debugPrint(player.id);
            customShowBottomSheet(
              context: context,
              title: LangKeys.menu,
              isScrollControlled: false,
              useSafeArea: false,
              widget: AppBarActions(player: player),
            );
          },
        ),
      ],
    );
  }
}
