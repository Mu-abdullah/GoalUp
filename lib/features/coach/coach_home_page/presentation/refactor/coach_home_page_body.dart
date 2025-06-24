import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/style/color/app_color.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/home_count_card.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../widgets/academy_name_logo.dart';
import '../widgets/academy_player_count.dart';

class CoachHomePageBody extends StatelessWidget {
  const CoachHomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetricPadding(),
      child: Column(
        spacing: 20,
        children: [
          AcademyNameLogo(),
          AcademyPlayerCount(),
          HomeCountCard(
            cardTitle: LangKeys.newPlayer,
            isTitle: true,
            cardIcon: HugeIcons.strokeRoundedAddTeam,
            isHighlighted: true,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
