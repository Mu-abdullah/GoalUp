part of 'register_new_player_cubit.dart';

sealed class RegisterNewPlayerState extends Equatable {
  const RegisterNewPlayerState();

  @override
  List<Object> get props => [];
}

final class RegisterNewPlayerInitial extends RegisterNewPlayerState {}

final class RegisterNewPlayerLoading extends RegisterNewPlayerState {}

final class RegisterNewPlayerError extends RegisterNewPlayerState {
  final String message;

  const RegisterNewPlayerError(this.message);
}

final class RegisterNewPlayerDone extends RegisterNewPlayerState {
  final CreateAcademyPlayer player;

  const RegisterNewPlayerDone(this.player);
}
