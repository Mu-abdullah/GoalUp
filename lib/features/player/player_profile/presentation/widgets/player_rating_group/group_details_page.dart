import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final langCode = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat('dd MMMM yyyy', langCode);

    // تحسين منطق التجميع بالتاريخ
    final Map<String, List<PlayerRatingModel>> groupedByDate =
        <String, List<PlayerRatingModel>>{};

    for (var rating in ratings) {
      try {
        final created = rating.createdAt;
        String dateKey;

        if (created != null && created.isNotEmpty) {
          final date = DateTime.parse(created).toLocal();
          dateKey = dateFormatter.format(date);
        } else {
          dateKey = "غير معروف";
        }

        // استخدام منطق أكثر أماناً للتجميع
        if (groupedByDate.containsKey(dateKey)) {
          groupedByDate[dateKey]!.add(rating);
        } else {
          groupedByDate[dateKey] = [rating];
        }
      } catch (e) {
        debugPrint('خطأ في تحليل التاريخ: $e');
        // إضافة العنصر تحت مفتاح "غير معروف" في حالة الخطأ
        const unknownKey = "غير معروف";
        if (groupedByDate.containsKey(unknownKey)) {
          groupedByDate[unknownKey]!.add(rating);
        } else {
          groupedByDate[unknownKey] = [rating];
        }
      }
    }

    // ترتيب التواريخ من الأحدث إلى الأقدم
    final sortedEntries =
        groupedByDate.entries.toList()..sort((a, b) {
          try {
            if (a.key == "غير معروف") return 1;
            if (b.key == "غير معروف") return -1;

            final dateA = dateFormatter.parse(a.key);
            final dateB = dateFormatter.parse(b.key);
            return dateB.compareTo(dateA); // من الأحدث إلى الأقدم
          } catch (e) {
            return a.key.compareTo(b.key);
          }
        });

    return Scaffold(
      appBar: CustomAppBar(title: categoryName),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sortedEntries.length,
        itemBuilder: (context, index) {
          final entry = sortedEntries[index];
          final date = entry.key;
          final dateRatings = entry.value;

          // طباعة معلومات التشخيص
          debugPrint('التاريخ: $date, عدد العناصر: ${dateRatings.length}');

          // تجميع حسب الفئة مع الحفاظ على جميع العناصر
          final Map<String, List<PlayerRatingModel>> groupedByCategory =
              <String, List<PlayerRatingModel>>{};

          for (var rating in dateRatings) {
            final categoryName = rating.category ?? LangKeys.somethingWentWrong;
            if (groupedByCategory.containsKey(categoryName)) {
              groupedByCategory[categoryName]!.add(rating);
            } else {
              groupedByCategory[categoryName] = [rating];
            }
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              maintainState: true, // مهم جداً لحفظ حالة العناصر
              key: PageStorageKey<String>(
                'expansion_$date',
              ), // مفتاح فريد لكل تاريخ
              title: AppText(
                '$date (${dateRatings.length})',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                translate: false,
              ),
              children:
                  groupedByCategory.entries.map((categoryEntry) {
                    final category = categoryEntry.key;
                    final items = categoryEntry.value;

                    return ListTile(
                      title: AppText(category),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        debugPrint('النقر على $category في تاريخ $date');
                        debugPrint('عدد العناصر: ${items.length}');

                        // طباعة تفاصيل العناصر للتشخيص
                        for (var item in items) {
                          debugPrint(
                            'العنصر: ${item.criteria}, الدرجة: ${item.playerScore}',
                          );
                        }

                        customShowBottomSheet(
                          context: context,
                          title: category,
                          widget: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  date,
                                  fontSize: 18,
                                  isBold: true,
                                  translate: false,
                                ),
                                const SizedBox(height: 12),

                                ...items.map((item) {
                                  return Card(
                                    child: ListTile(
                                      title: AppText(
                                        item.criteria ?? 'غير معروف',
                                      ),
                                      trailing: AppText(
                                        '${item.playerScore ?? 0}',
                                        translate: false,
                                        isBold: true,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
