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
