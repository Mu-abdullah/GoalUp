part of 'share_info_cubit.dart';

sealed class ShareInfoState extends Equatable {
  const ShareInfoState();

  @override
  List<Object> get props => [];
}

final class ShareInfoInitial extends ShareInfoState {}

final class ShareInfoLoading extends ShareInfoState {}

final class ShareInfoLoaded extends ShareInfoState {
  final UserInfoModel playerInfo;
  const ShareInfoLoaded(this.playerInfo);
}

final class ShareInfoError extends ShareInfoState {
  final String error;
  const ShareInfoError(this.error);
}
