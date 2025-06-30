import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../color/app_color.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onTap,
    this.icon = HugeIcons.strokeRoundedCancel01,
    this.iconColor,
    this.size,
    this.backgroundColor = AppColors.black,
  });
  final Function()? onTap;
  final IconData icon;
  final Color? iconColor;
  final double? size;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor!.withValues(alpha: 0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: iconColor ?? Colors.white, size: size ?? 20),
        ),
      ),
    );
  }
}
