import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/language/lang_keys.dart';

import '../../../data/model/player_profile_model.dart';
import 'player_stats_card.dart';

class StatsGridView extends StatelessWidget {
  const StatsGridView({super.key, required this.player});
  final PlayerProfileModel player;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> stats = [
      {
        'title': LangKeys.matches,
        'value': '15',
        'icon': HugeIcons.strokeRoundedFootballPitch,
      },
      {
        'title': LangKeys.goals,
        'value': '23',
        'icon': HugeIcons.strokeRoundedFootball,
      },
      // يمكنك إضافة المزيد هنا
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length, // عدد الصفوف
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              // العنصر الأول
              Expanded(
                child: PlayerStatsCard(
                  title: stats[index]['title'],
                  value: stats[index]['value'],
                  icon: stats[index]['icon'],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
