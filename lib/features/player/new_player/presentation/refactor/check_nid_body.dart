import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/custom_widgets/circle_progress.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';
import '../cubits/check_user_nid_cubit/check_user_nid_cubit.dart';
import '../widgets/check_nid/check_nid_button.dart';

class CheckNidBody extends StatelessWidget {
  const CheckNidBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(),
      child: BlocConsumer<CheckUserNidCubit, CheckUserNidState>(
        listener: (context, state) {
          if (state is CheckUserNidError) {
            Navigator.pop(context);
            CustomSnackbar.showTopSnackBar(
              context,
              message: state.message,
              isError: true,
            );
          } else if (state is CheckUserNidLoaded) {
            Navigator.pop(context);

            context.pushReplacementNamed(
              RoutesNames.playerProfile,
              arguments: {'playerId': state.user.id, 'isCoach': true},
            );
          } else if (state is CheckUserNidLoading) {
            showProgressIndicator(context);
          }
          if (state is CheckUserNidEmpty) {
            Navigator.pop(context);
            CustomSnackbar.showTopSnackBar(
              context,
              message: state.message,
              backgroundColor: AppColors.yellow,
              textColor: AppColors.darkBlue,
            );
            context.pushReplacementNamed(
              RoutesNames.newPlayer,
              arguments: {
                'nid': CheckUserNidCubit.get(context).nidController.text,
              },
            );
          }
        },
        builder: (context, state) {
          var cubit = CheckUserNidCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                AppTextFormField(
                  controller: cubit.nidController,
                  label: LangKeys.nid,
                  hint: LangKeys.nid,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return context.tr(LangKeys.requiredValue);
                    }
                    return null;
                  },
                ),
                NidCheckButton(cubit: cubit),
              ],
            ),
          );
        },
      ),
    );
  }
}
