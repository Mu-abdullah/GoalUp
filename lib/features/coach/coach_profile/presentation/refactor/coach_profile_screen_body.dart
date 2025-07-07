import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../widgets/coach_info_widget.dart';
import '../widgets/profile_button_listview.dart';

class CoachProfileScreenBody extends StatelessWidget {
  const CoachProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        CoachIfoWidget(),
        AppText(LangKeys.settings, isBold: true),
        ProfileButtonsListView(),
      ],
    );
  }
}
