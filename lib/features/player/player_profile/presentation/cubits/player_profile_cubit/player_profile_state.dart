part of 'player_profile_cubit.dart';

sealed class PlayerProfileState extends Equatable {
  const PlayerProfileState();

  @override
  List<Object> get props => [];
}

final class PlayerProfileInitial extends PlayerProfileState {}

final class PlayerProfileLoading extends PlayerProfileState {}

final class PlayerProfileLoaded extends PlayerProfileState {
  final PlayerProfileModel playerProfile;

  const PlayerProfileLoaded(this.playerProfile);

  @override
  List<Object> get props => [playerProfile];
}

final class PlayerProfileError extends PlayerProfileState {
  final String error;

  const PlayerProfileError(this.error);

  @override
  List<Object> get props => [error];
}
