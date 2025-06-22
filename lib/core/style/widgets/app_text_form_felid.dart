import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/extextions/extentions.dart';
import '../../../core/style/widgets/app_text.dart';

import '../color/app_color.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.controller,
    required this.type,
    required this.validate,
    super.key,
    this.border = true,
    this.prefix,
    this.hint,
    this.label,
    this.suffix,
    this.isPassword = false,
    this.maxLines,
    this.onChange,
    this.onSaved,
    this.onSubmitted,
    this.onTap,
    this.maxLength,
    this.minLength,
    this.direction,
    this.enabled = true,
    this.capitalization = TextCapitalization.none,
    this.underlineColor = Colors.grey,
    this.inputFormatters,
  });

  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final bool enabled;
  final bool border;
  final TextDirection? direction;
  final TextEditingController controller;
  final TextInputType type;
  final int? maxLines;
  final int? maxLength;
  final int? minLength;
  final TextCapitalization capitalization;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
  final FormFieldValidator<String> validate;
  final Color underlineColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      style: _fontFamily(false, context),
      onChanged: widget.onChange,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onSubmitted,
      maxLength: widget.maxLength,
      minLines: widget.minLength,
      validator: widget.validate,
      obscureText: widget.isPassword,
      controller: widget.controller,
      textCapitalization: widget.capitalization,
      textDirection: widget.direction,
      keyboardType: widget.type,
      maxLines: widget.isPassword == true ? 1 : widget.maxLines,
      focusNode: _focusNode,
      decoration: _decoration(context),
      inputFormatters: widget.inputFormatters,
    );
  }

  InputDecoration _decoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintText: widget.hint == null ? "" : context.translate(widget.hint!),
      hintStyle: _fontFamily(false, context),
      errorStyle: _fontFamily(true, context),
      labelText: widget.label == null ? "" : context.translate(widget.label!),
      suffix: _suffix(),
      labelStyle: _fontFamily(false, context),
      prefixIcon: widget.prefix,
      border: widget.border ? _borderOutLineBorder() : null,
      focusedBorder:
          widget.border
              ? _focuseOutLineBorder()
              : _underlineBorder(color: widget.underlineColor),
      enabledBorder:
          widget.border ? null : _underlineBorder(color: widget.underlineColor),
      alignLabelWithHint: true,
    );
  }

  TextStyle _fontFamily(bool isError, BuildContext context) {
    return customTextStyle(
      context,
      isBold: !isError,
      fontSize: !isError ? 11.0 : 14.0,
      color: isError ? AppColors.red : AppColors.black,
    );
  }

  Padding _suffix() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: widget.suffix,
    );
  }

  UnderlineInputBorder _underlineBorder({Color? color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }

  OutlineInputBorder _focuseOutLineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.circular(15),
    );
  }

  OutlineInputBorder _borderOutLineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
