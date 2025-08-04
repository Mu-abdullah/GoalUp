import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../../../player_profile/presentation/widgets/player_info/player_age.dart';
import '../cubits/update_cubit/update_cubit.dart';
import '../widgets/edit_player_form.dart';
import '../widgets/edit_player_image.dart';
import '../widgets/edit_player_position.dart';
import '../widgets/update_button.dart';

class EditPlayerScreenBody extends StatelessWidget {
  const EditPlayerScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (context, state) {
        var cubit = UpdateCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: AppPadding.symmetric(),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditPlayerImage(cubit: cubit),
                PlayerAge(
                  birthday: cubit.player.birthday!,
                  flag: cubit.player.nationality!,
                ),
                EditPlayerFrom(cubit: cubit),
                EditPlayerPosition(cubit: cubit),
                UpdateButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
