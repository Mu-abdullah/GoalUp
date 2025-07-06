part of 'get_category_cubit.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryLoading extends GetCategoryState {}

final class GetCategoryLoaded extends GetCategoryState {
  final List<CategoryModel> categories;

  const GetCategoryLoaded(this.categories);
}

final class GetCategoryError extends GetCategoryState {
  final String error;

  const GetCategoryError(this.error);
}

final class GetCertinaLoading extends GetCategoryState {}

final class GetCertinaLoaded extends GetCategoryState {
  final List<CriteriaModel> certinaModel;
  const GetCertinaLoaded(this.certinaModel);
}

final class GetCertinaError extends GetCategoryState {
  final String message;
  const GetCertinaError(this.message);
}
