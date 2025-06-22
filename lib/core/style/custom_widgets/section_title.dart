import 'package:flutter/material.dart';

import '../widgets/app_text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppText(title, isBold: true, fontSize: 18);
  }
}
