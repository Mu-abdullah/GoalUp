import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'coach_app_bar_action.dart';
import 'uncoach_app_bar_action.dart';

class CoachesAppBar extends StatelessWidget {
  const CoachesAppBar({
    super.key,
    required this.player,
    required this.isCoach,
    required this.playerCubit,
  });

  final PlayerProfileModel? player;
  final bool isCoach;
  final PlayerProfileCubit playerCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(horizontal: 16, vertical: 0),
      child: InkWell(
        child: Icon(HugeIcons.strokeRoundedMenu01),
        onTap: () {
          debugPrint(player!.id!);
          customShowBottomSheet(
            context: context,
            title: LangKeys.menu,
            isScrollControlled: false,
            useSafeArea: false,
            widget:
                isCoach
                    ? CoachAppBarActions(
                      player: player!,
                      onRefresh:
                          () => playerCubit.getPlayerProfileById(player!.id!),
                    )
                    : UnCoachAppBarActions(
                      player: playerCubit,
                      onRefresh:
                          () => playerCubit.getPlayerProfileById(player!.id!),
                    ),
          );
        },
      ),
    );
  }
}
