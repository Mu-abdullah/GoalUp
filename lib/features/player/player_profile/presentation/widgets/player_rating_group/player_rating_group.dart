import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../../data/model/player_rating_model.dart';
import '../../cubits/get_player_rating_cubit/get_player_rating_cubit.dart';
import 'player_rating_group_summary.dart';

class PlayerRatingGroup extends StatelessWidget {
  const PlayerRatingGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayerRatingCubit, GetPlayerRatingState>(
      builder: (context, state) {
        if (state is GetPlayerRatingLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.blueAccent),
              const SizedBox(width: 10),
              AppText(LangKeys.loading),
            ],
          );
        } else if (state is GetPlayerRatingLoadingIsEmpty) {
          return const Center(child: AppText(LangKeys.noDataFound));
        } else if (state is GetPlayerRatingFailure) {
          return Center(
            child: AppText(
              '${context.tr(LangKeys.somethingWentWrong)} ${state.error}',
              translate: false,
            ),
          );
        } else if (state is GetPlayerRatingSuccess) {
          final ratings = state.rating;

          final Map<String, List<PlayerRatingModel>> groupedByCategory = {};

          for (var rating in ratings) {
            final categoryName = rating.category ?? 'بدون اسم';
            if (!groupedByCategory.containsKey(categoryName)) {
              groupedByCategory[categoryName] = [];
            }
            groupedByCategory[categoryName]!.add(rating);
          }

          return GroupSummaryPage(ratings: ratings);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
