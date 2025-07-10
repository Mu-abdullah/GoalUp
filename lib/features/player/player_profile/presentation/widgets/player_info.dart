import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../data/model/player_profile_model.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'player_age.dart';
import 'player_item_info.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key, required this.player});

  final PlayerProfileModel player;

  @override
  Widget build(BuildContext context) {
    var enroll = PlayerProfileCubit.get(context).enrollmentDate;
    return Padding(
      padding: AppPadding.symmetric(),
      child: Column(
        children: [
          PlayerAge(birthday: player.birthday!),
          PlayerItemInfo(
            icon: HugeIcons.strokeRoundedShirt01,
            title: LangKeys.position,
            value: player.position!,
          ),
          PlayerItemInfo(
            icon: HugeIcons.strokeRoundedCreditCard,
            title: LangKeys.nid,
            value: player.nid!,
          ),

          PlayerItemInfo(
            icon: HugeIcons.strokeRoundedCalendar01,
            title: LangKeys.enrollmentDate,
            value: enroll == '' ? LangKeys.somethingWentWrong : enroll,
          ),
          PlayerItemInfo(
            icon: HugeIcons.strokeRoundedSmartPhone01,
            title: LangKeys.phone,
            value: player.contactNumber!,
            onTab: () => context.call(phoneNumber: player.contactNumber!),
          ),
        ],
      ),
    );
  }
}
