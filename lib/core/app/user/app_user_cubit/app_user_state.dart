part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends AppUserState {}

final class UserProfileLoading extends AppUserState {}

// final class UserProfileLoaded extends AppUserState {
//   final EmpModel user;

//   const UserProfileLoaded(this.user);

//   @override
//   List<Object> get props => [user];
// }

final class UserProfileError extends AppUserState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class UserLoggedOut extends AppUserState {}
