import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.cubit});

  final NewPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () {
        if (cubit.formKey.currentState!.validate()) {}
      },
      text: LangKeys.register,
    );
  }
}
