import 'package:flutter/material.dart';

import '../../data/model/get_players_model.dart';
import 'coach_player_listview_item.dart';

class CoachPlayersListView extends StatelessWidget {
  const CoachPlayersListView({super.key, required this.players});
  final List<GetPlayersModel> players;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return CoachPlayerItem(player: player);
      },
    );
  }
}

