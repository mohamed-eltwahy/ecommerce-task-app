
import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/app_icons.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool onlyDigit;
  final String? hintText;
  final String? suffixIcon;
  final String? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixWidget;
  final bool? alignLabelWithHint;
  final Widget? prefixWidget;
  final int? maxLength;
  final bool readOnly;
  final Color? cardColor;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final void Function()? onSuffixPressed;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final TextStyle ? hintStyle;
  final String? label;
  final String? obscuringCharacter;
  final int? minLines;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;


  const AppTextFormField({
    this.hintText,
    this.onChanged,
    this.autovalidateMode,
    this.label,
    this.keyboardType,
    this.alignLabelWithHint,
    this.suffixIcon,
    this.prefixWidget,
    this.suffix,
    this.prefix,
    this.suffixWidget,
    this.minLines,
    this.onlyDigit = false,
    this.onTap,
    this.contentPadding,
    this.maxLength,
    this.cardColor,
    this.prefixIcon,
    this.readOnly = false,
    this.validator,
    required this.controller,
    super.key,
    this.onSuffixPressed,
    this.obscureText, this.hintStyle,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.obscuringCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      maxLines: minLines != null ? null : 1,
      minLines: minLines ?? 1,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyles.textViewMedium14,
      obscuringCharacter: obscuringCharacter ?? "●",
      onChanged: onChanged ,
      inputFormatters: onlyDigit ? [FilteringTextInputFormatter.digitsOnly,] : null,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      onTapOutside: (_) {FocusManager.instance.primaryFocus?.unfocus();},
      maxLengthEnforcement: MaxLengthEnforcement.none,
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint ?? true,
        fillColor: cardColor ?? Theme.of(context).cardColor,
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: label,
        labelStyle: hintStyle,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        prefixIcon: prefixWidget ?? (prefixIcon == null ? null : IconButton(
          onPressed: () {},
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          icon: AppIcons.icon(size: 18, icon: prefixIcon!, color: Theme.of(context).hintColor),
        )),
        suffixIcon: suffixWidget ?? (suffixIcon == null ? null : IconButton(
          onPressed: () {},
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          icon: AppIcons.icon(size: 18, icon: suffixIcon!, color: Theme.of(context).hintColor),
        )),
        prefix: prefix,
        suffix: suffix,
        border: border,
        errorBorder: errorBorder,
        focusedBorder: focusedBorder,
        focusedErrorBorder: focusedErrorBorder,
        disabledBorder: disabledBorder,
        enabledBorder: enabledBorder,
      ),
    );
  }
}
