import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_space.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../widgets/palyer_age.dart';
import '../widgets/player_image.dart';
import '../widgets/player_name.dart';
import '../widgets/sections/player_info_section.dart';

class PlayerProfileBody extends StatelessWidget {
  const PlayerProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      builder: (context, state) {
        final cubit = PlayerProfileCubit.get(context);
        if (state is PlayerProfileLoading) {
        } else if (state is PlayerProfileLoaded) {
          final player = state.playerProfile;
          return CustomScrollView(
            slivers: [
              PlayerImageHeader(
                isAdmin: cubit.isAdmin,
                imageUrl: player.image,
                playerName: player.name,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlayerName(name: player.name!),
                      PlayerAge(birthday: player.birthday!),
                      AppSpace(space: 10),
                      PlayerInfoSection(player: player),
                    ],
                  ),
                ),
              ),
            ],
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
