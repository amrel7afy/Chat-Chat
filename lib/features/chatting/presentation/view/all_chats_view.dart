import 'package:flutter/material.dart';

import '../../../../core/theming/my_colors.dart';
import '../../../../core/theming/styles.dart';
import 'all_chats_view_widgets/all_chats_view_body.dart';
import 'all_chats_view_widgets/pop_up_app_bar_menu.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar:  AppBar(
          title:  Text('chats',style: MyTextStyles.font23Weight700.copyWith(color: MyColors.kPrimaryColor)),
          actions: const [
            PopUpMenu(),
          ],
         automaticallyImplyLeading: false,
        ),
      body: const SafeArea(child: AllChatsViewBody()),
    );
  }
}
