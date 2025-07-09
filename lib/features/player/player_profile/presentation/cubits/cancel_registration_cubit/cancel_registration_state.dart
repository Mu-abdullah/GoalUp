part of 'cancel_registration_cubit.dart';

sealed class CancelRegistrationState extends Equatable {
  const CancelRegistrationState();

  @override
  List<Object> get props => [];
}

final class CancelRegistrationInitial extends CancelRegistrationState {}

final class CancelRegistrationLoading extends CancelRegistrationState {}

final class CancelRegistrationDone extends CancelRegistrationState {
  final bool isDone;
  const CancelRegistrationDone(this.isDone);
}

final class CancelRegistrationError extends CancelRegistrationState {
  final String error;
  const CancelRegistrationError(this.error);
}
