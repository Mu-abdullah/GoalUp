import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/widgets/app_text.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';
import '../cubits/get_category_cubit/get_category_cubit.dart';
import '../widgets/indecators/page_indecator_steps.dart';
import '../widgets/indecators/page_indecator_buttons.dart';

class PlayerRatingScreenBody extends StatelessWidget {
  const PlayerRatingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageIndicatorSteps(),
        Expanded(
          child: BlocBuilder<GetCategoryCubit, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategoryLoading || state is GetCertinaLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final categoryCubit = context.read<GetCategoryCubit>();
              if (categoryCubit.categories.isEmpty) {
                return const Center(child: Text("No data found"));
              }

              return PageView.builder(
                controller: categoryCubit.controller,
                itemCount: categoryCubit.categories.length,

                itemBuilder: (context, index) {
                  final category = categoryCubit.categories[index];
                  final criteria =
                      categoryCubit.criteriaPerCategory[category.id] ?? [];

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        AppText(category.name ?? 'Category', translate: false),
                        const SizedBox(height: 16),
                        ...criteria.map((crit) {
                          final controller =
                              categoryCubit.scoreControllers[crit.id] ??
                              TextEditingController();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AppTextFormField(
                              controller: controller,
                              type: TextInputType.number,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a score';
                                }
                                final score = double.tryParse(value);
                                if (score == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              label: crit.name ?? 'Criteria',
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        const PageIndicatorButtons(),
      ],
    );
  }
}
// Expanded(
//           child: PageView.builder(
//             controller: cubit.controller,
//             itemCount: cubit.pages.length,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (_, index) => cubit.pages[index],
//           ),
//         ),