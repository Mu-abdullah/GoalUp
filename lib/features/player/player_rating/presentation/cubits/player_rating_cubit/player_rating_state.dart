part of 'player_rating_cubit.dart';

class PlayerRatingState extends Equatable {
  final int currentPage;

  const PlayerRatingState({required this.currentPage});

  factory PlayerRatingState.initial() =>
      const PlayerRatingState(currentPage: 0);

  PlayerRatingState copyWith({int? currentPage}) {
    return PlayerRatingState(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object> get props => [currentPage];
}
