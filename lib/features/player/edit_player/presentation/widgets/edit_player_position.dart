import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/custom_widgets/custom_drop_menu.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../new_player/data/model/position_model.dart';
import '../../../new_player/presentation/cubits/get_positions_cubit/get_positions_cubit.dart';
import '../cubits/update_cubit/update_cubit.dart';

class EditPlayerPosition extends StatelessWidget {
  const EditPlayerPosition({super.key, required this.cubit});

  final UpdateCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPositionsCubit, GetPositionsState>(
      builder: (context, state) {
        if (state is GetPositionsLoading) {
          return LoadingShimmer();
        } else if (state is GetPositionsLoaded) {
          return GenericDropdown(
            items: state.positions,
            getDisplayText: (PositionModel country) => country.code!,
            onChanged: (v) {
              if (v != null) {
                cubit.position = v.code!;
                debugPrint('position ${cubit.position}');
              }
            },
            hint: cubit.position ?? cubit.player.position!,
            trHint: false,
          );
        } else if (state is GetPositionsError) {
          return AppText(state.message);
        } else {
          return LoadingShimmer();
        }
      },
    );
  }
}
