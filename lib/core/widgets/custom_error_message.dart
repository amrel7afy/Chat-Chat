import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/theming/styles.dart';

import '../theming/my_colors.dart';

class CustomErrorMessage extends StatelessWidget {
  final String errorMessage;

  const CustomErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: MyTextStyles.font20Weight600.copyWith(
          color: MyColors.kPrimaryColor,

        ),textAlign: TextAlign.center,
      ),
    );
  }
}
