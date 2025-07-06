import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/certina_model.dart';
import '../../../data/repo/get_category_repo.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  final GetCategoryRepo _repo = GetCategoryRepo();

  GetCategoryCubit() : super(GetCategoryInitial());

  static GetCategoryCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> categories = [];
  List<CriteriaModel> criteria = [];

  final Map<String, List<CriteriaModel>> criteriaPerCategory = {};
  final Map<String, TextEditingController> scoreControllers = {};
  final PageController controller = PageController();

  Future<void> init() async {
    final fetchedCategories = await fetchCategories();
    final fetchedCriteria = await fetchCriteria();

    for (final cat in fetchedCategories) {
      criteriaPerCategory[cat.id!] =
          fetchedCriteria.where((c) => c.id == cat.id).toList();
    }

    for (var crit in fetchedCriteria) {
      scoreControllers[crit.id!] = TextEditingController();
    }

    emit(GetCategoryInitial());
  }

  Future<List<CategoryModel>> fetchCategories() async {
    emit(GetCategoryLoading());
    final result = await _repo.getCategories();

    return result.fold(
      (error) {
        if (!isClosed) emit(GetCategoryError(error.message));
        return [];
      },
      (data) {
        if (!isClosed) {
          categories = data;
          emit(GetCategoryLoaded(data));
        }
        return data;
      },
    );
  }

  Future<List<CriteriaModel>> fetchCriteria() async {
    emit(GetCertinaLoading());
    final result = await _repo.getCriteria();

    return result.fold(
      (error) {
        if (!isClosed) emit(GetCertinaError(error.message));
        return [];
      },
      (data) {
        if (!isClosed) {
          criteria = data;
          emit(GetCertinaLoaded(data));
        }
        return data;
      },
    );
  }
}
