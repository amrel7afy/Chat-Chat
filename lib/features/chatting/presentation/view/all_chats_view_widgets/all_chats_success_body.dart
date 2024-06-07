import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';

import '../../../../../core/AppRouter.dart';
import '../../../../../core/di/locator.dart';
import 'chat_item_builder.dart';

class ChatSuccessBody extends StatelessWidget {
  final List<UserModel> chats;

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

                   Navigator.pushNamed(context, AppRouter.messagingView,
              arguments: locator<SharedRepository>().userChats[index]
          );

              },
              child:
              // Text(chats[index].phoneNumber)
              ChatItemBuilder(chatModel: chats[index])
          ),
    );
  }
}