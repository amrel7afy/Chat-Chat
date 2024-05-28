import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/chatting_cubit/chatting_cubit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/theming/styles.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) async{
        if (result == 'Profile') {
          context.pushNamed( AppRouter.profileView);
        } else {
          await context.read<ChattingCubit>().signOut().then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRouter.loginView, (route) => false);
            CacheHelper.removeData(key: userModelKey);
            CacheHelper.removeData(key: isSignedInKey);
          });
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
         PopupMenuItem<String>(
          height: 50,
          value: 'Profile',
          child: Text(
            'Profile',
            style: MyTextStyles.font14Weight500,
          ),
        ),
         PopupMenuItem<String>(
          height: 50,
          value: 'Log Out',
          child: Text('Log Out', style: MyTextStyles.font14Weight500),
        ),
      ],
    );
  }
}