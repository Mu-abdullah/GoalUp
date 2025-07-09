import 'package:flutter/material.dart';

import '../../data/model/player_profile_model.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'player_image.dart';
import 'player_info.dart';
import 'player_app_bar/player_profile_app_bar.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.player, required this.cubit});

  final PlayerProfileModel player;
  final PlayerProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PlayerImage(player: player, cubit: cubit),
                PlayerInfo(player: player),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: PlayerProfileAppBar(player: player),
        ),
      ],
    );
  }
}
