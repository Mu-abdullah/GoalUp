import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_button.dart';

class RemmberPlayer extends StatelessWidget {
  const RemmberPlayer({super.key, required this.playerId});
  final String playerId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 2,
            child: AppButton(
              onTap: () async {
                await SharedPref.saveData(
                  key: PrefKeys.rememberPlayer,
                  value: true,
                );
                await SharedPref.saveData(
                  key: PrefKeys.playerID,
                  value: playerId,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              text: LangKeys.remeberMe,
              backGroundColor: AppColors.green,
            ),
          ),
          Expanded(
            flex: 1,
            child: AppButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: LangKeys.remeberMeLater,
              backGroundColor: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
