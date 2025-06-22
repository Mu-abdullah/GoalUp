import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../core/style/statics/image_test.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      width: context.width(),
      height: context.height(percent: 0.3),
    );
  }
}
