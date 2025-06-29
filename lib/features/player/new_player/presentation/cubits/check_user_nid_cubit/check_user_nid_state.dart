part of 'check_user_nid_cubit.dart';

sealed class CheckUserNidState extends Equatable {
  const CheckUserNidState();

  @override
  List<Object> get props => [];
}

final class CheckUserNidInitial extends CheckUserNidState {}

final class CheckUserNidLoading extends CheckUserNidState {}

final class CheckUserNidEmpty extends CheckUserNidState {
  final String message;

  const CheckUserNidEmpty(this.message);
}

final class CheckUserNidError extends CheckUserNidState {
  final String message;
  const CheckUserNidError(this.message);
}

final class CheckUserNidLoaded extends CheckUserNidState {
  final NewPlayerModel user;

  const CheckUserNidLoaded(this.user);
}
