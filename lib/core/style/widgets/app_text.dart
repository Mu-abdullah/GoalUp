import 'package:flutter/material.dart';
import '../../../core/extextions/extentions.dart';
import '../../../core/style/color/app_color.dart';
import '../../../core/style/font/fonts_helper.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.isTitle = false,
    this.isUpperCase = false,
    this.translate = true,
    this.isBold = false,
    this.isUnderline = false,
    this.isOverLine = false,
    this.isLineThrough = false,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.color = AppColors.black,
    this.lineColor = AppColors.black,
    this.height = 1.5,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int maxLines;
  final Color? color;
  final Color? lineColor;
  final double height;
  final bool isUpperCase;
  final bool translate;
  final bool isTitle;
  final bool isBold;
  final bool isUnderline;
  final bool isOverLine;
  final bool isLineThrough;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    final displayText = translate ? context.translate(text) : text;
    return Text(
      isUpperCase ? displayText.toUpperCase() : displayText,
      style: customTextStyle(
        context,
        color: color!,
        isBold: isBold,
        isLineThrough: isLineThrough,
        isOverLine: isOverLine,
        isTitle: isTitle,
        isUnderline: isUnderline,
        lineColor: lineColor,
        textAlign: textAlign,
        height: height,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

TextStyle customTextStyle(
  BuildContext context, {
  TextAlign? textAlign,
  Color color = AppColors.black,
  Color? lineColor,
  bool isTitle = false,
  bool isBold = false,
  bool isUnderline = false,
  bool isOverLine = false,
  bool isLineThrough = false,
  double height = 1.5,
  double? fontSize,
  FontWeight? fontWeight,
  String? fontFamily,
}) {
  return TextStyle(
    fontFamily: fontFamily ?? FontsHelper.fontLangFamily(context),
    fontSize:
        fontSize ??
        (isTitle ? context.titleMedium?.fontSize : context.bodySmall?.fontSize),
    color: color,
    fontWeight: fontWeight ?? (isBold ? FontWeight.bold : FontWeight.normal),
    decoration: _textDecoration(
      isUnderline: isUnderline,
      isOverLine: isOverLine,
      isLineThrough: isLineThrough,
    ),
    height: height,
    decorationColor: lineColor,
    decorationStyle: TextDecorationStyle.solid,
  );
}

TextDecoration _textDecoration({
  bool isUnderline = false,
  bool isOverLine = false,
  bool isLineThrough = false,
}) {
  if (isUnderline) {
    return TextDecoration.underline;
  } else if (isOverLine) {
    return TextDecoration.overline;
  } else if (isLineThrough) {
    return TextDecoration.lineThrough;
  } else {
    return TextDecoration.none;
  }
}
