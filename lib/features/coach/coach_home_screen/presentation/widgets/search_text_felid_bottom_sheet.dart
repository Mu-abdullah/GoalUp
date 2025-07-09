import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_button.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';

class SearchTextFieldBottomSheet extends StatefulWidget {
  const SearchTextFieldBottomSheet({super.key});

  @override
  State<SearchTextFieldBottomSheet> createState() =>
      _SearchTextFieldBottomSheetState();
}

class _SearchTextFieldBottomSheetState
    extends State<SearchTextFieldBottomSheet> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextInputType type = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.only(left: 16, bottom: 8, right: 16, top: 8),
      child: Form(
        key: formKey,
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextFormField(
              controller: controller,
              type: type,
              label: LangKeys.name,
              hint: LangKeys.name,
              validate: (value) {
                if (value!.isEmpty) {
                  return context.translate(LangKeys.requiredValue);
                }
                return null;
              },
            ),
            AppButton(
              text: LangKeys.search,
              icon: HugeIcons.strokeRoundedSearch02,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
