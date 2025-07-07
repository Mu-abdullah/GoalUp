import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../widgets/bottom_bar/custom_bottom_navigation_bar.dart';

class BottomBarBody extends StatelessWidget {
  const BottomBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, bottomBarState) {
        final cubit = BottomBarCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: cubit.titles[cubit.currentIndex],
              isBack: cubit.isAdmin,
              actions: actions(context, cubit.titles, cubit.currentIndex),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
            body: cubit.pages()[cubit.currentIndex],
          ),
        );
      },
    );
  }

  List<Widget> actions(BuildContext context, List<String> titles, int index) {
    return [
      titles.length - 1 == index
          ? Padding(
            padding: AppPadding.symmetric(vertical: 0),
            child: AppButton(
              onTap: () {
                AppUserCubit.get(context).logout().then((onValue) {
                  if (context.mounted) {
                    context.pushNamedAndRemoveUntil(RoutesNames.userAuthScreen);
                  }
                });
              },
              isCircle: true,
              icon: HugeIcons.strokeRoundedLogout01,
              backGroungColor: AppColors.red,
            ),
          )
          : Image.asset(AppImages.logo),
    ];
  }
}
