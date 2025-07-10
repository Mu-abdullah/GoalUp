import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../../data/model/player_profile_model.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'player_image.dart';
import 'player_info.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.player, required this.cubit});

  final PlayerProfileModel player;
  final PlayerProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.symmetric(),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                PlayerImage(player: player),
                Expanded(child: PlayerInfo(player: player)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
