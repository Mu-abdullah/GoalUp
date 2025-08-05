import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/style/color/app_color.dart';
import '../../../../core/style/custom_widgets/circle_progress.dart';
import '../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../core/style/statics/app_statics.dart';
import '../../../../core/style/widgets/app_button.dart';
import '../../../../core/style/widgets/app_text.dart';
import '../../../../core/style/widgets/app_text_form_felid.dart';
import '../cubits/user_auth_cubit/user_auth_cubit.dart';
import '../widgets/app_logo.dart';

class UserAuthScreenBody extends StatelessWidget {
  const UserAuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    var isArabic = context.langCode == 'ar';
    return BlocConsumer<UserAuthCubit, UserAuthState>(
      listener: (context, state) {
        if (state is UserNotExists) {
          Navigator.pop(context);
          return CustomSnackbar.showTopSnackBar(
            context,
            message: LangKeys.userNotFound,
            isError: true,
          );
        } else if (state is CheckUserError) {
          Navigator.pop(context);
          return CustomSnackbar.showTopSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        }
        if (state is CheckUserLoading) {
          showProgressIndicator(context);
        }
        if (state is UserExists) {
          Navigator.pop(context);
          context.pushReplacementNamed(
            RoutesNames.playerProfile,
            arguments: {'playerId': state.user.playerId, 'isCoach': false},
          );
        }
      },
      builder: (context, state) {
        var cubit = UserAuthCubit.get(context);
        return Padding(
          padding: AppPadding.symmetric(),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    AppLogo(),
                    AppTextFormField(
                      label: LangKeys.email,
                      controller: cubit.emailController,
                      type: TextInputType.emailAddress,
                      prefix: Icon(HugeIcons.strokeRoundedMail02),
                      validate: (c) {
                        if (c == null || c.isEmpty) {
                          return LangKeys.requiredValue;
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(c)) {
                          return context.tr(LangKeys.writeEmailCorrect);
                        }
                        return null;
                      },
                    ),
                    // RemmberMe(color: AppColors.blueAccent),
                    AppButton(
                      onTap: () {
                        cubit.checkIfRowExists();
                      },
                      text: LangKeys.login,
                      backGroundColor: AppColors.blueAccent,
                    ),
                    InkWell(
                      onTap: () => context.pushNamed(RoutesNames.auth),
                      child: AppText(
                        LangKeys.imCoach,
                        textAlign: isArabic ? TextAlign.left : TextAlign.right,
                        isUnderline: true,
                        isBold: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
