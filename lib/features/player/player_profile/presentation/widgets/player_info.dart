import 'package:flutter/material.dart';

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
      height: Statics.defaultSize * 1.5,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildRowTexts(player.name!, player.nationality!),
          PlayerAge(birthday: player.birthday!),
          buildRowTexts(player.academy!, player.position!, isTitle: false),
        ],
      ),
    );
  }

  Widget buildRowTexts(
    String leftText,
    String rightText, {
    bool isTitle = true,
    bool isBold = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: AppText(
            leftText,
            translate: false,
            isTitle: isTitle,
            isBold: isBold,
          ),
        ),
        AppText(rightText, translate: false, isTitle: isTitle, isBold: isBold),
      ],
    );
  }
}
