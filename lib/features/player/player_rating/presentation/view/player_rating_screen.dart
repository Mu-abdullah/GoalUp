import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../data/repo/save_certina_repo.dart';
import '../cubits/get_category_cubit/get_category_cubit.dart';
import '../cubits/save_evaluations_cubit/save_evaluations_cubit.dart';
import '../refactor/player_rating_screen_body.dart';

class PlayerRatingScreen extends StatelessWidget {
  const PlayerRatingScreen({
    super.key,
    required this.playerId,
    required this.playerName,
  });
  final String playerId;
  final String playerName;
  @override
  Widget build(BuildContext context) {
    final loc = locator<SaveEvaluationsRepo>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetCategoryCubit()),
        BlocProvider(create: (context) => SaveEvaluationsCubit(loc, playerId)),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: playerName, tr: false),
        body: const CategoryCriteriaScreen(),
      ),
    );
  }
}
