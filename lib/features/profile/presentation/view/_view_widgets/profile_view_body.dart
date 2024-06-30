import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../../../../core/widgets/vertical_and_horizontal_space.dart';
import '../../../../information/presentation/view/information_view_widgets/confirm_informations_animated_progress_button.dart';
import '../../../../information/presentation/view/information_view_widgets/information_form.dart';
import '../../../../information/presentation/view/information_view_widgets/select_image_avatar_consumer.dart';
import '../../../../information/presentation/view_model/information_cubit.dart';
import '../../../../information/presentation/view_model/information_state.dart';


class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
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
                    InformationAnimatedProgressButton(
                      onPressed: () {
                      context.read<InformationCubit>().updateUserProfile();
                      }, text: 'Edit',
                    )
                  ],
                ),
              );
            },
            listener: (BuildContext context, state) {
              if (state is InformationPickImageFailure) {
                showSnackBar(context, state.error);
              }
              if (state is InformationStoringFireStoreErrorState) {
                showSnackBar(context, state.error);
              }
              if (state is InformationSuccess) {
                if(locator<SharedRepository>().image!=null){
                  locator<SharedRepository>().image=null;
                }
                context.pop();
                log('Navigated');
              }
            },
          ),
        ),
      ],
    );
  }
}
