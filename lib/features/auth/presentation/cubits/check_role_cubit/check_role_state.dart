part of 'check_role_cubit.dart';

sealed class CheckRoleState extends Equatable {
  const CheckRoleState();

  @override
  List<Object> get props => [];
}

final class CheckRoleInitial extends CheckRoleState {}

final class CheckRoleLoading extends CheckRoleState {}

final class CheckRoleLoaded extends CheckRoleState {
  const CheckRoleLoaded();

  @override
  List<Object> get props => [];
}

final class CheckRoleError extends CheckRoleState {
  final String message;

  const CheckRoleError({required this.message});

  @override
  List<Object> get props => [message];
}
