import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';
import 'package:new_chat_with_me/features/login/presentation/view/otp_view_widgets/otp_animated_progress_button.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/otp_cubit/otp_cubit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/pin_put.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../../../../core/widgets/vertical_and_horizontal_space.dart';
import '../../view_model/otp_cubit/otp_state.dart';

class OTPViewBody extends StatelessWidget {
  final String verificationId;

  const OTPViewBody({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {

    return BlocListener<OTPCubit, OTPState>(
      listener: (context, state) {
        if (state is OTPUserNotExists) {
          context.pushReplacementNamed(AppRouter.informationView);
        }
        if (state is OTPSetSignedInToTrue) {}
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kLeftHomeViewPadding,
              ),
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
                  ),const VerticalSpacer(20),
                  PinPutBuilder(
                    otpCode: context.read<OTPCubit>().otpCode,
                    onCompleted: (value) {
                      context.read<OTPCubit>().otpCode = value;
                      log(context.read<OTPCubit>().otpCode.toString());
                    },
                  ),const VerticalSpacer(25),
                  OTPAnimatedProgressButton(
                    onPressed: () {
                      if (context.read<OTPCubit>().otpCode != null) {
                        context
                            .read<OTPCubit>()
                            .verifyOTP(verificationId: verificationId);
                      } else {
                        showSnackBar(context, 'enter 6-digit code');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
