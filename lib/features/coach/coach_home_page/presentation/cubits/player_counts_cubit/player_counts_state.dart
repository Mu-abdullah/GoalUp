part of 'player_counts_cubit.dart';

sealed class PlayerCountsState extends Equatable {
  const PlayerCountsState();

  @override
  List<Object> get props => [];
}

final class PlayerCountsInitial extends PlayerCountsState {}

final class PlayerCountsLoading extends PlayerCountsState {}

final class PlayerCountsLoaded extends PlayerCountsState {
  final List<PlayerCountModel> playerCountList;
  const PlayerCountsLoaded(this.playerCountList);
}

final class PlayerCountsError extends PlayerCountsState {
  final String error;
  const PlayerCountsError(this.error);
}
