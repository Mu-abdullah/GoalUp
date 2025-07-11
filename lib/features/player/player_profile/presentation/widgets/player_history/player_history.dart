import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/player_history_cubit/player_history_cubit.dart';
import 'no_history_item.dart';
import 'history_list.dart';

class PlayerHistory extends StatelessWidget {
  const PlayerHistory({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerHistoryCubit, PlayerHistoryState>(
      builder: (context, state) {
        if (state is PlayerHistoryLoaded) {
          return PlayerHistoryList(historyList: state.historyList);
        } else if (state is PlayerNoHistoryFound) {
          return NoHistoryItem(player: player);
        } else if (state is PlayerHistoryError) {
          return AppText(state.error);
        } else if (state is PlayerHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.blueAccent),
          );
        }
        return const SizedBox();
      },
    );
  }
}
