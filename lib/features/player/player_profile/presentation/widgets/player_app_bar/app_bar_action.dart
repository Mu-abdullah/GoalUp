import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/repo/cancer_registration_repo.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';

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
          BlocConsumer<CancelRegistrationCubit, CancelRegistrationState>(
            listener: (context, state) {
              if (state is CancelRegistrationDone) {
                context.pop();
              }
              if (state is CancelRegistrationError) {
                CustomSnackbar.showTopSnackBar(
                  context,
                  message: state.error,
                  isError: true,
                  translate: false,
                );
              }
            },
            builder: (context, state) {
              var cubit = CancelRegistrationCubit.get(context);
              return AppBarActionButton(
                leading: HugeIcons.strokeRoundedDelete01,
                title: LangKeys.cancelRegistration,
                trailing: HugeIcons.strokeRoundedAlert02,
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    title: AppText(
                      LangKeys.cancelRegistration,
                      isTitle: true,
                      color: AppColors.red,
                    ),
                    content: AppText(LangKeys.areYouSure, isBold: true),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: AppText(LangKeys.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          cubit.cancelRegistration(player.academyplayerId);
                        },
                        child: AppText(LangKeys.done, color: AppColors.red),
                      ),
                    ],
                  );
                  context.pop();
                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                color: AppColors.red,
              );
            },
          ),
        ],
      ),
    );
  }
}
