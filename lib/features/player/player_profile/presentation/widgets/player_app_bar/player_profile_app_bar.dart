import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'coach_app_bar_action.dart';
import 'uncoach_app_bar_action.dart';

class PlayerProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PlayerProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final acdemyid = AppUserCubit.get(context).academyId;
    var player = context.watch<PlayerProfileCubit>();
    final isCoach = player.player?.academyId == acdemyid;
    return CustomAppBar(
      title: "",
      tr: false,
      actions: [
        Padding(
          padding: AppPadding.symmetric(horizontal: 16, vertical: 0),
          child: InkWell(
            child: Icon(HugeIcons.strokeRoundedMenu01),
            onTap: () {
              debugPrint(player.player!.id);
              customShowBottomSheet(
                context: context,
                title: LangKeys.menu,
                isScrollControlled: false,
                useSafeArea: false,
                widget:
                    isCoach
                        ? CoachAppBarActions(
                          player: player.player!,
                          onRefresh:
                              () => player.getPlayerProfileById(
                                player.player!.id!,
                              ),
                        )
                        : UnCoachAppBarActions(
                          player: player,
                          onRefresh:
                              () => player.getPlayerProfileById(
                                player.player!.id!,
                              ),
                        ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Statics.appBarHeight);
}
