import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_rating_model.dart';

class GroupDetailsPage extends StatelessWidget {
  final String categoryName;
  final List<PlayerRatingModel> ratings;

  const GroupDetailsPage({
    super.key,
    required this.categoryName,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    final groupedByDate = _groupRatingsByDate(context);
    final sortedEntries = _sortGroupedByDate(groupedByDate, context);

    return Scaffold(
      appBar: CustomAppBar(title: categoryName),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sortedEntries.length,
        itemBuilder: (context, index) {
          final entry = sortedEntries[index];
          final date = entry.key;
          final dateRatings = entry.value;

          final groupedByCategory = _groupByCategory(dateRatings);

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              maintainState: true,
              key: PageStorageKey<String>('expansion_$date'),
              title: AppText(
                date,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                translate: false,
              ),
              children:
                  groupedByCategory.entries.map((categoryEntry) {
                    return _buildCategoryTile(
                      context,
                      categoryEntry.key,
                      categoryEntry.value,
                      date,
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }

  /// Group ratings by localized date string
  Map<String, List<PlayerRatingModel>> _groupRatingsByDate(
    BuildContext context,
  ) {
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
      } catch (e) {
        debugPrint('Date parse error: $e');
        key = LangKeys.somethingWentWrong;
      }

      grouped.putIfAbsent(key, () => []).add(rating);
    }

    return grouped;
  }

  /// Sort date entries descending (latest first), unknown last
  List<MapEntry<String, List<PlayerRatingModel>>> _sortGroupedByDate(
    Map<String, List<PlayerRatingModel>> grouped,
    BuildContext context,
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
        return dateB.compareTo(dateA); // descending
      } catch (_) {
        return a.key.compareTo(b.key);
      }
    });

    return entries;
  }

  /// Group ratings by category within a date group
  Map<String, List<PlayerRatingModel>> _groupByCategory(
    List<PlayerRatingModel> list,
  ) {
    final Map<String, List<PlayerRatingModel>> grouped = {};

    for (var rating in list) {
      final key = rating.category ?? LangKeys.somethingWentWrong;
      grouped.putIfAbsent(key, () => []).add(rating);
    }

    return grouped;
  }

  /// Build a category tile inside an expansion panel
  Widget _buildCategoryTile(
    BuildContext context,
    String category,
    List<PlayerRatingModel> items,
    String date,
  ) {
    return ListTile(
      title: AppText(category),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showBottomSheet(context, category, items, date),
    );
  }

  /// Show rating detail bottom sheet
  void _showBottomSheet(
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
            AppText(date, fontSize: 18, isBold: true, translate: false),
            ...items.map(
              (item) => Card(
                child: ListTile(
                  title: AppText(item.criteria ?? LangKeys.somethingWentWrong),
                  trailing: AppText(
                    '${item.playerScore ?? 0} / ${item.maxScore ?? 0}',
                    translate: false,
                    isBold: true,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                AppText(
                  '${context.translate(LangKeys.total)}: ${_sumScores(items)}',
                  fontSize: 16,
                  isBold: true,
                  translate: false,
                ),
                const AppText(
                  ' / ',
                  fontSize: 16,
                  isBold: true,
                  translate: false,
                ),
                AppText(
                  '${_sumMax(items)}',
                  fontSize: 16,
                  isBold: true,
                  translate: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _sumScores(List<PlayerRatingModel> list) =>
      list.fold(0, (sum, r) => sum + (r.playerScore ?? 0));

  int _sumMax(List<PlayerRatingModel> list) =>
      list.fold(0, (sum, r) => sum + (r.maxScore ?? 0));
}
