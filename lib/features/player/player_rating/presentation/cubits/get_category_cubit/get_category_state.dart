part of 'get_category_cubit.dart';

abstract class GetCategoryState {}

class GetCategoryInitial extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryLoaded extends GetCategoryState {
  final List<CategoryModel> categories;
  final List<CriteriaModel> criteria;

  GetCategoryLoaded({required this.categories, required this.criteria});

  List<CriteriaModel> getCriteriaForCategory(String categoryId) {
    return criteria.where((c) => c.category == categoryId).toList();
  }
}

class GetCategoryError extends GetCategoryState {
  final String message;
  GetCategoryError(this.message);
}
