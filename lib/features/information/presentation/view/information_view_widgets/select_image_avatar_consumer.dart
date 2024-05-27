import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/features/information/presentation/view/information_view_widgets/select_image_avatar.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../view_model/information_cubit.dart';
import '../../view_model/information_state.dart';

class SelectImageAvatarConsumer extends StatelessWidget {

  const SelectImageAvatarConsumer({super.key, });



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InformationCubit, InformationState>(
      builder: (BuildContext context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
             SelectImageAvatar(),
            IconButton(
              onPressed: () {
                context.read<InformationCubit>().pickImage();
              },
              icon: const CircleAvatar(
                radius: 16,
                backgroundColor: MyColors.kPrimaryColor,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
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
    );
  }
}