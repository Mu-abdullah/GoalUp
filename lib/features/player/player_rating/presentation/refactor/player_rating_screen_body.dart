import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/functions/generate_id.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/supabase/backend_points.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';
import '../../data/model/category_model.dart';
import '../../data/model/certina_model.dart';
import '../../data/model/evaluations_model.dart';
import '../cubits/get_category_cubit/get_category_cubit.dart';
import '../cubits/save_evaluations_cubit/save_evaluations_cubit.dart';
import '../widgets/indecators/page_indecator_steps.dart';

class CategoryCriteriaScreen extends StatefulWidget {
  const CategoryCriteriaScreen({super.key});

  @override
  State<CategoryCriteriaScreen> createState() => _CategoryCriteriaScreenState();
}

class _CategoryCriteriaScreenState extends State<CategoryCriteriaScreen> {
  late final GetCategoryCubit _cubit;
  final Map<String, List<TextEditingController>> _controllersMap = {};
  final Map<String, List<GlobalKey<FormState>>> _formKeysMap = {};
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _cubit = GetCategoryCubit.get(context);
    _cubit.init();
  }

  @override
  void dispose() {
    _disposeControllers();
    _pageController.dispose();
    _formKeysMap.clear();
    super.dispose();
  }

  void _disposeControllers() {
    for (var controllers in _controllersMap.values) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    _controllersMap.clear();
  }

  void _initializeControllers(GetCategoryLoaded state) {
    _disposeControllers();

    for (var category in state.categories) {
      final criteria = state.getCriteriaForCategory(category.id!);
      _controllersMap[category.id!] = [];
      _formKeysMap[category.id!] = [];
      for (var _ in criteria) {
        _controllersMap[category.id!]!.add(TextEditingController());
        _formKeysMap[category.id!]!.add(GlobalKey<FormState>());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appUser = AppUserCubit.get(context);
    return BlocConsumer<GetCategoryCubit, GetCategoryState>(
      listener: (context, state) {
        if (state is GetCategoryLoaded) {
          _initializeControllers(state);
        }
      },
      builder: (context, state) {
        if (state is GetCategoryInitial || state is GetCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetCategoryError) {
          return Center(child: AppText(state.message));
        }

        if (state is GetCategoryLoaded) {
          return Column(
            children: [
              GlobalPageIndicator(
                currentPage: _currentPage,
                totalPages: state.categories.length,
                activeColor: AppColors.green,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.categories.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    final category = state.categories[pageIndex];
                    final criteria = state.getCriteriaForCategory(category.id!);
                    final controllers = _controllersMap[category.id] ?? [];

                    return _buildCategoryPage(category, criteria, controllers);
                  },
                ),
              ),
              BlocBuilder<SaveEvaluationsCubit, SaveEvaluationsState>(
                builder: (context, s) {
                  final cubit = SaveEvaluationsCubit.get(context);
                  return Padding(
                    padding: AppPadding.symmetric(),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: AppButton(
                            isLoading: s is SaveEvaluationsLoading,
                            isDisabled:
                                _currentPage == 0 ||
                                s is SaveEvaluationsLoading,
                            text: LangKeys.previous,
                            onTap: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            isLoading: s is SaveEvaluationsLoading,
                            text:
                                _currentPage == state.categories.length - 1
                                    ? LangKeys.confirm
                                    : LangKeys.next,
                            backGroungColor:
                                _currentPage == state.categories.length - 1
                                    ? AppColors.green
                                    : AppColors.black,
                            onTap: () async {
                              if (_currentPage == state.categories.length - 1) {
                                await _submitEvaluations(
                                  context: context,
                                  state: state,
                                  appUser: appUser,
                                  cubit: cubit,
                                );
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCategoryPage(
    CategoryModel category,
    List<CriteriaModel> criteria,
    List<TextEditingController> controllers,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(category.name!, fontSize: 24, fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: criteria.length,
            itemBuilder: (context, index) {
              final criterion = criteria[index];
              final formKey = _formKeysMap[category.id]?[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: AppTextFormField(
                    label: criterion.name!,
                    controller: controllers[index],
                    type: TextInputType.number,
                    validate: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return context.translate(LangKeys.requiredValue);
                      } else if (int.tryParse(v.trim()) == null) {
                        return context.translate(LangKeys.mustBeNumber);
                      } else if (int.parse(v.trim()) >
                          int.parse(criterion.max!)) {
                        return "${context.translate(LangKeys.valueShouldBeLessThan)} ${criterion.max}";
                      }
                      return null;
                    },
                    onChange: (v) {
                      final input = v.trim();
                      if (int.tryParse(input) == null) {
                        CustomSnackbar.showTopSnackBar(
                          context,
                          message: LangKeys.mustBeNumber,
                          isError: true,
                        );
                        controllers[index].clear();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submitEvaluations({
    required BuildContext context,
    required GetCategoryLoaded state,
    required AppUserCubit appUser,
    required SaveEvaluationsCubit cubit,
  }) async {
    final List<Map<String, dynamic>> allEvaluations = [];

    try {
      for (final category in state.categories) {
        final criteria = state.getCriteriaForCategory(category.id!);
        final controllers = _controllersMap[category.id] ?? [];

        for (int i = 0; i < criteria.length; i++) {
          final controller = controllers[i];
          final criterion = criteria[i];
          final score =
              controller.text.trim() == '' ? '0' : controller.text.trim();

          final evaluation = EvaluationsModel(
            id: GenerateId.generateDocumentId(
              academy: appUser.academyId,
              table: BackendPoint.evaluations,
              count: allEvaluations.length + 1,
            ),
            createdAt: DateTime.now().toString(),
            criteria: criterion.id,
            player: cubit.playerId,
            playerScore: int.parse(score),
          );

          allEvaluations.add(evaluation.toJson());
        }
      }

      await cubit.addEvaluations(allEvaluations);

      if (context.mounted) {
        CustomSnackbar.showTopSnackBar(
          context,
          message: LangKeys.addSuccessfully,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar.showTopSnackBar(
          context,
          message: e.toString(),
          isError: true,
        );
      }
    }
  }
}
