part of 'new_player_cubit.dart';

sealed class NewPlayerState extends Equatable {
  const NewPlayerState();

  @override
  List<Object> get props => [];
}

final class NewPlayerInitial extends NewPlayerState {}
