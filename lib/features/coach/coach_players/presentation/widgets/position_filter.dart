import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/get_players_model.dart';
import '../cubits/coach_players_cubit/coach_players_cubit.dart';

class PositionFilter extends StatelessWidget {
  const PositionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CoachPlayersCubit.get(context);
    final positions = _extractCategories(cubit.players);
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: positions.length,
        itemBuilder: (context, index) {
          final position = positions[index];
          final isSelected = cubit.selectedPosition == position;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FilterChip(
              label: AppText(
                position,
                tr: false,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
              selected: isSelected,
              selectedColor: AppColors.black,
              checkmarkColor: isSelected ? AppColors.white : AppColors.black,
              elevation: 8,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onSelected: (selected) {
                cubit.filterByPosition(position);
              },
            ),
          );
        },
      ),
    );
  }

  List<String> _extractCategories(final List<GetPlayersModel> players) {
    Set<String> uniquePositions = players.map((item) => item.position!).toSet();
    return uniquePositions.toList();
  }
}
