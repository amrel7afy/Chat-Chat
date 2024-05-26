import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/circluar_small_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../view_model/login_cubit/login_state.dart';

enum ButtonState { init, loading, done, error }

class LoginAnimatedProgressButton extends StatefulWidget {

  final VoidCallback onPressed;

  const LoginAnimatedProgressButton({
    super.key,

    required this.onPressed,
  });

  @override
  State<LoginAnimatedProgressButton> createState() =>
      _LoginAnimatedProgressButtonState();
}

class _LoginAnimatedProgressButtonState
    extends State<LoginAnimatedProgressButton> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        playAnimation(state);
      },
      builder: (context, state) {
        final isStretched = isAnimating || this.state == ButtonState.init;
        final isDone = this.state == ButtonState.done;
        final isError = this.state == ButtonState.error;

        return Container(
          alignment: Alignment.center,
          child: AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: this.state == ButtonState.init
                ? MediaQuery.of(context).size.width
                : 70,
            onEnd: () => setState(() => isAnimating = !isAnimating),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: isStretched
                ? CustomButton(
                  text: 'Login',
                    onPressed: widget.onPressed,
                    textStyle:
                        MyTextStyles.font20Weight600.copyWith(color: Colors.white),
                    backGroundColor: MyColors.kPrimaryColor)
                : SmallButton(
                    isDone,
                    isError: isError,
                  ),
          ),
        );
      },
    );
  }

  void playAnimation(LoginState state) async {
    if (state is LoginLoading) {
      setState(() => this.state = ButtonState.loading);
    } else if (state is OTPSent) {
      await otpSend(state);
    } else if (state is LoginFailure||state is LoginFireBaseAuthFailure) {
      await failure();
    } else {
      setState(() => this.state = ButtonState.init);
    }
  }

  Future<void> failure() async {
     setState(() => state = ButtonState.error);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => state = ButtonState.init);
  }

  Future<void> otpSend(OTPSent state) async {
    setState(() {
      this.state = ButtonState.done;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    Future.microtask(() => context.pushNamed(
         AppRouter.otpView,
        arguments: state.verificationId));
    setState(() => this.state = ButtonState.init);
  }
}


