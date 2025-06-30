import 'package:flutter/material.dart';

import '../cubits/player_rating_cubit/player_rating_cubit.dart';
import '../widgets/indecators/page_indecator_steps.dart';
import '../widgets/indecators/page_indecator_buttons.dart';

class PlayerRatingScreenBody extends StatelessWidget {
  const PlayerRatingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PlayerRatingCubit.get(context);
    return Column(
      children: [
        const PageIndicatorSteps(),
        Expanded(
          child: PageView.builder(
            controller: cubit.controller,
            itemCount: cubit.pages.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => cubit.pages[index],
          ),
        ),
        const PageIndicatorButtons(),
      ],
    );
  }
}
