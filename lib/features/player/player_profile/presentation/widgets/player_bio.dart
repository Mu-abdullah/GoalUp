import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_text.dart';

class PlayerBio extends StatelessWidget {
  const PlayerBio({super.key, required this.bio});
  final String bio;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        AppText(
          LangKeys.bio,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.grey,
        ),
        const Divider(color: Colors.grey, height: 30),
        AppText(bio, translate: false, maxLines: 30, height: 1.5),
      ],
    );
  }
}
