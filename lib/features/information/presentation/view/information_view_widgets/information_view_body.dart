import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';
import 'package:new_chat_with_me/features/information/presentation/view/information_view_widgets/select_image_avatar_consumer.dart';
import 'package:new_chat_with_me/features/information/presentation/view_model/information_state.dart';

import '../../../../../core/AppRouter.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../view_model/information_cubit.dart';
import 'confirm_informations_animated_progress_button.dart';
import 'information_form.dart';

class InformationViewBody extends StatelessWidget {
  const InformationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocConsumer<InformationCubit, InformationState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kLeftHomeViewPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SelectImageAvatarStack(),
                    const VerticalSpacer(20),
                    const InformationForm(),
                    const VerticalSpacer(20),
                    ConfirmInfoAnimatedProgressButton(onPressed: () {
                      if (context
                          .read<InformationCubit>()
                          .formKey
                          .currentState!
                          .validate()) {

                      }
                    })
                  ],
                ),
              );
            },
            listener: (BuildContext context, state) {
              if (state is PickImageFailure) {
                showSnackBar(context, state.error);
              }
              if (state is StoringFireStoreErrorState) {
                showSnackBar(context, state.error);
              }
              if (state is CacheSetSignedInToTrueState) {
                Navigator.pushReplacementNamed(context, AppRouter.homeView,
                    arguments: state.userModel);
                log('Navigated');
              }
            },
          ),
        ),
      ],
    );
  }
}
