import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it/git_it.dart';
import '../../data/repo/get_player_profile_repo.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../refactor/player_profile_body.dart';

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
    return BlocProvider(
      create:
          (context) =>
              PlayerProfileCubit(lac, isCoach: isCoach)
                ..getPlayerProfileById(playerId),
      child: Scaffold(body: PlayerProfileBody()),
    );
  }
}
