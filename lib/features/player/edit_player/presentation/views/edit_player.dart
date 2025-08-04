import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../new_player/data/repo/get_positions.dart';
import '../../../new_player/data/repo/update_player_repo.dart';
import '../../../new_player/presentation/cubits/get_positions_cubit/get_positions_cubit.dart';
import '../../../player_profile/data/model/player_profile_model.dart';
import '../cubits/update_cubit/update_cubit.dart';
import '../cubits/update_player_cubit/update_player_cubit.dart';
import '../refactor/edit_player_body.dart';

class EditPlayerScreen extends StatelessWidget {
  const EditPlayerScreen({super.key, required this.player});
  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    final editRepo = locator<UpdatePlayerRepo>();
    final positionRepo = locator<GetPositions>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpdateCubit(player: player)),
        BlocProvider(
          create:
              (context) => GetPositionsCubit(positionRepo)..fetchPositions(),
        ),
        BlocProvider(create: (context) => UpdatePlayerCubit(repo: editRepo)),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: player.name!, tr: false),
        body: EditPlayerScreenBody(),
      ),
    );
  }
}
