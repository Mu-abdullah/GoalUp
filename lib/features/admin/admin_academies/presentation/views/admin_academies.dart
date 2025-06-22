import 'package:flutter/material.dart';
import 'package:sport/core/language/lang_keys.dart';

import '../../../../../core/style/custom_widgets/custom_app_bar.dart';

class AdminAcademies extends StatelessWidget {
  const AdminAcademies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LangKeys.academies),
      body: Center(child: Text('Admin Academies Section')),
    );
  }
}
