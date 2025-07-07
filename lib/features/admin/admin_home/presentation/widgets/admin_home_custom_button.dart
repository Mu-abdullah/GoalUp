import 'package:sport/core/extextions/extentions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/admin_section_model.dart';

class AdminHomeCustomButton extends StatelessWidget {
  const AdminHomeCustomButton({
    super.key,
    required this.item,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.vertical,
    this.horizontal,
  });
  final AdminSectionModel item;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? vertical;
  final double? horizontal;
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.langCode == 'ar';
    return Padding(
      padding: AppPadding.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: InkWell(
        onTap: item.onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.mediumRadius,
            color: item.backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: top,
                left: left,
                right: right,
                bottom: bottom,
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      item.title!,
                      isTitle: true,
                      isBold: true,
                      color: item.titleColor,
                      maxLines: 3,
                    ),
                    Icon(item.icon, color: item.titleColor),
                  ],
                ),
              ),
              Positioned(
                top: top == null ? -20 : 0,
                right: isArabic ? null : -20,
                left: isArabic ? -20 : null,
                child: Icon(
                  item.icon,
                  color: item.titleColor!.withValues(alpha: 0.2),
                  size: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
