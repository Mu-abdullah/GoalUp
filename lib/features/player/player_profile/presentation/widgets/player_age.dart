import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/functions/time_refactor.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_text.dart';

class PlayerAge extends StatelessWidget {
  const PlayerAge({super.key, required this.birthday, required this.flag});

  final String birthday;
  final String flag;
  @override
  Widget build(BuildContext context) {
    final lang = context.langCode;
    final age = TimeRefactor.calculateAge(birthday);

    final formattedDate = TimeRefactor(
      birthday,
    ).toDateString(format: 'dd MMM, y', lang: lang);

    final ageLabel =
        lang == 'ar'
            ? (age >= 10 ? 'سنة' : 'سنوات')
            : (age == 1 ? 'Year' : 'Years');

    return Row(
      spacing: 5,
      children: [
        const Icon(
          HugeIcons.strokeRoundedBirthdayCake,
          size: 16,
          color: Colors.amber,
        ),
        AppText(formattedDate, color: AppColors.grey, translate: false),
        AppText('($age $ageLabel)', color: AppColors.black, translate: false),
        Spacer(),
        AppText(flag, color: AppColors.black, translate: false),
      ],
    );
  }
}
