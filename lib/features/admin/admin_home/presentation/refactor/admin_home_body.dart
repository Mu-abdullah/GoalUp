import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../widgets/sections/modes_sections.dart';
import '../widgets/sections/new_features_section.dart';
import '../widgets/sections/settings_section.dart';

class AdminHomeBody extends StatelessWidget {
  const AdminHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [ModesSection(), NewFeaturesSection(), SettingsSection()],
        ),
      ),
    );
  }
}
