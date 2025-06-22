import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../color/app_color.dart';
import '../statics/app_statics.dart';
import 'app_space.dart';
import 'app_text.dart';
import '../custom_widgets/custom_shimmer.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onTap,
    this.text,
    this.txtColor = AppColors.white,
    this.backGroungColor = AppColors.black,
    this.borderColor = AppColors.black,
    this.isBorderd = false,
    this.fontSize = 12,
    this.isLoading = false,
    this.isCircle = false,
    this.boxShadow = false,
    this.isDisabled = false,
    this.icon,
    this.isUpperCase = true,
    this.iconColor = AppColors.white,
    this.circleSize = 50,
    this.borderWidth = 1,
    this.fontWeight,
    super.key,
  });

  final String? text;
  final double fontSize;
  final VoidCallback onTap;
  final Color txtColor;
  final Color backGroungColor;
  final Color borderColor;
  final Color iconColor;
  final bool isBorderd;
  final bool isLoading;
  final bool isCircle;
  final bool isDisabled;
  final bool boxShadow;
  final bool isUpperCase;
  final IconData? icon;
  final double circleSize;
  final double borderWidth;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled || isLoading ? null : onTap,
      borderRadius: _buttonBorderRadius,
      child:
          isLoading
              ? _buildLoadingShimmer(context)
              : _buildButtonContent(context),
    );
  }

  BorderRadius get _buttonBorderRadius => AppBorderRadius.mediumRadius;

  Widget _buildLoadingShimmer(BuildContext context) {
    return CustomShimmer(
      child: _buildButtonContainer(
        child: Center(child: _buildText(context, txtColor)),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return _buildButtonContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (text != null) _buildText(context, _getTextColor),
          if (icon != null) ...[
            if (text != null) const AppSpace(isHorizontal: true, space: 8),
            _buildIcon(iconColor),
          ],
        ],
      ),
    );
  }

  Widget _buildButtonContainer({required Widget child}) {
    return Container(
      width: isCircle ? circleSize : double.infinity,
      height: circleSize,
      decoration: _buttonDecoration,
      child: Center(child: child),
    );
  }

  Widget _buildText(BuildContext context, Color textColor) {
    return AppText(
      text!,
      color: textColor,
      isBold: true,
      fontSize: fontSize,
      isUpperCase: isUpperCase,
      fontWeight: fontWeight,
    );
  }

  Widget _buildIcon(Color iconColor) {
    return HugeIcon(icon: icon!, color: iconColor, size: 20);
  }

  BoxDecoration get _buttonDecoration {
    return BoxDecoration(
      borderRadius: isCircle ? null : _buttonBorderRadius,
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: _getButtonColor,
      border:
          isBorderd ? Border.all(color: borderColor, width: borderWidth) : null,
      boxShadow:
          boxShadow
              ? [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
              : null,
    );
  }

  Color get _getButtonColor {
    if (isDisabled && !isLoading) return AppColors.grey;
    return isBorderd ? Colors.white : backGroungColor;
  }

  Color get _getTextColor => isBorderd ? borderColor : txtColor;
}
