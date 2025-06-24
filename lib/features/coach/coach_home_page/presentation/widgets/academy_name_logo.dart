
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/loading_shimmer_widget.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../cubits/home_academy_cubit/home_academy_cubit.dart';

class AcademyNameLogo extends StatelessWidget {
  const AcademyNameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAcademyCubit, HomeAcademyState>(
      builder: (context, state) {
        if (state is HomeAcademyLoading) {
          return LoadingShimmer(itemCount: 1, height: 0.1);
        } else if (state is HomeAcademyLoaded) {
          var academy = state.academy;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppText(
                academy.name ?? LangKeys.somethingWentWrong,
                translate: academy.name == null,
                fontSize: 24,
                isBold: true,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:
                        academy.logo == '' || academy.logo == null
                            ? AssetImage(AppImages.logo)
                            : NetworkImage(academy.logo!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeAcademError) {
          return Center(child: AppText(state.message, translate: false));
        }
        return const Center(child: AppText(LangKeys.somethingWentWrong));
      },
    );
  }
}
