part of 'player_history_cubit.dart';

sealed class PlayerHistoryState extends Equatable {
  const PlayerHistoryState();

  @override
  List<Object> get props => [];
}

final class PlayerHistoryInitial extends PlayerHistoryState {}

final class PlayerHistoryLoading extends PlayerHistoryState {}

final class PlayerNoHistoryFound extends PlayerHistoryState {}

final class PlayerHistoryLoaded extends PlayerHistoryState {
  final List<PlayerHistoryModel> historyList;
  const PlayerHistoryLoaded(this.historyList);
}

final class PlayerHistoryError extends PlayerHistoryState {
  final String error;
  const PlayerHistoryError(this.error);
}
