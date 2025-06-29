import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../data/model/new_player_model.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';
import '../refactor/new_player_screen_body.dart';

class NewPlayerScreen extends StatelessWidget {
  const NewPlayerScreen({super.key, this.player, required this.nid});
  final NewPlayerModel? player;
  final String? nid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPlayerCubit(context, nid: nid, player: player),
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
