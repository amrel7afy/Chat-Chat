import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view/messaging_view_widgets/app_bar.dart';
import 'messaging_view_widgets/messaging_view_body.dart';

class MessagingView extends StatelessWidget {
  final UserModel friendModel;

  const MessagingView({super.key,required this.friendModel});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MessagingAppBar(friendModel: friendModel),
      body:  SafeArea(child: MessagingViewBody(friendModel: friendModel)),
    );
  }
}
