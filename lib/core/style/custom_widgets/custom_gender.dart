import 'package:sport/core/language/lang_keys.dart';
import 'package:sport/core/style/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../services/status/gender_status.dart';
import '../color/app_color.dart';

class GenderChoose extends StatelessWidget {
  final Gender? groupValue;
  final ValueChanged<Gender?> onChanged;

  const GenderChoose({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Gender>(
            title: Row(
              spacing: 8,
              children: [
                Icon(HugeIcons.strokeRoundedMan, color: AppColors.blueAccent),

                AppText(LangKeys.male),
              ],
            ),
            contentPadding: const EdgeInsets.all(0),
            value: Gender.male,
            groupValue: groupValue,
            activeColor: Colors.blueAccent,
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 50, child: VerticalDivider(color: AppColors.grey)),
        Expanded(
          child: RadioListTile<Gender>(
            title: Row(
              spacing: 8,
              children: [
                Icon(HugeIcons.strokeRoundedWoman, color: AppColors.pink),
                AppText(LangKeys.female),
              ],
            ),
            contentPadding: const EdgeInsets.all(0),
            value: Gender.female,
            groupValue: groupValue,
            activeColor: Colors.pink,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
