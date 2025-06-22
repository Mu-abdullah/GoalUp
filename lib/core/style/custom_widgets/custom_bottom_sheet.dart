import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../color/app_color.dart';
import '../widgets/app_space.dart';
import '../widgets/app_text.dart';

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
          Row(
            children: [
              Expanded(
                child: AppText(
                  title,
                  translate: translated,
                  isBold: true,
                  isTitle: true,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  HugeIcons.strokeRoundedCancelSquare,
                  color: AppColors.red,
                ),
              ),
            ],
          ),
          widget,
        ],
      );
    },
  );
}
