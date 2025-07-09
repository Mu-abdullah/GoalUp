import 'package:flutter/material.dart';

import '../../data/model/get_players_model.dart';
import '../cubits/coach_players_cubit/coach_players_cubit.dart';
import 'coach_player_listview_item.dart';
import 'position_filter.dart';

class CoachPlayersListView extends StatelessWidget {
  const CoachPlayersListView({super.key, required this.players});
  final List<GetPlayersModel> players;
  @override
  Widget build(BuildContext context) {
    var coachPlayer = CoachPlayersCubit.get(context);
    return Column(
      children: [
        coachPlayer.players.length == 1 ? SizedBox.shrink() : PositionFilter(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return CoachPlayerItem(player: player);
          },
        ),
      ],
    );
  }
}
