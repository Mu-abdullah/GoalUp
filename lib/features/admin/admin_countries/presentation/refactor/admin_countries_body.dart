import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/admin_countries_cubit/admin_countries_cubit.dart';
import '../widgets/admin_countries_list.dart';

class AdminCountriesBody extends StatelessWidget {
  const AdminCountriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCountriesCubit, AdminCountriesState>(
      builder: (context, state) {
        if (state is AdminCountriesLoading) {
          return const Center(
            child: LoadingShimmer(itemCount: 22, height: 0.1),
          );
        } else if (state is AdminCountriesLoaded) {
          return AdminCountriesList(countries: state.countries);
        } else if (state is AdminCountriesError) {
          return Center(child: AppText(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
