import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../refactor/coach_profile_screen_body.dart';

class CoachProfileScreen extends StatelessWidget {
  const CoachProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: CoachProfileScreenBody(),
    );
  }
}
