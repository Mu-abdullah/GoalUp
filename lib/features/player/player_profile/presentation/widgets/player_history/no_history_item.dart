import 'package:flutter/material.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';

class NoHistoryItem extends StatelessWidget {
  const NoHistoryItem({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(player.academyLogo!)),
      title: AppText(player.academy!, translate: false),
      subtitle: Row(
        spacing: 5,
        children: [
          AppText(player.enrollmentDate!, translate: false),
          AppText("-", translate: false),
          AppText(LangKeys.untilNow),
        ],
      ),
    );
  }
}
