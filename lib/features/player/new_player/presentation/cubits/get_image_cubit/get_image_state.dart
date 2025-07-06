part of 'get_image_cubit.dart';

sealed class GetImageState extends Equatable {
  const GetImageState();

  @override
  List<Object> get props => [];
}

final class GetImageInitial extends GetImageState {}

final class GetImageLoaded extends GetImageState {}

final class GetImageError extends GetImageState {
  final String message;
  const GetImageError(this.message);
}

final class GetImageLoading extends GetImageState {}

final class UploadImageLoading extends GetImageState {}

final class UploadImageSuccess extends GetImageState {}

final class UploadImageFailed extends GetImageState {
  final String error;
  const UploadImageFailed({required this.error});
}
