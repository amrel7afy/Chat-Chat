import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/theming/styles.dart';
import '../constants/custom_border.dart';


class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Function(String? value) validator;

  const CustomTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ?? CustomBorders.focusedBorder(),
        enabledBorder: enabledBorder ?? CustomBorders.enabledBorder(),
        errorBorder: CustomBorders.errorBorder(),
        focusedErrorBorder: CustomBorders.focusedErrorBorder(),
        hintStyle: hintStyle ??
            MyTextStyles.font14Weight500.copyWith(color: MyColors.kLightGreyColor),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? MyColors.kMostLighterGreyColor,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle ?? MyTextStyles.font14Weight500,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
