import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../coach_home_page/data/repo/home_academy_repo.dart';
import '../../../coach_home_page/data/repo/player_count_repo.dart';
import '../../../coach_home_page/presentation/cubits/home_academy_cubit/home_academy_cubit.dart';
import '../../../coach_home_page/presentation/cubits/player_counts_cubit/player_counts_cubit.dart';
import '../../../coach_players/data/repo/get_coach_players.dart';
import '../../../coach_players/presentation/cubits/coach_players_cubit/coach_players_cubit.dart';
import '../cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../refactor/bottom_bar_body.dart';

class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    var players = locator<GetCoachPlayers>();
    var academy = locator<HomeAcademyRepo>();
    var count = locator<PlayerCountRepo>();
    var academyId = context.read<AppUserCubit>().academyId;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit(isAdmin)),
        BlocProvider(
          create: (context) => HomeAcademyCubit(academy)..getAcademy(academyId),
        ),
        BlocProvider(
          create:
              (context) =>
                  CoachPlayersCubit(players)
                    ..getCoachPlayers(academyId: academyId),
        ),
        BlocProvider(
          create: (context) => PlayerCountsCubit(count)..getPlayerCount(academyId),
        ),
      ],
      child: BottomBarBody(),
    );
  }
}
