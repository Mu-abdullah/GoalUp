import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancer_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';
import 'unregistration_button.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key, required this.player});
  final PlayerProfileModel player;
  @override
  Widget build(BuildContext context) {
    final lac = locator<CancerRegistrationRepo>();
    return BlocProvider(
      create: (context) => CancelRegistrationCubit(lac),
      child: ListView(
        shrinkWrap: true,
        children: [
          AppBarActionButton(
            leading: HugeIcons.strokeRoundedStar,
            title: LangKeys.ratings,
            onTap: () {
              context.pushNamed(RoutesNames.playerRatingScreen);
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
          CancelRegistrationButton(player: player),
        ],
      ),
    );
  }
}
