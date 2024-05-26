import 'package:flutter/material.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/otp_cubit/otp_cubit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../../../../core/widgets/vertical_and_horizontal_space.dart';


class OTPViewBody extends StatelessWidget {



  const OTPViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(context) async {
      if (context.read<OTPCubit>().otpCode != null) {
        //verifyOtp(context, context.read<OTPCubit>().otpCode);
      } else {
        showSnackBar(context, 'enter 6-digit code');
      }
    }
    return  CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Verification',
                  style: MyTextStyles.font24Weight700
                      .copyWith(color: MyColors.kPrimaryColor),
                ),
                const VerticalSpacer(15),
                Text(
                  'Enter the OTP send to your phone number.',
                  textAlign: TextAlign.center,
                  style: MyTextStyles.font14Weight500
                      .copyWith(color: MyColors.kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
