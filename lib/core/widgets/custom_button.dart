import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final Color backGroundColor;
  final TextStyle textStyle;
  final double? buttonWidth;
  final double? buttonHeight;

  const CustomButton(
      {super.key,
      required this.textStyle,
      required this.text,
      required this.backGroundColor,
      required this.onPressed,
      this.borderRadius,
      this.buttonWidth,
      this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
            Size(buttonWidth?.w ?? double.maxFinite, buttonHeight?.h ?? 50.h)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          backGroundColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(20),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
