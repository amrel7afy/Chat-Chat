import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

class CustomBorders {
  static OutlineInputBorder focusedBorder({double borderRadius = 16.0}) {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: MyColors.kPrimaryColor,
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static OutlineInputBorder enabledBorder({double borderRadius = 16.0}) {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: MyColors.kLighterGreyColor,
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static OutlineInputBorder errorBorder({double borderRadius = 16.0}) {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.3,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static OutlineInputBorder focusedErrorBorder({double borderRadius = 16.0}) {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.3,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
