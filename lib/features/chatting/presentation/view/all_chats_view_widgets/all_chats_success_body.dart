import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/shared/chat_model.dart';

import 'chat_item_builder.dart';

class ChatSuccessBody extends StatelessWidget {
  final List<ChatModel> chats;

  const ChatSuccessBody({
    super.key, required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) =>
          InkWell(
            //TODO
              onTap: () {

              /*       Navigator.pushNamed(context, AppRouter.messagingView,
              arguments: context.read<ChatCubit>().users[index]
          );*/

              },
              child:
              // Text(chats[index].phoneNumber)
              ChatItemBuilder(chatModel: chats[index])
          ),
    );
  }
}