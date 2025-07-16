import 'package:flutter/material.dart';

import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../../core/style/widgets/custom_divider.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'player_data.dart';
import '../player_history/player_history.dart';

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
          spacing: 10,
          children: [
            PlayerData(player: player),
            const CustomDivider(opacity: 0.5, thickness: 1),
            PlayerHistory(player: player),
          ],
        ),
      ),
    );
  }
}


