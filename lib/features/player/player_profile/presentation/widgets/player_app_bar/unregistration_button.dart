import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';

class CancelRegistrationButton extends StatelessWidget {
  const CancelRegistrationButton({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CancelRegistrationCubit, CancelRegistrationState>(
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
                    Navigator.of(context).pop(); // Close dialog only
                  },
                  child: AppText(LangKeys.cancel),
                ),
                TextButton(
                  onPressed: () {
                    cubit.cancelRegistration(player.academyplayerId);
                    Navigator.of(context).pop();
                  },
                  child: AppText(LangKeys.done, color: AppColors.grey),
                ),
              ],
            );

            // Show dialog and handle bottom sheet closure AFTER dialog dismisses
            showDialog(
              context: context,
              builder: (BuildContext context) => alert,
            ).then((_) {
              // This runs when dialog closes
              if (!context.mounted) return;
              {
                Navigator.of(context).pop();
              } // Close bottom sheet
            });
          },
          color: AppColors.red,
        );
      },
    );
  }
}
