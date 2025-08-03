import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../new_player/data/model/new_player_model.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancel_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';
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
    final noImage = player.image == null || player.image!.isEmpty;
    return BlocProvider(
      create: (context) => CancelRegistrationCubit(lac),
      child: ListView(
        shrinkWrap: true,
        children: [
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedImageAdd01,
            title: noImage ? LangKeys.addImage : LangKeys.changeImage,
            onTap: () {
              NewPlayerModel newPlayer = NewPlayerModel(
                name: player.name,
                image: player.image,
                birthday: player.birthday,
                contactNumber: player.contactNumber,
                nationality: player.nationality,
                position: player.position,
                id: player.id,
                nid: player.nid,
                createdAt: player.createdAt,
              );
              context.pushNamed(
                RoutesNames.newPlayer,
                arguments: {'player': newPlayer, 'isEdit': true},
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

          ///[LAST BUTTON IN BOTTOM SHEET]
          CancelRegistrationButton(player: player, refresh: onRefresh),
          // isCoach
          //     ? CancelRegistrationButton(player: player, refresh: onRefresh)
          //     : player.academyId == null
          //     ? AppBarActionButton(
          //       leading: HugeIcons.strokeRoundedAddToList,
          //       title: LangKeys.register,
          //       color: AppColors.green,
          //       onTap: () {},
          //     )
          //     : Container(),
        ],
      ),
    );
  }
}
