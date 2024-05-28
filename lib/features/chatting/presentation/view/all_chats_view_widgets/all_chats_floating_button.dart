import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';

import '../../../../../core/theming/my_colors.dart';


class AllChatsFloatingAction extends StatelessWidget {
  const AllChatsFloatingAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyColors.kPrimaryColor,
      child:  const Icon(
        Icons.message_rounded,
        color: MyColors.kGifBackGroundColor,
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRouter.contactsView);
      },
    );
  }
}