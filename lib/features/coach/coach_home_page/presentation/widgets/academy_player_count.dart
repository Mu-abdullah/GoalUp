import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/home_count_card.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../coach_home_screen/presentation/cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../cubits/player_counts_cubit/player_counts_cubit.dart';

class AcademyPlayerCount extends StatelessWidget {
  const AcademyPlayerCount({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<PlayerCountsCubit, PlayerCountsState>(
        builder: (context, state) {
          if (state is PlayerCountsLoading) {
            return ListLoadingShimmer();
          } else if (state is PlayerCountsLoaded) {
            return HomeCountCard(
              cardTitle: LangKeys.players,
              cardIcon: HugeIcons.strokeRoundedWorkoutRun,
              isHighlighted: true,
              cardCount: state.playerCountList.length.toString(),
              onTap: () {
                BottomBarCubit.get(context).onTabTapped(1);
              },
            );
          } else if (state is PlayerCountsError) {
            return Center(child: AppText(state.error, maxLines: 20));
          }
          return HomeCountCard(
            cardTitle: LangKeys.players,
            cardIcon: HugeIcons.strokeRoundedWorkoutRun,
            isHighlighted: true,
          );
        },
      ),
    );
  }
}
