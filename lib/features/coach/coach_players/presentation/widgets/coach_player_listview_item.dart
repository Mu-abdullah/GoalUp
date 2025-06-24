import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/functions/time_refactor.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/get_players_model.dart';

class CoachPlayerItem extends StatelessWidget {
  const CoachPlayerItem({super.key, required this.player});

  final GetPlayersModel? player;

  @override
  Widget build(BuildContext context) {
    final lang = context.langCode;
    final age = TimeRefactor.calculateAge(player!.birthday!);
    bool translate = player == null;
    return InkWell(
      onTap: () {
        context.pushNamed(
          RoutesNames.playerProfile,
          arguments: {
            'playerId': player?.id,
            'isAdmin': true,
            'academy': player?.academy,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.black, width: 2),
                image: DecorationImage(
                  image: NetworkImage(player?.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    player?.player ?? LangKeys.unKnown,
                    translate: translate,
                    isTitle: true,
                    isBold: true,
                  ),

                  AppText(
                    player?.position ?? 'Position not specified',
                    translate: translate,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      AppText(
                        TimeRefactor(
                          player?.birthday ?? '',
                        ).toDateString(format: 'dd MMM, y', lang: lang),

                        color: AppColors.grey,
                        translate: translate,
                      ),
                      AppText(
                        '( $age ${lang == 'ar' ? 'سنوات' : 'Years'})',
                        isBold: true,
                        color: AppColors.black,
                        translate: translate,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
