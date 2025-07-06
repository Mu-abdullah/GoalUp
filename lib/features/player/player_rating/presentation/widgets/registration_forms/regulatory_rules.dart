import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../admin/admin_home/presentation/widgets/admin_section.dart';

class RegulatoryRules extends StatelessWidget {
  const RegulatoryRules({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.symmetricPadding(),
      child: AdminSections(
        title: LangKeys.disciplineRules,
        icon: HugeIcons.strokeRoundedWork,
        child: Column(
          spacing: 16,
          children: [Column(spacing: 16, children: [])],
        ),
      ),
    );
  }
}
