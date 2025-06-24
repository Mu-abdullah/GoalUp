import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it/git_it.dart';
import '../../data/repo/get_player_profile_repo.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../refactor/player_profile_body.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({super.key, this.isAdmin = false, this.playerId, this.academy});
  final bool isAdmin;
  final String? playerId;
  final String? academy;
  @override
  Widget build(BuildContext context) {
    var lac = locator<GetPlayerProfileRepo>();
    return BlocProvider(
      create:
          (context) =>
              PlayerProfileCubit(lac, isAdmin: isAdmin,academy: academy!)
                ..getPlayerProfile(playerId!),
      child: Scaffold(body: PlayerProfileBody()),
    );
  }
}
