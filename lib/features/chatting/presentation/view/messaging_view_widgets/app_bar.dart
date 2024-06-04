

import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/core/theming/styles.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../../../contacts/presentation/view/contacts_view_widgets/getEitherNetworkImageAvatarOrAssetImage.dart';

class   MessagingAppBar extends StatelessWidget implements PreferredSizeWidget  {
  final UserModel friendModel;
  const MessagingAppBar({super.key, required this.friendModel});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      title: Text(friendModel.name,style: MyTextStyles.font20Weight600.copyWith(color: MyColors.kPrimaryColor),),
      leading: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            margin:const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: MyColors.kPrimaryColor,
                ),
                getEitherNetworkImageAvatarOrAssetImage(
                    radius: 15,
                    noProfileRadius: 16,
                    userModel: friendModel)
              ],
            ),
          ),
        ),
      ),
    );
  }
@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
