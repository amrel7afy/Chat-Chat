import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/login_cubit/login_state.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/snack_bar.dart';
import 'login_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFireBaseAuthFailure) {
          if (state.error == 'Enter a valid phone number.') {
            showSnackBar(context, state.error);
            log(state.error);
            // _btnController.reset();
          } else {
            showSnackBar(context, 'Some thing is wrong');
            log(state.error);
            //   _btnController.reset();
          }
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacer(10),
                  Text(
                    'Registration',
                    style: MyTextStyles.font24Weight700
                        .copyWith(color: MyColors.kPrimaryColor),
                  ),
                  const VerticalSpacer(15),
                  Text(
                    'Add your phone number. We\'ll send you a\nverification code',
                    style: MyTextStyles.font14Weight500
                        .copyWith(color: MyColors.kPrimaryColor),
                  ),
                  const VerticalSpacer(20),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}


