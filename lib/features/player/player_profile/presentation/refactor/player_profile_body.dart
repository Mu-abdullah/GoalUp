import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/strings_static.dart';
import '../../../../../core/style/widgets/app_space.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../widgets/palyer_age.dart';
import '../widgets/player_bio.dart';
import '../widgets/player_image.dart';
import '../widgets/player_name.dart';
import '../widgets/sections/player_info_section.dart';
import '../widgets/sections/stats_gridview_section.dart';

class PlayerProfileBody extends StatefulWidget {
  const PlayerProfileBody({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  State<PlayerProfileBody> createState() => _PlayerProfileBodyState();
}

class _PlayerProfileBodyState extends State<PlayerProfileBody> {
  bool _showStats = false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PlayerImageHeader(
          isAdmin: widget.isAdmin,
          imageUrl:
              'https://eljjoukmoxumtwmfztks.supabase.co/storage/v1/object/public/images/Academy/Player/hamza.jpg',
          playerName: 'حمزة احمد رجب احمد',
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerName(name: 'حمزة احمد رجب احمد'),
                PlayerAge(birthday: '2019-09-14'),
                AppSpace(space: 10),
                PlayerBio(bio: StringsStatic.bio('حمزة احمد رجب احمد')),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      _showStats
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  firstChild: StatsGridView(),
                  secondChild: PlayerInfoSection(),
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: AppPadding.smallPadding,
                  decoration: BoxDecoration(
                    color:
                        _showStats
                            ? AppColors.blueAccent
                            : AppColors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _showStats = !_showStats),
                    child: AppText(
                      _showStats ? 'HIDE STATS' : 'SHOW STATS',
                      translate: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
