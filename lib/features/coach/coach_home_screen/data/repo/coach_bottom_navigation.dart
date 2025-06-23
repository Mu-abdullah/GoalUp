import 'package:flutter/cupertino.dart';
import 'package:sport/features/coach/coach_players/presentation/views/coach_players.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../coach_home_page/presentation/views/coach_home_page.dart';

class CoachBottomNavigation {
  static List<String> titles = [
    LangKeys.home,
    LangKeys.teams,
    LangKeys.players,
    LangKeys.profile,
  ];

  static List<Widget> itemsBody() {
    return [
      CoachHomePage(),
      Center(child: AppText(LangKeys.teams)),
      CoachPlayers(),
      Center(child: AppText(LangKeys.profile)),
    ];
  }
}
