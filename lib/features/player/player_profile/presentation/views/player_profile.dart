import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../data/repo/get_player_profile_repo.dart';
import '../../data/repo/player_history_repo.dart';
import '../cubits/get_player_rating_cubit/get_player_rating_cubit.dart';
import '../cubits/player_history_cubit/player_history_cubit.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../refactor/player_profile_body.dart';
import '../widgets/player_app_bar/player_profile_app_bar.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({
    super.key,
    this.isCoach = false,
    required this.playerId,
  });
  final bool isCoach;
  final String playerId;

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  void initState() {
    isPlayer();
    super.initState();
  }

  isPlayer() {
    if (!widget.isCoach) {
      if (SharedPref.getData(key: PrefKeys.rememberPlayer) != true) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _showLanguageBottomSheet(),
        );
      }
    }
  }

  Future<void> _showLanguageBottomSheet() async {
    await customShowBottomSheet(
      context: context,
      widget: RemmberPlayer(),
      title: LangKeys.doYouWantToRememberYou,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lac = locator<GetPlayerProfileRepo>();
    var history = locator<PlayerHistoryRepo>();
    // var rating = locator<GetPlayerRatingRepo>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PlayerProfileCubit(lac, isCoach: widget.isCoach)
                    ..getPlayerProfileById(widget.playerId),
        ),
        BlocProvider(
          create:
              (context) =>
                  PlayerHistoryCubit(history)
                    ..getPlayerHistory(widget.playerId),
        ),
        BlocProvider(
          create:
              (context) =>
                  GetPlayerRatingCubit()..getPlayerRating(widget.playerId),
        ),
      ],
      child: Scaffold(
        appBar: PlayerProfileAppBar(isPlayer: widget.isCoach),
        body: PlayerProfileBody(),
      ),
    );
  }
}

class RemmberPlayer extends StatelessWidget {
  const RemmberPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 2,
            child: AppButton(
              onTap: () async {
                await SharedPref.saveData(
                  key: PrefKeys.rememberPlayer,
                  value: true,
                ).then((onValue) {
                  Navigator.pop(context);
                });
              },
              text: LangKeys.remeberMe,
              backGroundColor: AppColors.green,
            ),
          ),
          Expanded(
            flex: 1,
            child: AppButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: LangKeys.remeberMeLater,
              backGroundColor: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
