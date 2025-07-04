import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_drop_menu.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/country_model.dart';
import '../../data/model/position_model.dart';
import '../cubits/countries_cubit/countries_cubit.dart';
import '../cubits/get_positions_cubit/get_positions_cubit.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';

class ChooseNational extends StatelessWidget {
  const ChooseNational({super.key, required this.cubit});
  final NewPlayerCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          flex: 2,
          child: BlocBuilder<CountriesCubit, CountriesState>(
            builder: (context, state) {
              if (state is CountriesLoading) {
                return LoadingShimmer();
              } else if (state is CountriesLoaded) {
                return GenericDropdown(
                  items: state.countries,
                  getDisplayText:
                      (CountryModel country) =>
                          "${country.flag} ${country.name}",
                  onChanged: (v) {
                    if (v != null) {
                      cubit.national = v.name!;
                    }
                  },
                  hint: LangKeys.country,
                );
              } else if (state is CountriesError) {
                return Text(state.message);
              } else {
                return LoadingShimmer();
              }
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<GetPositionsCubit, GetPositionsState>(
            builder: (context, state) {
              if (state is GetPositionsLoading) {
                return LoadingShimmer();
              } else if (state is GetPositionsLoaded) {
                return GenericDropdown(
                  items: state.positions,
                  getDisplayText: (PositionModel country) => country.code!,
                  onChanged: (v) {
                    if (v != null) {
                      cubit.national = v.name!;
                    }
                  },
                  hint: LangKeys.position,
                );
              } else if (state is GetPositionsError) {
                return AppText(state.message);
              } else {
                return LoadingShimmer();
              }
            },
          ),
        ),
      ],
    );
  }
}
