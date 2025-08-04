import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/functions/time_refactor.dart';
import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/functions/generate_id.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/services/get_it/git_it.dart';
import '../../../../../../core/services/supabase/backend_points.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../../new_player/data/model/create_academy_player.dart';
import '../../../../new_player/data/repo/create_player_repo.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../../cubits/register_new_player_cubit/register_new_player_cubit.dart';
import 'app_bar_action_button.dart';

class UnCoachAppBarActions extends StatelessWidget {
  const UnCoachAppBarActions({
    super.key,
    required this.player,
    required this.onRefresh,
  });

  final PlayerProfileCubit player;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    final createRepo = locator<CreatePlayerRepo>();
    return BlocProvider(
      create: (context) => RegisterNewPlayerCubit(createRepo),
      child: ListView(
        shrinkWrap: true,
        children: [
          BlocBuilder<RegisterNewPlayerCubit, RegisterNewPlayerState>(
            builder: (context, state) {
              return AppBarActionButton(
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
                  } else {
                    // Get cubit BEFORE popping route
                    final cubit = RegisterNewPlayerCubit.get(context);
                    _showConfirmationDialog(
                      context,
                      cubit, // Use pre-obtained cubit
                      player.player!,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    RegisterNewPlayerCubit cubit,
    PlayerProfileModel player,
  ) async {
    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: AppText(
              LangKeys.register,
              isTitle: true,
              color: AppColors.green,
            ),
            content: AppText(LangKeys.areYouSure, isBold: true),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: AppText(LangKeys.cancel),
              ),
              TextButton(
                onPressed: () async {
                  final rootContext =
                      Navigator.of(context, rootNavigator: true).context;
                  final play = CreateAcademyPlayer(
                    academy: AppUserCubit.get(rootContext).academyId,
                    createdAt: DateTime.now().toString(),
                    enrollmentDate: TimeRefactor.currentDateString(
                      format: 'yyyy-MM-dd',
                    ),
                    id: GenerateId.generateDocumentId(
                      academy: AppUserCubit.get(rootContext).academyId,
                      table: BackendPoint.academysPlayers,
                    ),

                    player: player.id,
                  );
                  Navigator.of(context).pop();
                  await cubit.registerPlayer(play).then((v) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      onRefresh.call();
                    }
                  });
                },
                child: AppText(LangKeys.done, color: AppColors.grey),
              ),
            ],
          ),
    );
  }
}
