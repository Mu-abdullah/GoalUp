import 'package:flutter/cupertino.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text.dart';

class CoachBottomNavigation {
  static List<String> titles = [
    LangKeys.home,
    LangKeys.teams,
    LangKeys.players,
    LangKeys.profile,
  ];

  static List<Widget> itemsBody() {
    return [
      Center(child: AppText(LangKeys.home)),
      Center(child: AppText(LangKeys.teams)),
      Center(child: AppText(LangKeys.players)),
      Center(child: AppText(LangKeys.profile)),
    ];
  }
}
