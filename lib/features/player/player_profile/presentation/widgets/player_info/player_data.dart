import 'package:flutter/material.dart';

import '../../../data/model/player_profile_model.dart';
import 'player_image.dart';
import 'player_info.dart';

class PlayerData extends StatelessWidget {
  const PlayerData({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        PlayerImage(player: player),
        Expanded(child: PlayerInfo(player: player)),
      ],
    );
  }
}
