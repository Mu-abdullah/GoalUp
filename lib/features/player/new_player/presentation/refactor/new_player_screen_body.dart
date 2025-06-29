import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';
import '../widgets/choose_national.dart';
import '../widgets/new_player_form.dart';
import '../widgets/register_button.dart';

class NewPlayerScreenBody extends StatelessWidget {
  const NewPlayerScreenBody({super.key, required this.cubit});

  final NewPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.symmetricPadding(),
        child: Column(
          spacing: 10,
          children: [
            NewPlayerForm(cubit: cubit),
            ChooseNational(cubit: cubit),
            RegisterButton(cubit: cubit),
          ],
        ),
      ),
    );
  }
}
