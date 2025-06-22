import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../color/app_color.dart';

class BackScreenButton extends StatelessWidget {
  const BackScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black.withValues(alpha: 0.7),
          ),
          child: Icon(
            HugeIcons.strokeRoundedCancel01,
            color: AppColors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
