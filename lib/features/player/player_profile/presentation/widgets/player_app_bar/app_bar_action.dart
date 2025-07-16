import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancel_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';
import 'unregistration_button.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    super.key,
    required this.player,
    required this.onRefresh,
  });
  final PlayerProfileModel player;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    final acdemyid = AppUserCubit.get(context).academyId;
    final lac = locator<CancelRegistrationRepo>();

    final isCoach = player.academyId == acdemyid;

    return BlocProvider(
      create: (context) => CancelRegistrationCubit(lac),
      child: ListView(
        shrinkWrap: true,
        children: [
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedStar,
            title: LangKeys.ratings,
            onTap: () {
              context.pushNamed(
                RoutesNames.playerRatingScreen,
                arguments: {'playerId': player.id},
              );
            },
          ),

          player.academyId == null || player.academyId != acdemyid
              ? Container()
              : AppBarActionButton(
                leading: HugeIcons.strokeRoundedCall,
                title: LangKeys.callPlayer,
                onTap: () {
                  context.call(phoneNumber: player.contactNumber!);
                },
              ),

          ///[LAST BUTTON IN BOTTOM SHEET]
          isCoach
              ? CancelRegistrationButton(player: player, refresh: onRefresh)
              : player.academyId == null
              ? AppBarActionButton(
                leading: HugeIcons.strokeRoundedAddToList,
                title: LangKeys.register,
                color: AppColors.green,
                onTap: () {},
              )
              : Container(),
        ],
      ),
    );
  }
}
