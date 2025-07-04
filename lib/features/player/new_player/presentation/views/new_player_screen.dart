import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../data/model/new_player_model.dart';
import '../../data/repo/get_countries.dart';
import '../../data/repo/get_positions.dart';
import '../cubits/countries_cubit/countries_cubit.dart';
import '../cubits/get_image_cubit/get_image_cubit.dart';
import '../cubits/get_positions_cubit/get_positions_cubit.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';
import '../refactor/new_player_screen_body.dart';

class NewPlayerScreen extends StatelessWidget {
  const NewPlayerScreen({
    super.key,
    this.player,
    required this.nid,
    required this.count,
  });
  final NewPlayerModel? player;
  final String? nid;
  final int count;
  @override
  Widget build(BuildContext context) {
    final repo = locator<GetCountries>();
    final positionRepo = locator<GetPositions>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => NewPlayerCubit(
                context,
                nid: nid,
                player: player,
                count: count,
              ),
        ),
        BlocProvider(
          create: (context) => CountriesCubit(repo)..fetchCountries(),
        ),
        BlocProvider(
          create:
              (context) => GetPositionsCubit(positionRepo)..fetchPositions(),
        ),
        BlocProvider(create: (context) => GetImageCubit()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: LangKeys.newPlayer),
        body: BlocBuilder<NewPlayerCubit, NewPlayerState>(
          builder: (context, state) {
            var cubit = NewPlayerCubit.get(context);
            return NewPlayerScreenBody(cubit: cubit);
          },
        ),
      ),
    );
  }
}
