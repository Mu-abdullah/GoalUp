part of 'update_image_cubit.dart';

sealed class UpdateImageState extends Equatable {
  const UpdateImageState();

  @override
  List<Object> get props => [];
}

final class UpdateImageInitial extends UpdateImageState {}

final class GetImageLoading extends UpdateImageState {}

final class GetImageLoaded extends UpdateImageState {}

final class GetImageError extends UpdateImageState {
  final String message;
  const GetImageError(this.message);
}