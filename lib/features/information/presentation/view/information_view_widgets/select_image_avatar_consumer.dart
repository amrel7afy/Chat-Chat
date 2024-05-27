
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/features/information/presentation/view/information_view_widgets/select_image_avatar.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../view_model/information_cubit.dart';

class SelectImageAvatarStack extends StatelessWidget {

   SelectImageAvatarStack({super.key, });

  @override
  Widget build(BuildContext context) {
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
  }
}