import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/home_count_card.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../cubits/home_academy_cubit/home_academy_cubit.dart';
import '../cubits/player_counts_cubit/player_counts_cubit.dart';
import '../widgets/academy_name_logo.dart';
import '../widgets/academy_player_count.dart';

class CoachHomePageBody extends StatelessWidget {
  const CoachHomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var academyId = AppUserCubit.get(context).academyId;
    var count = PlayerCountsCubit.get(context);
    var acdemy = HomeAcademyCubit.get(context);
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 500), () async {
          await count.getPlayerCount(academyId);
          await acdemy.getAcademy(academyId);
        });
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: AppPadding.symmetric(),
          child: Column(
            spacing: 20,
            children: [
              AcademyNameLogo(),
              Row(
                spacing: 10,
                children: [
                  Expanded(child: AcademyPlayerCount()),
                  Expanded(
                    child: HomeCountCard(
                      cardTitle: LangKeys.newPlayer,
                      isTitle: true,
                      cardIcon: HugeIcons.strokeRoundedAddTeam,
                      isHighlighted: true,
                      color: AppColors.black,
                      onTap: () {
                        context.pushNamed(RoutesNames.newPlayerNidScreen);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
