import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';

class PlayerRatingTextFormFelid extends StatelessWidget {
  const PlayerRatingTextFormFelid({
    super.key,
    required this.controller,
    required this.label,
    this.type = TextInputType.text,
    this.hint,
    this.icon,
    this.validate,
    this.onTap,
    this.maxLines,
    this.maxLength,
    this.isPassword = false,
    this.enabled = true,
  });
  final TextEditingController controller;
  final String label;
  final String? hint;
  final FormFieldValidator<String>? validate;
  final TextInputType type;
  final IconData? icon;
  final void Function()? onTap;
  final int? maxLines;
  final int? maxLength;
  final bool isPassword;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      enabled: enabled,
      controller: controller,
      prefix: icon == null ? null : Icon(icon),
      type: type,
      label: label,
      hint: hint ?? label,
      isPassword: isPassword,
      maxLines: maxLines,
      maxLength: maxLength,
      validate:
          validate ??
          (c) {
            if (c!.isEmpty) {
              return context.translate(LangKeys.requiredValue);
            }
            return null;
          },

      onTap: onTap,
    );
  }
}
