part of 'user_auth_cubit.dart';

sealed class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object> get props => [];
}

final class UserAuthInitial extends UserAuthState {}

final class CheckUserLoading extends UserAuthState {}

final class CheckUserError extends UserAuthState {
  final String message;
  const CheckUserError(this.message);
}

final class UserExists extends UserAuthState {
  final UserAuthModel user;

  const UserExists(this.user);
}

final class UserNotExists extends UserAuthState {}
