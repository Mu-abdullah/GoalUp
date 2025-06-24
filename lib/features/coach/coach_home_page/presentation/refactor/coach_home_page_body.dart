import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../widgets/academy_name_logo.dart';
import '../widgets/academy_player_count.dart';

class CoachHomePageBody extends StatelessWidget {
  const CoachHomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetricPadding(),
      child: Column(
        spacing: 20,
        children: [AcademyNameLogo(), AcademyPlayerCount()],
      ),
    );
  }
}
