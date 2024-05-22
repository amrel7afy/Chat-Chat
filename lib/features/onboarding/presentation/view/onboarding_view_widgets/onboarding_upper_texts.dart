import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/methods.dart';
import '../../../../../core/theming/styles.dart';

class OnBoardingUpperTexts extends StatelessWidget {
  const OnBoardingUpperTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [Text(
        'Let\'s get Started',
        style: MyTextStyles.font24Weight700,
      ),
        VerticalSpacer(15),
        Text(
          'Never a better time than now to start',
          style: MyTextStyles.font14Weight500,
        ),],
    );
  }
}