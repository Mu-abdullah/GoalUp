import 'package:flutter/material.dart';

import '../color/app_color.dart';
import '../statics/app_statics.dart';
import '../widgets/app_space.dart';
import '../widgets/app_text.dart';
import 'custom_icon_button.dart';

Future<dynamic> customShowBottomSheet({
  required BuildContext context,
  required Widget widget,
  required String title,
  bool translated = true,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    useSafeArea: useSafeArea,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: isScrollControlled,
    backgroundColor: AppColors.white,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpace(),
          Padding(
            padding: AppPadding.symmetric(),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    title,
                    tr: translated,
                    isBold: true,
                    isTitle: true,
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomIconButton(),
              ],
            ),
          ),
          // FIX: Add Flexible to prevent infinite height
          Flexible(child: widget),
        ],
      );
    },
  );
}
