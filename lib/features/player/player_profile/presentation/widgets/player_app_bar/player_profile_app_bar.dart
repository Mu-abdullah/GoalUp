import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'coaches_app_bar.dart';
import 'player_app_bar.dart';

class PlayerProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PlayerProfileAppBar({super.key, required this.isPlayer});
  final bool isPlayer;
  @override
  Widget build(BuildContext context) {
    final acdemyId = AppUserCubit.get(context).academyId;
    final playerCubit = context.watch<PlayerProfileCubit>();
    final player = playerCubit.player;

    if (player == null) {
      return const CustomAppBar(title: "", tr: false);
    }

    final isCoach = player.academyId == acdemyId;

    return CustomAppBar(
      title: "",
      tr: false,
      isBack: isPlayer,
      actions: [
        acdemyId == ""
            ? PlayerAppBarButton(
              player: player,
              onRefresh: () => playerCubit.getPlayerProfileById(player.id!),
            )
            : CoachesAppBar(
              player: player,
              isCoach: isCoach,
              playerCubit: playerCubit,
            ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Statics.appBarHeight);
}
