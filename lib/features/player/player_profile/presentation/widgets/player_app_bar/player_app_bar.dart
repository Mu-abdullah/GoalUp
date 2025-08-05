import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancel_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';
import 'unregistration_button.dart';

class PlayerAppBarButton extends StatelessWidget {
  const PlayerAppBarButton({
    super.key,
    required this.player,
    required this.onRefresh,
  });

  final PlayerProfileModel player;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final lac = locator<CancelRegistrationRepo>();

    return Padding(
      padding: AppPadding.symmetric(horizontal: 16, vertical: 0),
      child: InkWell(
        child: Icon(HugeIcons.strokeRoundedMenu01),
        onTap: () {
          customShowBottomSheet(
            context: context,
            title: LangKeys.menu,
            isScrollControlled: false,
            useSafeArea: false,
            widget: BlocProvider(
              create: (context) => CancelRegistrationCubit(lac),
              child: ListView(
                shrinkWrap: true,
                children: [
                  CancelRegistrationButton(
                    player: player,
                    refresh: () => onRefresh.call(),
                  ),
                  AppBarActionButton(
                    leading: HugeIcons.strokeRoundedLogout01,
                    title: LangKeys.logout,
                    onTap: () {
                      context.pushNamedAndRemoveUntil(
                        RoutesNames.userAuthScreen,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
