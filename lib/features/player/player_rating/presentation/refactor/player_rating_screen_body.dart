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
      // ignore: unused_local_variable
      for (var criterion in criteria) {
        final controller = TextEditingController();
        final formKey = GlobalKey<FormState>();
        _controllersMap[category.id]!.add(controller);
        _formKeysMap[category.id]!.add(formKey);
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
          return Center(child: CircularProgressIndicator());
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
                  var cubit = SaveEvaluationsCubit.get(context);
                  return Padding(
                    padding: AppPadding.symmetric(),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: AppButton(
                            isDisabled: _currentPage == 0,
                            text: LangKeys.previous,
                            onTap: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            text:
                                _currentPage == state.categories.length - 1
                                    ? LangKeys.confirm
                                    : LangKeys.next,
                            onTap: () async {
                              // Get current category data
                              final currentCategory =
                                  state.categories[_currentPage];
                              final criteria = state.getCriteriaForCategory(
                                currentCategory.id!,
                              );
                              final controllers =
                                  _controllersMap[currentCategory.id] ?? [];
                              final formKeys =
                                  _formKeysMap[currentCategory.id] ?? [];

                              // Validate current page
                              bool isValid = true;
                              for (final formKey in formKeys) {
                                if (formKey.currentState?.validate() != true) {
                                  isValid = false;
                                }
                              }

                              if (!isValid) {
                                CustomSnackbar.showTopSnackBar(
                                  context,
                                  message: LangKeys.requiredValue,
                                  isError: true,
                                );
                                return;
                              }

                              // Save current page data
                              for (int i = 0; i < criteria.length; i++) {
                                final criterion = criteria[i];
                                final controller = controllers[i];
                                final score = controller.text.trim();

                                final evaluation = EvaluationsModel(
                                  id: GenerateId.generateDocumentId(
                                    academy: appUser.academyId,
                                    table: BackendPoint.evaluations,
                                    count: i, // Use index for uniqueness
                                  ),
                                  createdAt: DateTime.now().toIso8601String(),
                                  criteria: criterion.id,
                                  player:
                                      "EG-AL-EGA-001", // Replace with actual player ID
                                  playerScore: int.parse(score),
                                );

                                cubit.addEvaluations(evaluation.toJson()).then((
                                  onValue,
                                ) {
                                  if (context.mounted) {
                                    CustomSnackbar.showTopSnackBar(
                                      context,
                                      message: LangKeys.addSuccessfully,
                                      isError: false,
                                    );
                                  }
                                });
                              }

                              // Navigate to next page or finish
                              if (_currentPage < state.categories.length - 1) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                // All pages completed
                                CustomSnackbar.showTopSnackBar(
                                  context,
                                  message: LangKeys.addSuccessfully,
                                  isError: false,
                                );
                                // Optionally navigate back
                                // Navigator.pop(context);
                              }
                            },
                            backGroungColor:
                                _currentPage == state.categories.length - 1
                                    ? AppColors.green
                                    : AppColors.black,
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(category.name!, fontSize: 24, fontWeight: FontWeight.bold),
          SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: criteria.length,
            itemBuilder: (context, index) {
              final criterion = criteria[index];
              final formKey = _formKeysMap[category.id]?[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: AppTextFormField(
                    label: criterion.name!,

                    controller: controllers[index],
                    type: TextInputType.number,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return context.translate(LangKeys.requiredValue);
                      } else if (int.parse(criterion.max!) < int.parse(v)) {
                        return "${context.translate(LangKeys.valueShouldBeLessThan)} ${criterion.max}";
                      }
                      return null;
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
}
