part of 'create_player_cubit.dart';

sealed class CreatePlayerState extends Equatable {
  const CreatePlayerState();

  @override
  List<Object> get props => [];
}

final class CreatePlayerInitial extends CreatePlayerState {}

final class CreatePlayerLoading extends CreatePlayerState {}

final class CreatePlayerLoaded extends CreatePlayerState {
  final CreateNewPlayer player;
  const CreatePlayerLoaded(this.player);
}

final class CreatePlayerError extends CreatePlayerState {
  final String message;
  const CreatePlayerError(this.message);
}
