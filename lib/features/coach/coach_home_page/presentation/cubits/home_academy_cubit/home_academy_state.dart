part of 'home_academy_cubit.dart';

sealed class HomeAcademyState extends Equatable {
  const HomeAcademyState();

  @override
  List<Object> get props => [];
}

final class CoachHomeInitial extends HomeAcademyState {}

final class HomeAcademyLoading extends HomeAcademyState {}

final class HomeAcademyLoaded extends HomeAcademyState {
  final HomeAcademyModel academy;
  const HomeAcademyLoaded(this.academy);
}

final class HomeAcademError extends HomeAcademyState {
  final String message;
  const HomeAcademError(this.message);
}
