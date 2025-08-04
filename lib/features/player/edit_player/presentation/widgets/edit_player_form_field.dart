import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_snack_bar.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';

class EditPlayerFromField extends StatelessWidget {
  const EditPlayerFromField({
    super.key,

    required this.controller,
    required this.lable,
    required this.type,
    this.validate,
    this.isNumber = false,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String lable;
  final TextInputType type;
  final String? Function(String?)? validate;
  final bool isNumber;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      enabled: enabled,
      controller: controller,
      label: lable,
      type: TextInputType.text,
      validate: (String? value) {
        return null;
      },
      onChange: (v) {
        if (isNumber) {
          final input = v.trim();
          if (int.tryParse(input) == null) {
            CustomSnackbar.showTopSnackBar(
              context,
              message: LangKeys.mustBeNumber,
              isError: true,
            );

            controller.clear();
          }
        }
      },
    );
  }
}
