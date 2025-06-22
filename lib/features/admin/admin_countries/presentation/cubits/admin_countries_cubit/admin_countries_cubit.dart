import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/model/admin_country_model.dart';
import '../../../data/repo/admin_get_countries.dart';

part 'admin_countries_state.dart';

class AdminCountriesCubit extends Cubit<AdminCountriesState> {
  final AdminGetCountries repo;
  AdminCountriesCubit(this.repo) : super(AdminCountriesInitial());

  Future<void> fetchCountries() async {
    emit(AdminCountriesLoading());
    final result = await repo.getCountries();
    result.fold(
      (error) {
        if (!isClosed) {
          emit(AdminCountriesError(error.message));
          debugPrint('Error fetching countries: ${error.message}');
        }
      },
      (countries) {
        if (!isClosed) {
          emit(AdminCountriesLoaded(countries));
        }
      },
    );
  }
}
