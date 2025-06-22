part of 'admin_countries_cubit.dart';

sealed class AdminCountriesState extends Equatable {
  const AdminCountriesState();

  @override
  List<Object> get props => [];
}

final class AdminCountriesInitial extends AdminCountriesState {}

class AdminCountriesLoading extends AdminCountriesState {}

class AdminCountriesLoaded extends AdminCountriesState {
  final List<AdminCountryModel> countries;

  const AdminCountriesLoaded(this.countries);
}

class AdminCountriesError extends AdminCountriesState {
  final String message;

  const AdminCountriesError(this.message);

  @override
  List<Object> get props => [message];
}
