part of 'countries_cubit.dart';

sealed class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

final class AdminCountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<CountryModel> countries;

  const CountriesLoaded(this.countries);
}

class CountriesError extends CountriesState {
  final String message;

  const CountriesError(this.message);

  @override
  List<Object> get props => [message];
}
