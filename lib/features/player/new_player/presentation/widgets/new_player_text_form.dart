import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';

class NewPlayerTextForm extends StatelessWidget {
  const NewPlayerTextForm({
    super.key,
    required this.controller,
    required this.lable,
    required this.icon,
    this.validate,
    this.type = TextInputType.text,
    this.enabled = true,
    this.onTap,
    this.onChange,
  });

  final TextEditingController controller;
  final String lable;
  final IconData icon;
  final String? Function(String?)? validate;
  final TextInputType type;
  final bool enabled;
  final void Function()? onTap;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      onTap: onTap,
      enabled: enabled,
      controller: controller,
      type: type,
      label: lable,
      hint: lable,
      prefix: Icon(icon),
      validate:
          validate ??
          (c) {
            if (c == null || c.isEmpty) {
              return context.translate(LangKeys.requiredValue);
            }
            return null;
          },

      onChange: (p) {
        onChange?.call();
        if (type == TextInputType.number) {
          controller.text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        }
      },
    );
  }
}
