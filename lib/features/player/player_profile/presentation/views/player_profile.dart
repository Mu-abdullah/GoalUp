import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it/git_it.dart';
import '../../data/repo/get_player_profile_repo.dart';
import '../../data/repo/player_history_repo.dart';
import '../cubits/player_history_cubit/player_history_cubit.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../refactor/player_profile_body.dart';
import '../widgets/player_app_bar/player_profile_app_bar.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({
    super.key,
    this.isCoach = false,
    required this.playerId,
  });
  final bool isCoach;
  final String playerId;
  @override
  Widget build(BuildContext context) {
    var lac = locator<GetPlayerProfileRepo>();
    var history = locator<PlayerHistoryRepo>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PlayerProfileCubit(lac, isCoach: isCoach)
                    ..getPlayerProfileById(playerId),
        ),
        BlocProvider(
          create:
              (context) =>
                  PlayerHistoryCubit(history)..getPlayerHistory(playerId),
        ),
      ],
      child: Scaffold(appBar: CustomPlayerProfile(), body: PlayerProfileBody()),
    );
  }
}
