import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../admin/admin_home/presentation/widgets/admin_section.dart';

class PhysicalPerformance extends StatelessWidget {
  const PhysicalPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.symmetric(),
      child: AdminSections(
        title: LangKeys.physicalPerformance,
        icon: HugeIcons.strokeRoundedWork,
        child: Column(
          spacing: 16,
          children: [Column(spacing: 16, children: [])],
        ),
      ),
    );
  }
}
