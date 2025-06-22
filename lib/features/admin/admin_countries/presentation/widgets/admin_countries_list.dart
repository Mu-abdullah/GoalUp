import 'package:flutter/material.dart';

import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/admin_country_model.dart';

class AdminCountriesList extends StatelessWidget {
  const AdminCountriesList({super.key, required this.countries});
  final List<AdminCountryModel> countries;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return ListTile(
          leading: AppText(country.flag!, translate: false, fontSize: 18),
          title: AppText(country.name!, translate: false),
        );
      },
    );
  }
}
