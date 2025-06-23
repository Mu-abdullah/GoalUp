part of 'coach_players_cubit.dart';

sealed class CoachPlayersState extends Equatable {
  const CoachPlayersState();

  @override
  List<Object> get props => [];
}

final class CoachPlayersInitial extends CoachPlayersState {}

final class CoachPlayersLoading extends CoachPlayersState {}

final class CoachPlayersLoaded extends CoachPlayersState {
  final List<GetPlayersModel> players;

  const CoachPlayersLoaded({required this.players});

  @override
  List<Object> get props => [players];
}
final class CoachPlayersError extends CoachPlayersState {
  final String message;

  const CoachPlayersError({required this.message});

  @override
  List<Object> get props => [message];
}