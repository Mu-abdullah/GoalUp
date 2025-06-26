import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';
import '../refactor/new_player_screen_body.dart';

class NewPlayerScreen extends StatelessWidget {
  const NewPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPlayerCubit(context),
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
