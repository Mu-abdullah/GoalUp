import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/style/custom_widgets/custom_bottom_sheet.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancel_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';
import 'share_user_info.dart';
import 'unregistration_button.dart';

class CoachAppBarActions extends StatelessWidget {
  const CoachAppBarActions({
    super.key,
    required this.player,
    required this.onRefresh,
  });
  final PlayerProfileModel player;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    // final acdemyid = AppUserCubit.get(context).academyId;
    // final isCoach = player.academyId == acdemyid;
    final lac = locator<CancelRegistrationRepo>();
    return BlocProvider(
      create: (context) => CancelRegistrationCubit(lac),
      child: ListView(
        shrinkWrap: true,
        children: [
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedEdit01,
            title: LangKeys.edit,
            onTap: () {
              context.pushNamed(
                RoutesNames.editPlayerScreen,
                arguments: {'player': player},
              );
            },
          ),
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedCall,
            title: LangKeys.callPlayer,
            onTap: () {
              context.call(phoneNumber: player.contactNumber!);
            },
          ),
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedShare01,
            title: LangKeys.shareInfo,
            onTap: () {
              Navigator.pop(context);
              customShowBottomSheet(
                context: context,
                isScrollControlled: false,
                widget: ShareUserInfo(playerId: player.id!),
                title: LangKeys.shareInfo,
              );
            },
          ),

          ///[LAST BUTTON IN BOTTOM SHEET]
          CancelRegistrationButton(player: player, refresh: onRefresh),
        ],
      ),
    );
  }
}
