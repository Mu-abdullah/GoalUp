import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/style/widgets/app_text_form_felid.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 10,
        children: [
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
                return context.translate(LangKeys.writeEmailCorrect);
              }
              return null;
            },
          ),
          AppTextFormField(
            controller: cubit.passwordController,
            type: TextInputType.visiblePassword,
            label: LangKeys.password,

            prefix: Icon(HugeIcons.strokeRoundedLockPassword),

            validate: (c) {
              if (c!.isEmpty) {
                return context.translate(LangKeys.requiredValue);
              } else if (c.length < 6) {
                return context.translate(LangKeys.passwordLength);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
