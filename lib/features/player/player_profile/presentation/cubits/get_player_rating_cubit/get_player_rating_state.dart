part of 'get_player_rating_cubit.dart';

sealed class GetPlayerRatingState extends Equatable {
  const GetPlayerRatingState();

  @override
  List<Object> get props => [];
}

final class GetPlayerRatingInitial extends GetPlayerRatingState {}

final class GetPlayerRatingLoading extends GetPlayerRatingState {}

final class GetPlayerRatingLoadingIsEmpty extends GetPlayerRatingState {}

final class GetPlayerRatingSuccess extends GetPlayerRatingState {
  final List<PlayerRatingModel> rating;

  const GetPlayerRatingSuccess(this.rating);

  @override
  List<Object> get props => [rating];
}

final class GetPlayerRatingFailure extends GetPlayerRatingState {
  final String error;

  const GetPlayerRatingFailure(this.error);

  @override
  List<Object> get props => [error];
}
