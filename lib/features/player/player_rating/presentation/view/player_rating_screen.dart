import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../cubits/get_category_cubit/get_category_cubit.dart';
import '../cubits/player_rating_cubit/player_rating_cubit.dart';
import '../refactor/player_rating_screen_body.dart';

class PlayerRatingScreen extends StatelessWidget {
  const PlayerRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlayerRatingCubit()),
        BlocProvider(create: (context) => GetCategoryCubit()..init()),
      ],
      child: BlocListener<PlayerRatingCubit, PlayerRatingState>(
        listener: (context, state) {
          PlayerRatingCubit.get(context).controller.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: LangKeys.ratings),
          body: const PlayerRatingScreenBody(),
        ),
      ),
    );
  }
}
