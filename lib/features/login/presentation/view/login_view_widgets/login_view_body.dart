import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/theming/styles.dart';


class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: kLeftHomeViewPadding, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacer(10),
                 Text(
                  'Registration',
                  style: MyTextStyles.font24Weight700.copyWith(color: MyColors.kPrimaryColor),
                ),
                const VerticalSpacer(8),
                 Text(
                  'Add your phone number. We\'ll send you a\nverification code',
                  style: MyTextStyles.font14Weight500.copyWith(color: MyColors.kPrimaryColor),
                ),


              ],
            ),
          ),
        ),
      ],
    );
  }
}
