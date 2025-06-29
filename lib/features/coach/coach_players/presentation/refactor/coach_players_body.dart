import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/coach_players_cubit/coach_players_cubit.dart';
import '../widgets/coach_player_listview.dart';

class CoachPlayersBody extends StatelessWidget {
  const CoachPlayersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachPlayersCubit, CoachPlayersState>(
      builder: (context, state) {
        if (state is CoachPlayersLoading) {
          return ListLoadingShimmer(height: 0.1);
        } else if (state is CoachPlayersError) {
          return Center(
            child: AppText(state.message, translate: false, maxLines: 20),
          );
        } else if (state is CoachPlayersLoaded) {
          return CoachPlayersListView(players: state.players);
        }
        return Center(child: AppText(LangKeys.userNotFound));
      },
    );
  }
}
