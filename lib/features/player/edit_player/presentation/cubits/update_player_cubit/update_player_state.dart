part of 'update_player_cubit.dart';

sealed class UpdatePlayerState extends Equatable {
  const UpdatePlayerState();

  @override
  List<Object> get props => [];
}

final class UpdatePlayerInitial extends UpdatePlayerState {}

final class UpdatePlayerLoading extends UpdatePlayerState {}

final class UpdatePlayerSuccess extends UpdatePlayerState {}

final class UpdatePlayerFailure extends UpdatePlayerState {
  final String errorMessage;

  const UpdatePlayerFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class UpdatePlayerImageSuccess extends UpdatePlayerState {
  final String imageUrl;

  const UpdatePlayerImageSuccess(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}
