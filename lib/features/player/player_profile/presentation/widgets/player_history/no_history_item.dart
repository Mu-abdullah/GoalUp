import 'package:flutter/material.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/statics/image_test.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';

class NoHistoryItem extends StatelessWidget {
  const NoHistoryItem({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return player.academy == null
        ? AppText(LangKeys.notRegistered)
        : ListTile(
          leading: CircleAvatar(
            backgroundImage:
                player.academyLogo == null
                    ? AssetImage(AppImages.logo)
                    : NetworkImage(player.academyLogo!),
          ),
          title: AppText(player.academy ?? LangKeys.notRegistered, tr: false),
          subtitle: Row(
            spacing: 5,
            children: [
              AppText(
                player.enrollmentDate ?? LangKeys.notRegistered,
                tr: player.enrollmentDate == null,
              ),
              AppText("-", tr: false),
              AppText(LangKeys.untilNow),
            ],
          ),
        );
  }
}
