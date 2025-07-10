import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/functions/generate_id.dart';
import '../../../../../../core/functions/time_refactor.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/services/supabase/backend_points.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/add_history.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/cancel_registration_cubit/cancel_registration_cubit.dart';
import 'app_bar_action_button.dart';

class CancelRegistrationButton extends StatelessWidget {
  const CancelRegistrationButton({
    super.key,
    required this.player,
    required this.refresh,
  });

  final PlayerProfileModel player;
  final VoidCallback refresh;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CancelRegistrationCubit, CancelRegistrationState>(
      listener: (context, state) {
        if (state is CancelRegistrationDone) {
          Navigator.of(context).pop();
          CustomSnackbar.showTopSnackBar(
            context,
            message: LangKeys.done,
            translate: false,
          );
        } else if (state is CancelRegistrationError) {
          CustomSnackbar.showTopSnackBar(
            context,
            message: state.error,
            isError: true,
            translate: false,
          );
        } else if (state is AddToHistoryError) {
          CustomSnackbar.showTopSnackBar(
            context,
            message: state.error,
            isError: true,
            translate: false,
          );
        }
      },
      builder: (context, state) {
        final cubit = CancelRegistrationCubit.get(context);
        final academyId = AppUserCubit.get(context).academyId;

        return AppBarActionButton(
          leading: HugeIcons.strokeRoundedDelete01,
          title: LangKeys.cancelRegistration,
          trailing: HugeIcons.strokeRoundedAlert02,
          onTap: () => _showConfirmationDialog(context, cubit, academyId),
          color: AppColors.red,
        );
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    CancelRegistrationCubit cubit,
    String academyId,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: AppText(
              LangKeys.cancelRegistration,
              isTitle: true,
              color: AppColors.red,
            ),
            content: AppText(LangKeys.areYouSure, isBold: true),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: AppText(LangKeys.cancel),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _handleCancel(context, cubit, academyId);
                  refresh.call();
                },
                child: AppText(LangKeys.done, color: AppColors.grey),
              ),
            ],
          ),
    );
  }

  Future<void> _handleCancel(
    BuildContext context,
    CancelRegistrationCubit cubit,
    String academyId,
  ) async {
    final now = DateTime.now();
    final history = AddHistoryModel(
      id: GenerateId.generateDocumentId(
        table: BackendPoint.playerHistory,
        userId: player.id,
      ),
      createdAt: now.toString(),
      playerId: player.id,
      academyName: academyId,
      from: player.enrollmentDate,
      to: TimeRefactor.currentDateString(),
    );

    final historySuccess = await cubit.addToPlayerHistory(
      data: history.toJson(),
    );
    if (historySuccess && context.mounted) {
      await cubit.cancelRegistration(player.academyplayerId!);
    }
  }
}
