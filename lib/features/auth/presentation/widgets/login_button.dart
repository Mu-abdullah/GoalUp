import 'package:flutter/material.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/style/widgets/app_button.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      isLoading: cubit.state is AuthLoading,
      onTap: () {
        if (cubit.formKey.currentState!.validate()) {
          cubit.login();
        }
      },
      text: LangKeys.login,
    );
  }
}
