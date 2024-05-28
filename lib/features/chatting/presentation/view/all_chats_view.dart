import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/widgets/custom_app_bar.dart';
import 'all_chats_view_widgets/all_chats_floating_button.dart';
import 'all_chats_view_widgets/all_chats_view_body.dart';
import 'all_chats_view_widgets/pop_up_app_bar_menu.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
       appBar:  CustomAppBar(text: 'Chat',),
      body: SafeArea(child: AllChatsViewBody()),
      floatingActionButton: AllChatsFloatingAction(),
    );
  }
}
