part of 'save_evaluations_cubit.dart';

sealed class SaveEvaluationsState extends Equatable {
  const SaveEvaluationsState();

  @override
  List<Object> get props => [];
}

final class SaveEvaluationsInitial extends SaveEvaluationsState {}

final class SaveEvaluationsLoading extends SaveEvaluationsState {}

final class SaveEvaluationsError extends SaveEvaluationsState {
  final String message;

  const SaveEvaluationsError(this.message);
}

final class SaveEvaluationsLoaded extends SaveEvaluationsState {
  final EvaluationsModel evaluations;

  const SaveEvaluationsLoaded({required this.evaluations});
}
