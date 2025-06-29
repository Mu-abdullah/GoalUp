import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../widgets/player_image.dart';
import '../widgets/player_info.dart';

class PlayerProfileBody extends StatelessWidget {
  const PlayerProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      builder: (context, state) {
        final cubit = PlayerProfileCubit.get(context);
        if (state is PlayerProfileLoading) {
          return ListLoadingShimmer();
        } else if (state is PlayerProfileLoaded) {
          final player = state.playerProfile;
          return SingleChildScrollView(
            child: Column(
              children: [
                PlayerImage(player: player, cubit: cubit),
                PlayerInfo(player: player),
              ],
            ),
          );
        } else if (state is PlayerProfileError) {
          return Center(
            child: AppText(
              state.error,
              color: AppColors.red,
              translate: false,
              maxLines: 10,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: AppColors.blueAccent),
        );
      },
    );
  }
}
