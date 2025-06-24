import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/functions/time_refactor.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../data/model/player_profile_model.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../player_item_info.dart';

class PlayerInfoSection extends StatelessWidget {
  const PlayerInfoSection({super.key, required this.player});
  final PlayerProfileModel player;
  @override
  Widget build(BuildContext context) {
    var academy = context.read<PlayerProfileCubit>().academy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedUserGroup,
          title: LangKeys.academy,
          value: academy,
        ),
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedBirthdayCake,
          title: LangKeys.nid,
          value: player.nid ?? 'Unknown',
        ),
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedSmartPhone01,
          title: LangKeys.phone,
          value: player.contactNumber ?? 'Unknown',
        ),
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedCalendar01,
          title: LangKeys.phone,
          value: TimeRefactor(player.enrollmentDate!).toDateString(),
        ),
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedFlag02,
          title: LangKeys.nationality,
          value: player.nationality ?? 'Unknown',
        ),
        PlayerItemInfo(
          icon: HugeIcons.strokeRoundedShirt01,
          title: LangKeys.position,
          value: player.position ?? 'Unknown',
        ),
      ],
    );
  }
}
