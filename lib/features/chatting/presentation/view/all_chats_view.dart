import 'package:flutter/material.dart';

import 'all_chats_view_widgets/all_chats_view_body.dart';
import 'all_chats_view_widgets/pop_up_app_bar_menu.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar:  AppBar(
          title: const Text('chats'),
          actions: const [
            PopUpMenu(),
          ],
        ),
      body: const SafeArea(child: AllChatsViewBody()),
    );
  }
}
