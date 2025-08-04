import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sport/core/extextions/extentions.dart';
import 'package:sport/core/style/color/app_color.dart';
import 'package:sport/core/style/widgets/custom_divider.dart';

import '../../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_profile_model.dart';
import '../../../data/model/player_rating_model.dart';

class GroupDetailsPage extends StatelessWidget {
  final String categoryName;
  final List<PlayerRatingModel> ratings;
  final PlayerProfileModel player;

  const GroupDetailsPage({
    super.key,
    required this.categoryName,
    required this.ratings,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final grouper = RatingGrouper(context, ratings);
    final sortedEntries = grouper.groupAndSortByDate();
    final isCoach = player.academyId == AppUserCubit.get(context).academyId;

    return Scaffold(
      appBar: CustomAppBar(
        title: categoryName,
        actions: [
          if (isCoach)
            IconButton(
              icon: const Icon(HugeIcons.strokeRoundedAddCircle),
              onPressed: () {
                context.pushNamed(
                  RoutesNames.playerRatingScreen,
                  arguments: {'playerId': player.id, 'playerName': player.name},
                );
              },
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sortedEntries.length,
        itemBuilder: (context, index) {
          final entry = sortedEntries[index];
          final date = entry.key;
          final dateRatings = entry.value;

          final categoryGroups = RatingGrouper.groupByCategory(dateRatings);

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              maintainState: true,
              key: PageStorageKey<String>('expansion_$date'),
              title: AppText(
                "$date ${RatingWidgetsBuilder._sumScores(dateRatings)} / ${RatingWidgetsBuilder._sumMax(dateRatings)}",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                tr: false,
              ),
              children:
                  categoryGroups.entries.map((entry) {
                    return RatingWidgetsBuilder.buildCategoryTile(
                      context: context,
                      category: entry.key,
                      items: entry.value,
                      date: date,
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class RatingGrouper {
  final BuildContext context;
  final List<PlayerRatingModel> ratings;

  RatingGrouper(this.context, this.ratings);

  List<MapEntry<String, List<PlayerRatingModel>>> groupAndSortByDate() {
    final grouped = _groupByDate();
    return _sortGroupedByDate(grouped);
  }

  Map<String, List<PlayerRatingModel>> _groupByDate() {
    final formatter = DateFormat(
      'dd MMMM yyyy',
      Localizations.localeOf(context).languageCode,
    );
    final Map<String, List<PlayerRatingModel>> grouped = {};

    for (var rating in ratings) {
      final rawDate = rating.evaluationDay;
      String key;

      try {
        if (rawDate != null && rawDate.isNotEmpty) {
          final date = DateTime.parse(rawDate).toLocal();
          key = formatter.format(date);
        } else {
          key = LangKeys.somethingWentWrong;
        }
      } catch (_) {
        key = LangKeys.somethingWentWrong;
      }

      grouped.putIfAbsent(key, () => []).add(rating);
    }

    return grouped;
  }

  List<MapEntry<String, List<PlayerRatingModel>>> _sortGroupedByDate(
    Map<String, List<PlayerRatingModel>> grouped,
  ) {
    final formatter = DateFormat(
      'dd MMMM yyyy',
      Localizations.localeOf(context).languageCode,
    );
    final entries = grouped.entries.toList();

    entries.sort((a, b) {
      if (a.key == LangKeys.somethingWentWrong) return 1;
      if (b.key == LangKeys.somethingWentWrong) return -1;

      try {
        final dateA = formatter.parse(a.key);
        final dateB = formatter.parse(b.key);
        return dateB.compareTo(dateA);
      } catch (_) {
        return a.key.compareTo(b.key);
      }
    });

    return entries;
  }

  static Map<String, List<PlayerRatingModel>> groupByCategory(
    List<PlayerRatingModel> list,
  ) {
    final Map<String, List<PlayerRatingModel>> grouped = {};
    for (var rating in list) {
      final key = rating.category ?? LangKeys.somethingWentWrong;
      grouped.putIfAbsent(key, () => []).add(rating);
    }
    return grouped;
  }
}

class RatingWidgetsBuilder {
  static Widget buildCategoryTile({
    required BuildContext context,
    required String category,
    required List<PlayerRatingModel> items,
    required String date,
  }) {
    final average =
        (items.fold<double>(0, (sum, r) => sum + (r.playerScore ?? 0)) /
                items.length)
            .round();

    return ListTile(
      title: AppText(category),
      subtitle: AppText(
        '${context.tr(LangKeys.ratingAverage)} : $average',
        tr: false,
        isBold: true,
        color: AppColors.grey,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showBottomSheet(context, category, items, date),
    );
  }

  static void _showBottomSheet(
    BuildContext context,
    String category,
    List<PlayerRatingModel> items,
    String date,
  ) {
    customShowBottomSheet(
      context: context,
      title: category,
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(date, fontSize: 18, isBold: true, tr: false),
            ...items.map(
              (item) => Card(
                child: ListTile(
                  title: AppText(item.criteria ?? LangKeys.somethingWentWrong),
                  trailing: AppText(
                    '${item.playerScore ?? 0} / ${item.maxScore ?? 0}',
                    tr: false,
                    isBold: true,
                  ),
                ),
              ),
            ),
            CustomDivider(),
            ListTile(
              title: AppText(LangKeys.total),
              trailing: AppText(
                '${_sumScores(items)} / ${_sumMax(items)}',
                tr: false,
                isBold: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int _sumScores(List<PlayerRatingModel> list) =>
      list.fold(0, (sum, r) => sum + (r.playerScore ?? 0));

  static int _sumMax(List<PlayerRatingModel> list) =>
      list.fold(0, (sum, r) => sum + (r.maxScore ?? 0));
}
