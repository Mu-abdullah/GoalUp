import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/functions/time_refactor.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_history_model.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.player});

  final PlayerHistoryModel player;

  @override
  Widget build(BuildContext context) {
    final (years, months) = TimeRefactor.calculatePeriod(
      player.from!,
      player.to!,
    );
    final lang = context.langCode;

    final yearLabel = _getYearLabel(lang, years);
    final monthLabel = _getMonthLabel(lang, months);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(player.academyLogo!)),
      title: AppText(player.academyName!, translate: false),
      subtitle: Row(
        spacing: 5,
        children: [
          AppText(player.from!, translate: false),
          AppText("-", translate: false),
          AppText(player.to!, translate: false),
          const Spacer(),
          Row(
            children: [
              AppText('$years $yearLabel', translate: false),
              AppText(",", translate: false),
              AppText('$months $monthLabel', translate: false),
            ],
          ),
        ],
      ),
    );
  }

  String _getYearLabel(String lang, int years) {
    if (lang == 'ar') return years >= 10 ? 'سنة' : 'سنوات';
    return years == 1 ? 'Year' : 'Years';
  }

  String _getMonthLabel(String lang, int months) {
    if (lang == 'ar') return months > 10 ? 'شهر' : 'شهور';
    return months == 1 ? 'Month' : 'Months';
  }
}
