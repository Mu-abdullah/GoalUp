import 'package:flutter/material.dart';

import '../../../data/model/player_history_model.dart';
import 'history_item.dart';

class PlayerHistoryList extends StatelessWidget {
  const PlayerHistoryList({super.key, required this.historyList});

  final List<PlayerHistoryModel> historyList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: historyList.length,
      itemBuilder: (_, i) {
        final player = historyList[i];

        return HistoryItem(player: player);
      },
    );
  }
}

