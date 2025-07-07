import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../data/model/profile_btn_model.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, required this.btn});

  final ProfileBtnModel btn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btn.onTap,
      child: Padding(
        padding: AppPadding.symmetric(vertical: 8, horizontal: 0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: btn.backgroundColor,
            borderRadius: AppBorderRadius.smallRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: AppPadding.symmetric(),
          child: Row(
            spacing: 16,
            children: [
              Icon(btn.icon, color: btn.iconColor),
              Expanded(
                child: AppText(btn.title!, color: btn.titleColor, isBold: true),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: btn.iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
