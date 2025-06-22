import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';

class AdminSections extends StatelessWidget {
  const AdminSections({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.color = AppColors.yellow,
  });
  final String title;
  final Widget child;
  final IconData? icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.mediumRadius,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),

      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: icon == null ? 0 : 16,
            children: [
              icon == null ? const SizedBox() : Icon(icon, color: color),
              Expanded(
                child: AppText(
                  title,
                  isBold: true,
                  isTitle: true,
                  maxLines: 3,
                  color: color,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
