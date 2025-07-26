import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/style/custom_widgets/custom_snack_bar.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'app_bar_action_button.dart';

class UnCoachAppBarActions extends StatelessWidget {
  const UnCoachAppBarActions({super.key, required this.player});

  final PlayerProfileCubit player;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        AppBarActionButton(
          leading: HugeIcons.strokeRoundedAddToList,
          title: LangKeys.register,
          color: AppColors.green,
          onTap: () {
            if (player.player?.academyId != null) {
              CustomSnackbar.showTopSnackBar(
                context,
                message: LangKeys.youcantRegisteredPlayer,
                isError: true,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
