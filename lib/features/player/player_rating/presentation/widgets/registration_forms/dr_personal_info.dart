import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../../core/functions/select_data.dart';
import '../../../../../../core/language/lang_keys.dart';
import '../../../../../../core/style/statics/app_statics.dart';
import '../../../../../admin/admin_home/presentation/widgets/admin_section.dart';
import '../new_client_text_form_felid.dart';

class DrPersonalInformation extends StatelessWidget {
  DrPersonalInformation({super.key});

  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.symmetricPadding(),
      child: AdminSections(
        title: LangKeys.information,
        icon: HugeIcons.strokeRoundedUserAccount,
        child: Column(
          spacing: 16,
          children: [
            _buildTextField(
              controller: _nameController,
              label: LangKeys.name,
              icon: HugeIcons.strokeRoundedUser,
              type: TextInputType.text,
            ),
            _buildTextField(
              controller: _birthController,
              label: LangKeys.birthDate,
              icon: HugeIcons.strokeRoundedCalendar01,
              type: TextInputType.text,
              onTap: () {
                selectData(
                  context: context,
                  controller: _birthController,
                  content: LangKeys.birthDate,
                );
              },
            ),
            _buildTextField(
              controller: _emailController,
              label: LangKeys.email,
              icon: HugeIcons.strokeRoundedMail01,
              type: TextInputType.emailAddress,
              validate: (c) {
                if (c!.isEmpty) {
                  return context.translate(LangKeys.requiredValue);
                } else if (!Validation.regExp.hasMatch(c)) {
                  return context.translate(LangKeys.mailError);
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _passwordController,
              label: LangKeys.password,
              icon: HugeIcons.strokeRoundedLockPassword,
              type: TextInputType.visiblePassword,
              isPassword: true,
              validate: (c) {
                if (c!.isEmpty) {
                  return context.translate(LangKeys.requiredValue);
                } else if (c.length < 6) {
                  return context.translate(LangKeys.passwordShort);
                }
                return null;
              },
            ),
            _buildTextField(
              controller: _phoneController,
              label: LangKeys.phone,
              icon: HugeIcons.strokeRoundedSmartPhone01,
              type: TextInputType.number,
              maxLength: 11,
              maxLines: 1,
              validate: (c) {
                if (c!.isEmpty) {
                  return context.translate(LangKeys.requiredValue);
                }
                if (c.length < 11) {
                  return context.translate(LangKeys.phoneError);
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType type,
    String? Function(String?)? validate,
    bool isPassword = false,
    int? maxLength,
    int? maxLines,
    VoidCallback? onTap,
  }) {
    return NewClientTextFormFelid(
      controller: controller,
      type: type,
      label: label,
      icon: icon,
      validate: validate,
      isPassword: isPassword,
      maxLength: maxLength,
      maxLines: maxLines,
      onTap: onTap,
    );
  }
}
