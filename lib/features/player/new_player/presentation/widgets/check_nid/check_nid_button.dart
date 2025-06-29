import 'package:flutter/material.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/widgets/app_button.dart';
import '../../cubits/check_user_nid_cubit/check_user_nid_cubit.dart';

class NidCheckButton extends StatelessWidget {
  const NidCheckButton({super.key, required this.cubit});
  final CheckUserNidCubit cubit;
  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () {
        if (cubit.formKey.currentState!.validate()) {
          cubit.checkNid(cubit.nidController.text);
        }
      },
      text: LangKeys.next,
    );
  }
}
