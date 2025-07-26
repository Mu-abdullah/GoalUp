import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_rating_model.dart';

class GroupSummaryPage extends StatelessWidget {
  final List<PlayerRatingModel> ratings;

  const GroupSummaryPage({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<PlayerRatingModel>> groupedByCategory = {};

    for (var rating in ratings) {
      final categoryName = rating.category ?? LangKeys.somethingWentWrong;
      groupedByCategory.putIfAbsent(categoryName, () => []).add(rating);
    }

    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(LangKeys.playerRatingSummary, isBold: true),
            TextButton(
              onPressed: () {
                context.pushNamed(
                  RoutesNames.groupRatingScreen,
                  arguments: {
                    'ratings': ratings,
                    'categoryName': LangKeys.playerRatingSummary,
                  },
                );
              },
              child: AppText(LangKeys.showAll, isBold: true),
            ),
          ],
        ),
        GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children:
              groupedByCategory.entries.map((entry) {
                final categoryName = entry.key;
                final total = entry.value.fold<int>(
                  0,
                  (sum, r) => sum + (r.playerScore ?? 0),
                );

                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0.95, end: 1.0),
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.black.withValues(alpha: 0.1),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -10,
                            right: -10,
                            child: Icon(
                              Icons.category_outlined,
                              size: 60,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: AppText(
                                      categoryName,
                                      maxLines: 3,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                TweenAnimationBuilder(
                                  duration: const Duration(milliseconds: 800),
                                  tween: IntTween(begin: 0, end: total),
                                  builder: (context, value, child) {
                                    return AppText(
                                      '$value',
                                      color: AppColors.black,
                                      translate: false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
