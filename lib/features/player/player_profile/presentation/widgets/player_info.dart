import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/player_profile_model.dart';
import 'player_age.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Statics.defaultSize * 1.6,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildRowTexts(rightText: player.name!, fontSize: 21),
          buildRowTexts(
            rightText: player.nid!,
            leftText: player.nationality!,
            isTitle: false,
            isBold: false,
          ),
          PlayerAge(birthday: player.birthday!),
          buildRowTexts(
            rightText: player.academy ?? LangKeys.notRegistered,
            leftText: player.position!,
            isTitle: false,
          ),
        ],
      ),
    );
  }

  Widget buildRowTexts({
    String? leftText,
    String? rightText,
    double? fontSize,
    bool isTitle = true,
    bool isBold = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: AppText(
            rightText ?? "",
            translate: false,
            isTitle: isTitle,
            isBold: isBold,
            fontSize: fontSize,
            maxLines: 2,
          ),
        ),
        AppText(
          leftText ?? "",
          translate: false,
          isTitle: isTitle,
          isBold: isBold,
        ),
      ],
    );
  }
}
