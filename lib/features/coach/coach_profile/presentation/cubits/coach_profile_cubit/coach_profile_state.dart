part of 'coach_profile_cubit.dart';

sealed class CoachProfileState extends Equatable {
  const CoachProfileState();

  @override
  List<Object> get props => [];
}

final class CoachProfileInitial extends CoachProfileState {}

final class CoachProfileLoaded extends CoachProfileState {
  final CoachModel coach;
  const CoachProfileLoaded(this.coach);
}

final class CoachProfileLoading extends CoachProfileState {}

final class CoachProfileError extends CoachProfileState {
  final String message;
  const CoachProfileError(this.message);
}
