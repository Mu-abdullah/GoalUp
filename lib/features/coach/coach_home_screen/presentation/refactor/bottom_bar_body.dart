import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../coach_home_page/presentation/cubits/home_academy_cubit/home_academy_cubit.dart';
import '../../../coach_players/presentation/cubits/coach_players_cubit/coach_players_cubit.dart';
import '../cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../widgets/bottom_bar/custom_bottom_navigation_bar.dart';
import '../widgets/search_text_felid_bottom_sheet.dart';

class BottomBarBody extends StatelessWidget {
  const BottomBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        return BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, bottomBarState) {
            final cubit = BottomBarCubit.get(context);
            final academy = context.watch<HomeAcademyCubit>().academy;

            // لو البيانات لسه ما جتش
            if (academy == null ||
                academy.activeTo == null ||
                academy.activeTo!.isEmpty) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final daysLeft = academy.calcPeriod();

            Widget bodyContent = Stack(
              children: [
                Positioned.fill(child: cubit.pages()[cubit.currentIndex]),
                if (daysLeft == 1)
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: AppPadding.symmetric(),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: AppText(
                            LangKeys.remainingDays,

                            isBold: true,
                            color: AppColors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );

            if (daysLeft <= 0) {
              bodyContent = ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(child: cubit.pages()[cubit.currentIndex]),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: AppText(
                          LangKeys.subscriptionExpired,

                          isBold: true,
                          color: AppColors.red,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return IgnorePointer(
              ignoring: daysLeft <= 0,
              child: Scaffold(
                appBar: CustomAppBar(
                  title: cubit.titles[cubit.currentIndex],
                  isBack: cubit.isAdmin,
                  actions: actions(context, cubit.titles, cubit.currentIndex),
                ),
                bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
                body: SafeArea(
                  child: Container(
                    margin: AppPadding.smallPadding,
                    child: bodyContent,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> actions(BuildContext context, List<String> titles, int index) {
    return [
      index == 2
          ? Padding(
            padding: AppPadding.symmetric(vertical: 0),
            child: IconButton(
              onPressed: () {
                customShowBottomSheet(
                  context: context,
                  widget: SearchTextFieldBottomSheet(
                    players: CoachPlayersCubit.get(context).players,
                  ),
                  title: LangKeys.search,
                  isScrollControlled: false,
                );
              },
              icon: Icon(
                HugeIcons.strokeRoundedSearch02,
                color: AppColors.black,
              ),
            ),
          )
          : Image.asset(AppImages.logo),
    ];
  }
}
