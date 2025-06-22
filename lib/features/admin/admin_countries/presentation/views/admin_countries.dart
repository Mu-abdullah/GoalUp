import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../data/repo/admin_get_countries.dart';
import '../cubits/admin_countries_cubit/admin_countries_cubit.dart';
import '../refactor/admin_countries_body.dart';

class AdminCountries extends StatelessWidget {
  const AdminCountries({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = locator<AdminGetCountries>();
    return BlocProvider(
      create: (context) => AdminCountriesCubit(repo)..fetchCountries(),
      child: Scaffold(
        appBar: CustomAppBar(title: LangKeys.countries),
        body: const AdminCountriesBody(),
      ),
    );
  }
}
