import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import '../../../../../core/theming/styles.dart';

class OnBoardingUpperTexts extends StatelessWidget {
  const OnBoardingUpperTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Let\'s get Started\n',
                style: MyTextStyles.font24Weight700.copyWith(color: MyColors.kPrimaryColor)
              ),
              TextSpan(
                text: 'Never a better time than now to start',
                style: MyTextStyles.font14Weight500.copyWith(height: 1.5,color: MyColors.kPrimaryColor),

              ),
            ],
          ),
        ),

      ],
    );
  }
}
