import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/circluar_small_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/information_cubit.dart';
import '../../view_model/information_state.dart';


enum ButtonState { init, loading, done, error }

class ConfirmInfoAnimatedProgressButton extends StatefulWidget {

  final VoidCallback onPressed;

  const ConfirmInfoAnimatedProgressButton({
    super.key,

    required this.onPressed,
  });

  @override
  State<ConfirmInfoAnimatedProgressButton> createState() =>
      _ConfirmInfoAnimatedProgressButtonState();
}

class _ConfirmInfoAnimatedProgressButtonState
    extends State<ConfirmInfoAnimatedProgressButton> {
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
    return BlocConsumer<InformationCubit, InformationState>(
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
                  text: 'Continue',
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

  void playAnimation(InformationState state) async {
    if (state is InformationLoading) {
      setState(() => this.state = ButtonState.loading);
    } else if (state is CacheSetSignedInToTrueState) {
      await createUserStore( state);
    } else if (state is InformationFailure) {
      await failure();
    }
  }

  Future<void> failure() async {
     setState(() => state = ButtonState.error);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => state = ButtonState.init);
  }

  Future<void> createUserStore(CacheSetSignedInToTrueState state) async {
    setState(() {
      this.state = ButtonState.done;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    Future.microtask(() =>  context.pushReplacementNamed(AppRouter.homeView,
        arguments: state.userModel)
    );
  }
}


