import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/language/lang_keys.dart';
import 'package:sport/core/style/custom_widgets/custom_bottom_sheet.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_icon_button.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/player_profile_model.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'player_image.dart';
import 'player_info.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.player, required this.cubit});

  final PlayerProfileModel player;
  final PlayerProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PlayerImage(player: player, cubit: cubit),
                PlayerInfo(player: player),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: Row(
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
          ),
        ),
      ],
    );
  }
}
