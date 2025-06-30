import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../../core/style/widgets/app_text.dart';
import '../../cubits/player_rating_cubit/player_rating_cubit.dart';

class PageIndicatorSteps extends StatelessWidget {
  const PageIndicatorSteps({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.langCode == 'ar';
    return BlocBuilder<PlayerRatingCubit, PlayerRatingState>(
      builder: (context, state) {
        final cubit = PlayerRatingCubit.get(context);
        final totalPages = cubit.pages.length;
        final currentPage = state.currentPage;

        return Padding(
          padding: AppPadding.symmetricPadding(vertical: 16),
          child: _AnimatedStepProgress(
            currentStep: currentPage,
            totalSteps: totalPages,
            isArabic: isArabic,
          ),
        );
      },
    );
  }
}

class _AnimatedStepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isArabic;

  const _AnimatedStepProgress({
    required this.currentStep,
    required this.totalSteps,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    var color = AppColors.yellow;
    return SizedBox(
      height: 24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stepWidth = constraints.maxWidth / totalSteps;

          return Stack(
            children: [
              Container(
                height: 3,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Animated progress
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                right: isArabic ? 0 : null,
                left: isArabic ? null : 0,
                width: (currentStep + 1) * stepWidth,
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Step indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(totalSteps, (index) {
                  final isActive = index <= currentStep;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? color
                              : AppColors.grey.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isActive
                                ? color
                                : AppColors.grey.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child:
                            isActive
                                ? Icon(
                                  Icons.check,
                                  size: 14,
                                  color: AppColors.white,
                                  key: ValueKey('check_$index'),
                                )
                                : AppText(
                                  '${index + 1}',
                                  translate: false,
                                  color:
                                      isActive
                                          ? AppColors.white
                                          : AppColors.black,
                                  fontSize: 10,
                                  key: ValueKey('text_$index'),
                                ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
