import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../core/style/statics/image_test.dart';
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
              actions: [Image.asset(AppImages.logo)],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
            body: cubit.pages()[cubit.currentIndex],
          ),
        );
      },
    );
  }
}
