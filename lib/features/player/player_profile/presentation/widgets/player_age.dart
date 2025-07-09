import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/functions/time_refactor.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_text.dart';

class PlayerAge extends StatelessWidget {
  const PlayerAge({super.key, required this.birthday});
  final String birthday;
  @override
  Widget build(BuildContext context) {
    final lang = context.langCode;
    final age = TimeRefactor.calculateAge(birthday);
    return Row(
      spacing: 8,
      children: [
        const Icon(Icons.cake, size: 16, color: Colors.amber),
        AppText(
          TimeRefactor(birthday).toDateString(format: 'dd MMM, y', lang: lang),
          fontSize: 16,
          color: AppColors.grey,
          translate: false,
        ),
        AppText(
          '( $age ${lang == 'ar' ? 'سنوات' : 'Years'})',
          fontSize: 16,
          color: AppColors.black,
          translate: false,
        ),
      ],
    );
  }
}
