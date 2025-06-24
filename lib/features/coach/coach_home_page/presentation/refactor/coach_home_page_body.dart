import 'package:flutter/material.dart';

import '../widgets/academy_name_logo.dart';

class CoachHomePageBody extends StatelessWidget {
  const CoachHomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [AcademyNameLogo()]);
  }
}
