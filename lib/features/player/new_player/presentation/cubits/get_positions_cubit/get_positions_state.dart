part of 'get_positions_cubit.dart';

sealed class GetPositionsState extends Equatable {
  const GetPositionsState();

  @override
  List<Object> get props => [];
}

final class GetPositionsInitial extends GetPositionsState {}

final class GetPositionsLoading extends GetPositionsState {}

final class GetPositionsLoaded extends GetPositionsState {
  final List<PositionModel> positions;

  const GetPositionsLoaded(this.positions);
}

final class GetPositionsError extends GetPositionsState {
  final String message;
  const GetPositionsError(this.message);
}
