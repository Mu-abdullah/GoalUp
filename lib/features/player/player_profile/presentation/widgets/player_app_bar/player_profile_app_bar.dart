import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../cubits/player_profile_cubit/player_profile_cubit.dart';
import 'app_bar_action.dart';

class CustomPlayerProfile extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPlayerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var player = context.watch<PlayerProfileCubit>();
    return CustomAppBar(
      title: "",
      translate: false,
      actions: [
        Padding(
          padding: AppPadding.symmetric(horizontal: 16, vertical: 0),
          child: InkWell(
            child: Icon(HugeIcons.strokeRoundedMenu01),
            onTap: () {
              debugPrint(player.player!.id);
              customShowBottomSheet(
                context: context,
                title: LangKeys.menu,
                isScrollControlled: false,
                useSafeArea: false,
                widget: AppBarActions(player: player.player!),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Statics.appBarHeight);
}
