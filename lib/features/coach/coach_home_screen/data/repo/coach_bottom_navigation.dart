import 'package:flutter/cupertino.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../coach_home_page/presentation/views/coach_home_page.dart';
import '../../../coach_players/presentation/views/coach_players.dart';
import '../../../coach_profile/presentation/views/coach_profile_screen.dart';

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
      CoachProfileScreen(),
    ];
  }
}
