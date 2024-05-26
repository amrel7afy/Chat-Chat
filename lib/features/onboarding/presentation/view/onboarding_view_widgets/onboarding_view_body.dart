import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/methods.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'onboarding_upper_texts.dart';


class OnBoardingViewBody extends StatelessWidget {
  const
  OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: kLeftHomeViewPadding, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(
                  height: getHeight(context) * 0.6,
                  child: Image.asset(
                    'assets/gif/message.gif',
                  )),
                const OnBoardingUpperTexts(),
                VerticalSpacer(15),
                CustomButton(
                    text: 'Message your contacts',
                    onPressed: () {
                      context.pushReplacementNamed(AppRouter.loginView);
                      CacheHelper.saveData(key: isOnBoardingKey, value: true);
                    },textStyle: MyTextStyles.font20Weight700.copyWith(color: Colors.white),
                    backGroundColor: MyColors.kPrimaryColor
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

