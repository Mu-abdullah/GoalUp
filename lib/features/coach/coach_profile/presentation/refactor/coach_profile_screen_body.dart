import 'package:flutter/material.dart';

import '../widgets/coach_info_widget.dart';
import '../widgets/profile_button_listview.dart';

class CoachProfileScreenBody extends StatelessWidget {
  const CoachProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [CoachIfoWidget(), ProfileButtonsListView()],
    );
  }
}
