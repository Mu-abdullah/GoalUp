part of 'cancel_registration_cubit.dart';

sealed class CancelRegistrationState extends Equatable {
  const CancelRegistrationState();

  @override
  List<Object> get props => [];
}

final class CancelRegistrationInitial extends CancelRegistrationState {}

class CancelRegistrationLoading extends CancelRegistrationState {}

class CancelRegistrationDone extends CancelRegistrationState {}

class CancelRegistrationError extends CancelRegistrationState {
  final String error;
  const CancelRegistrationError(this.error);
}

class AddToHistoryLoading extends CancelRegistrationState {}

class AddToHistoryDone extends CancelRegistrationState {
  final AddHistoryModel history;
  const AddToHistoryDone(this.history);
}

class AddToHistoryError extends CancelRegistrationState {
  final String error;
  const AddToHistoryError(this.error);
}
