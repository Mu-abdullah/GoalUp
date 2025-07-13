import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/certina_model.dart';
import '../../../data/repo/get_category_repo.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  final GetCategoryRepo _repo;

  GetCategoryCubit([GetCategoryRepo? repo])
    : _repo = repo ?? GetCategoryRepo(),
      super(GetCategoryInitial());

  static GetCategoryCubit get(BuildContext context) =>
      BlocProvider.of<GetCategoryCubit>(context);

  Future<void> init() async {
    emit(GetCategoryLoading());
    try {
      final categoryResult = await _repo.getCategories();
      final criteriaResult = await _repo.getCriteria();

      categoryResult.fold((error) => emit(GetCategoryError(error.message)), (
        categories,
      ) {
        criteriaResult.fold(
          (error) => emit(GetCategoryError(error.message)),
          (criteria) => emit(
            GetCategoryLoaded(categories: categories, criteria: criteria),
          ),
        );
      });
    } catch (e) {
      emit(GetCategoryError(e.toString()));
    }
  }
}
