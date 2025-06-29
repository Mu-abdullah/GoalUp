import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/model/country_model.dart';
import '../../../data/repo/get_countries.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final GetCountries repo;
  CountriesCubit(this.repo) : super(AdminCountriesInitial());

  Future<void> fetchCountries() async {
    emit(CountriesLoading());
    final result = await repo.getCountries();
    result.fold(
      (error) {
        if (!isClosed) {
          emit(CountriesError(error.message));
          debugPrint('Error fetching countries: ${error.message}');
        }
      },
      (countries) {
        if (!isClosed) {
          emit(CountriesLoaded(countries));
        }
      },
    );
  }
}
